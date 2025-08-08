import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/src/core/theme/colors.dart';
import 'package:task_manager/src/features/navigation/app_navigator.dart';
import 'package:task_manager/src/features/tasks/data/models/requests/edit_task_request.dart';
import 'package:task_manager/src/features/tasks/domain/entities/entities.dart';
import 'package:task_manager/src/features/tasks/presentation/providers/task_provider.dart';
import 'package:task_manager/src/features/tasks/presentation/widgets/date_selection_container.dart';
import 'package:task_manager/src/shared/shared.dart';

class CreateOrEditTaskScreen extends HookConsumerWidget {
  final Task? task;
  const CreateOrEditTaskScreen({super.key, this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final taskNotifier = ref.watch(taskProvider) as TaskNotifier;
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final titleController = useTextEditingController(text: task?.title);
    final descriptionController = useTextEditingController(
      text: task?.description,
    );

    final selectedDueDate = useState<DateTime?>(task?.dueDate);
    final selectedPriority = useState<TaskPriority>(
      task?.priority ?? TaskPriority.low,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primary,
        leading: BackButton(color: appColors.white),
        centerTitle: true,
        title: AppText(
          '${task == null ? 'Add' : 'Edit'} Task',
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: appColors.white,
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15,
              children: [
                AppTextField(
                  controller: titleController,
                  labelText: 'Title',
                  hintText: 'e.g. Buy Groceries',
                ),
                AppTextField(
                  multiLine: true,
                  controller: descriptionController,
                  labelText: 'Description',
                  hintText:
                      'e.g. Get groceries at the store before the end of the day.',
                ),

                AppDropdown(
                  labelText: 'Priority',
                  items: TaskPriority.values.map((p) => p.name).toList(),
                  initialSelectedValue: selectedPriority.value.name,
                  onChanged: (value) {
                    selectedPriority.value = value.toTaskPriority();
                  },
                ),
                _DueDateTile(
                  dateText: selectedDueDate.value == null
                      ? 'Select due date'
                      : formatDate(
                          selectedDueDate.value!,
                          format: 'dd MMM, yyyy',
                        ),
                  onTap: () {
                    AppDialog.dialog(
                      context,
                      DateSelectionContainer(
                        selectedDate: selectedDueDate,
                        onSelected: () {},
                      ),
                    );
                  },
                ),
                YBox(15),
                AppButton(
                  expanded: true,
                  title: task == null ? 'Create Task' : 'Save Changes',
                  onTap: () {
                    if (!formKey.currentState!.validate()) return;
                    if (task == null) {
                      taskNotifier.addTask(
                        Task(
                          id: getUniqueId(),
                          createdAt: DateTime.now(),
                          title: titleController.text.trim(),
                          description: descriptionController.text.trim(),
                          dueDate: selectedDueDate.value,
                          priority: selectedPriority.value,
                        ),
                      );
                    } else {
                      taskNotifier.editTask(
                        EditTaskRequest(
                          id: task!.id,
                          title: titleController.text.trim(),
                          description: descriptionController.text.trim(),
                          dueDate: selectedDueDate.value,
                          priority: selectedPriority.value,
                        ),
                      );
                    }
                    AppNavigator(context).popDialog();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DueDateTile extends StatelessWidget {
  final String dateText;
  final VoidCallback onTap;
  const _DueDateTile({required this.dateText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText('Due date', fontSize: 12),
        const SizedBox(height: 7),
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: BorderSide(
              color: theme.inversePrimary.withValues(alpha: .25),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          onTap: onTap,
          minVerticalPadding: 0,
          minLeadingWidth: 0,
          minTileHeight: 40,
          title: AppText(
            dateText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: theme.onSurface,
          ),
          trailing: Icon(Icons.calendar_month, color: theme.onSurface),
        ),
      ],
    );
  }
}
