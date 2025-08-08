import 'package:task_manager/src/features/tasks/domain/entities/entities.dart';

class EditTaskRequest extends Request {
  final String id;
  final String? title;
  final String? description;
  final bool? completed;
  final TaskPriority? priority;
  final DateTime? dueDate;

  EditTaskRequest({
    required this.id,
    this.title,
    this.description,
    this.completed,
    this.priority,
    this.dueDate,
  });

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'completed': completed,
      'priority': priority?.name,
      'dueDate': dueDate?.millisecondsSinceEpoch,
    };
  }
}
