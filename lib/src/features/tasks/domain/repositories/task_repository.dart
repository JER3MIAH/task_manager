import 'package:task_manager/src/features/tasks/data/models/requests/edit_task_request.dart';
import 'package:task_manager/src/features/tasks/domain/entities/entities.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<void> addTask(Task task);
  Future<void> editTask(EditTaskRequest request);
  Future<void> deleteTask(String id);
}
