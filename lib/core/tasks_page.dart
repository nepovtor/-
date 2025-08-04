import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';
import 'widgets/bottom_nav.dart';
import '../services/notification_service.dart';

/// Displays a list of tasks that can be toggled complete/incomplete.
class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  Future<void> _addTask(BuildContext context) async {
    final descController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Task'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: descController,
            decoration: const InputDecoration(labelText: 'Description'),
            validator: (v) => v == null || v.isEmpty ? 'Required' : null,
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
                context
                    .read<TaskProvider>()
                    .addTask(Task(id: id, description: descController.text.trim()));
                await NotificationService().scheduleReminder(
                  id.hashCode,
                  'Task Reminder',
                  descController.text.trim(),
                  DateTime.now().add(const Duration(seconds: 5)),
                );
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
      appBar: AppBar(title: const Text('Tasks')),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 2),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, _) {
          final tasks = taskProvider.tasks;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return CheckboxListTile(
                title: Text(task.description),
                value: task.isCompleted,
                onChanged: (_) => taskProvider.toggleTask(task.id),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTask(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
