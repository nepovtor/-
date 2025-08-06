import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';
import 'widgets/bottom_nav.dart';
import '../services/notification_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
/// Displays a list of tasks that can be toggled complete/incomplete.
class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  Future<void> _addTask(BuildContext context) async {
    final descController = TextEditingController();
    final categoryController = TextEditingController();
    String repeat = 'none';
    int priority = 0;
    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Task'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                context.read<TaskProvider>().addTask(
                      Task(
                        id: id,
                        description: descController.text.trim(),
                        category: categoryController.text.trim(),
                        priority: priority,
                        repeatInterval: repeat,
                      ),
                    );
                if (repeat == 'none') {
                  await NotificationService().scheduleReminder(
                    id.hashCode,
                    'Task Reminder',
                    descController.text.trim(),
                    DateTime.now().add(const Duration(seconds: 5)),
                  );
                } else {
                  final interval =
                      repeat == 'daily' ? RepeatInterval.daily : RepeatInterval.weekly;
                  await NotificationService().scheduleRepeatingReminder(
                    id.hashCode,
                    'Task Reminder',
                    descController.text.trim(),
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
      appBar: AppBar(title: const Text('Tasks')),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 2),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, _) {
          final tasks = taskProvider.tasks;
          return ReorderableListView.builder(
            itemCount: tasks.length,
            onReorder: (oldIndex, newIndex) =>
                taskProvider.reorderTasks(oldIndex, newIndex),
            itemBuilder: (context, index) {
              final task = tasks[index];
              return CheckboxListTile(
                key: ValueKey(task.id),
                title: Text(task.description),
                subtitle: Text('${task.category} • Priority ${task.priority}'),
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
