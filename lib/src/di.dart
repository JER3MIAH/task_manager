import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/src/features/tasks/data/datasources/datasources.dart';
import 'package:task_manager/src/features/tasks/data/repositories/task_repository_impl.dart';
import 'package:task_manager/src/features/tasks/domain/repositories/repositories.dart';
import 'package:task_manager/src/features/tasks/presentation/providers/task_provider.dart';

final sl = GetIt.instance;

class AppInjectionContainer {
  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => prefs);
    sl.registerLazySingleton<TaskLocalDatasource>(
      () => TaskLocalDatasource(prefs: prefs),
    );
    sl.registerLazySingleton<TaskRepository>(
      () => TaskRepositoryImpl(localDatasource: sl<TaskLocalDatasource>()),
    );
    sl.registerLazySingleton<TaskNotifier>(
      () => TaskNotifier(repository: sl<TaskRepository>()),
    );
  }
}
