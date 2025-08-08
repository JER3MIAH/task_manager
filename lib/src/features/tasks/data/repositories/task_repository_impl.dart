import 'package:task_manager/src/features/tasks/data/datasources/datasources.dart';
import 'package:task_manager/src/features/tasks/data/models/requests/edit_task_request.dart';
import 'package:task_manager/src/features/tasks/domain/entities/entities.dart';
import 'package:task_manager/src/features/tasks/domain/repositories/repositories.dart';

class TaskRepositoryImpl extends TaskRepository {
  final TaskLocalDatasource localDatasource;
  TaskRepositoryImpl({required this.localDatasource});
  @override
  Future<void> addTask(Task task) {
    return localDatasource.createTask(task.toModel());
  }

  @override
  Future<void> deleteTask(String id) {
    return localDatasource.deleteTask(id);
  }

  @override
  Future<void> editTask(EditTaskRequest request) {
    return localDatasource.editTask(request);
  }

  @override
  Future<List<Task>> getTasks() {
    return localDatasource.getTasks();
  }
}
