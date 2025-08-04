import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/invitation.dart';
import '../models/user.dart';
import '../providers/admin_provider.dart';
import '../services/analytics_service.dart';

/// Administrative page that allows managing users and invitations.
class AdminUsersPage extends StatefulWidget {
  const AdminUsersPage({super.key});

  @override
  State<AdminUsersPage> createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage> {
  final TextEditingController _searchController = TextEditingController();
  final Set<String> _selected = {};
  final AnalyticsService _analytics = AnalyticsService();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final admin = context.watch<AdminProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
        actions: [
          if (_selected.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                for (final id in _selected) {
                  await admin.deleteUser(id);
                }
                setState(() => _selected.clear());
              },
            ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search users',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Users',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            StreamBuilder<List<User>>(
              stream: admin.users,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final users = snapshot.data!;
                final filtered = users
                    .where((u) => u.name
                        .toLowerCase()
                        .contains(_searchController.text.toLowerCase()))
                    .toList();
                final stats = _analytics.buildUserStats(users);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Total: ${stats.totalUsers} • Admins: ${stats.adminCount} • Leaders: ${stats.leaderCount} • Assistants: ${stats.assistantCount}',
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final user = filtered[index];
                        return ListTile(
                          leading: Checkbox(
                            value: _selected.contains(user.id),
                            onChanged: (checked) {
                              setState(() {
                                if (checked == true) {
                                  _selected.add(user.id);
                                } else {
                                  _selected.remove(user.id);
                                }
                              });
                            },
                          ),
                          title: Text(user.name),
                          subtitle:
                              Text(user.roles.map((r) => r.name).join(', ')),
                          trailing: PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'edit') {
                                _editRoles(context, admin, user);
                              } else if (value == 'delete') {
                                admin.deleteUser(user.id);
                              }
                            },
                            itemBuilder: (context) => const [
                              PopupMenuItem(
                                  value: 'edit', child: Text('Edit Roles')),
                              PopupMenuItem(
                                  value: 'delete', child: Text('Delete')),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Invitations',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            StreamBuilder<List<Invitation>>(
              stream: admin.invitations,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final invites = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: invites.length,
                  itemBuilder: (context, index) {
                    final invitation = invites[index];
                    return ListTile(
                      title: Text(invitation.email),
                      subtitle:
                          Text(invitation.roles.map((r) => r.name).join(', ')),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.check),
                            onPressed: () =>
                                _acceptInvite(context, admin, invitation),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () =>
                                admin.declineInvitation(invitation.id),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _editRoles(
      BuildContext context, AdminProvider admin, User user) async {
    final selected = Set<UserRole>.from(user.roles);
    final result = await showDialog<Set<UserRole>>(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text('Edit Roles'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: UserRole.values.map((role) {
                return CheckboxListTile(
                  value: selected.contains(role),
                  title: Text(role.name),
                  onChanged: (checked) {
                    setState(() {
                      if (checked == true) {
                        selected.add(role);
                      } else {
                        selected.remove(role);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, selected),
                child: const Text('Save'),
              ),
            ],
          );
        });
      },
    );
    if (result != null) {
      await admin.updateUserRoles(user.id, result);
    }
  }

  void _acceptInvite(
      BuildContext context, AdminProvider admin, Invitation invitation) async {
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New User Name'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Accept'),
          ),
        ],
      ),
    );
    if (name != null && name.isNotEmpty) {
      await admin.acceptInvitation(invitation.id, name);
    }
  }
}
