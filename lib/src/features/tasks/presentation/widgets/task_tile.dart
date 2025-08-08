import 'package:flutter/material.dart';
import 'package:task_manager/src/features/tasks/domain/entities/entities.dart';
import 'package:task_manager/src/shared/widgets/widgets.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onTap, onEdit, onView, onDelete;
  const TaskTile({
    super.key,
    required this.task,
    required this.onTap,
    required this.onEdit,
    required this.onView,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final style = TextStyle(fontSize: 13, fontWeight: FontWeight.w400);
    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          width: task.completed ? 2 : 1,
          color: task.completed
              ? theme.primary
              : theme.primary.withValues(alpha: .5),
        ),
      ),
      title: AppText(task.title, fontSize: 17),
      subtitle: AppText(task.description, color: theme.inversePrimary),
      leading: Radio(
        value: task.completed,
        groupValue: true,
        onChanged: (_) => onTap(),
      ),
      trailing: PopupMenuButton<Widget>(
        padding: EdgeInsets.zero,
        position: PopupMenuPosition.under,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: theme.surface,
        itemBuilder: (_) {
          return [
            PopupMenuItem(
              onTap: onView,
              child: Text('View', style: style),
            ),
            PopupMenuItem(
              onTap: onEdit,
              child: Text('Edit', style: style),
            ),
            PopupMenuItem(
              onTap: onDelete,
              child: Text('Delete', style: style.copyWith(color: theme.error)),
            ),
          ];
        },
        child: Icon(Icons.more_vert),
      ),
    );
  }
}
