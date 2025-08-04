import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';

/// Displays a list of tasks that can be toggled complete/incomplete.
class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final tasks = taskProvider.tasks;
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return CheckboxListTile(
            title: Text(task.description),
            value: task.isCompleted,
            onChanged: (_) => taskProvider.toggleTask(task.id),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final id = DateTime.now().millisecondsSinceEpoch.toString();
          context.read<TaskProvider>().addTask(
                Task(id: id, description: 'Task $id'),
              );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

