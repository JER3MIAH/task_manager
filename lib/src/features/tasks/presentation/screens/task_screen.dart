import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/src/core/theme/colors.dart';
import 'package:task_manager/src/features/navigation/app_navigator.dart';
import 'package:task_manager/src/features/navigation/routes.dart';
import 'package:task_manager/src/features/tasks/data/models/requests/edit_task_request.dart';
import 'package:task_manager/src/features/tasks/presentation/providers/providers.dart';
import 'package:task_manager/src/features/tasks/presentation/widgets/task_tile.dart';
import 'package:task_manager/src/shared/widgets/widgets.dart';

class TaskScreen extends ConsumerWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final nav = AppNavigator(context);
    final taskNotifier = ref.watch(taskProvider) as TaskNotifier;
    final tasks = taskNotifier.tasks;

    void onCreateTask() {
      nav.pushNamed(AppRoutes.createOrEditTask);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: AppText(
          'Task Manager',
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: appColors.white,
        ),
        backgroundColor: theme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Builder(
          builder: (_) {
            if (tasks.isEmpty) {
              return EmptyTaskListContainer(onCreate: onCreateTask);
            }
            return ListView.separated(
              separatorBuilder: (_, __) => YBox(10),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return TaskTile(
                  task: task,
                  onView: () {
                    nav.pushNamed(AppRoutes.viewTask, args: task);
                  },
                  onEdit: () {
                    nav.pushNamed(AppRoutes.createOrEditTask, args: task);
                  },
                  onDelete: () {
                    taskNotifier.deleteTask(task.id);
                  },
                  onTap: () {
                    taskNotifier.editTask(
                      EditTaskRequest(id: task.id, completed: !task.completed),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onCreateTask,
        shape: CircleBorder(),
        backgroundColor: theme.primary,
        child: Icon(Icons.add, color: appColors.white),
      ),
    );
  }
}

class EmptyTaskListContainer extends StatelessWidget {
  final VoidCallback onCreate;
  const EmptyTaskListContainer({super.key, required this.onCreate});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colorScheme.primaryFixed,
        border: Border.all(color: colorScheme.inversePrimary),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Wrap(
        children: [
          AppText(
            'You currently have no tasks. Create a new task to get started.',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: appColors.white,
          ),
          GestureDetector(
            onTap: onCreate,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: appColors.white)),
                ),
                child: AppText(
                  'Create new task',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: appColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
