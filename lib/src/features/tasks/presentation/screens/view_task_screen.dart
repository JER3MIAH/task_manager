import 'package:flutter/material.dart';
import 'package:task_manager/src/core/theme/colors.dart';
import 'package:task_manager/src/features/tasks/data/models/task.dart';
import 'package:task_manager/src/shared/utils/date_formatter.dart';
import 'package:task_manager/src/shared/widgets/widgets.dart';

class ViewTaskScreen extends StatelessWidget {
  final Task task;
  const ViewTaskScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.mainPurple,
        centerTitle: true,
        leading: BackButton(color: appColors.white),
        title: AppText(
          'View Task',
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: appColors.white,
        ),
      ),
      body: AppColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          YBox(16),
          Row(
            children: [
              Icon(Icons.calendar_today, color: Colors.grey[600], size: 20),
              const SizedBox(width: 8),
              Text(
                task.dueDate == null
                    ? 'No due date'
                    : formatDate(
                        task.dueDate!,
                        format: 'dd MMM yyyy',
                      ), // Due Date
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          YBox(16),
          Row(
            children: [
              Icon(Icons.flag, color: Colors.orange, size: 20),
              const SizedBox(width: 8),
              Text(
                'Priority: ', // Priority label
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                task.priority.name, // Priority value
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: switch (task.priority) {
                    TaskPriority.high => appColors.red,
                    TaskPriority.medium => Colors.orange,
                    TaskPriority.low => Colors.green,
                  },
                ),
              ),
            ],
          ),
          YBox(16),
          Row(
            children: [
              Icon(
                task.completed ? Icons.check_circle : Icons.cancel,
                color: task.completed ? Colors.green : appColors.red,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Completed: ', // Completed label
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                task.completed ? 'True' : 'False', // Completed value
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          YBox(24),
          Text(
            'Description',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          YBox(8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              task.description, // Description
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: appColors.black),
            ),
          ),
        ],
      ),
    );
  }
}
