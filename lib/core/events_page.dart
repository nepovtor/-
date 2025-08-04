import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/event.dart';
import '../providers/event_provider.dart';
import 'widgets/bottom_nav.dart';
import '../services/notification_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Displays a list of camp events.
class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  Future<void> _addEvent(BuildContext context) async {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    final categoryController = TextEditingController();
    String repeat = 'none';
    int priority = 0;
    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Event'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              DropdownButtonFormField<int>(
                value: priority,
                decoration: const InputDecoration(labelText: 'Priority'),
                items: const [
                  DropdownMenuItem(value: 0, child: Text('Low')),
                  DropdownMenuItem(value: 1, child: Text('Medium')),
                  DropdownMenuItem(value: 2, child: Text('High')),
                ],
                onChanged: (v) => priority = v ?? 0,
              ),
              DropdownButtonFormField<String>(
                value: repeat,
                decoration: const InputDecoration(labelText: 'Repeat'),
                items: const [
                  DropdownMenuItem(value: 'none', child: Text('None')),
                  DropdownMenuItem(value: 'daily', child: Text('Daily')),
                  DropdownMenuItem(value: 'weekly', child: Text('Weekly')),
                ],
                onChanged: (v) => repeat = v ?? 'none',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                final id = DateTime.now().millisecondsSinceEpoch.toString();
                context.read<EventProvider>().addEvent(
                      Event(
                        id: id,
                        title: titleController.text.trim(),
                        description: descController.text.trim(),
                        date: DateTime.now(),
                        category: categoryController.text.trim(),
                        priority: priority,
                        repeatInterval: repeat,
                      ),
                    );
                if (repeat == 'none') {
                  await NotificationService().scheduleReminder(
                    id.hashCode,
                    'Event Reminder',
                    titleController.text.trim(),
                    DateTime.now().add(const Duration(seconds: 5)),
                  );
                } else {
                  final interval =
                      repeat == 'daily' ? RepeatInterval.daily : RepeatInterval.weekly;
                  await NotificationService().scheduleRepeatingReminder(
                    id.hashCode,
                    'Event Reminder',
                    titleController.text.trim(),
                    interval,
                  );
                }
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 1),
      body: Consumer<EventProvider>(
        builder: (context, provider, _) {
          final events = provider.events;
          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return ListTile(
                title: Text(event.title),
                subtitle:
                    Text('${event.description}\n${event.category} • Priority ${event.priority}'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addEvent(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
