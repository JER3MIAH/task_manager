import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/src/core/theme/theme.dart';
import 'package:task_manager/src/features/navigation/nav.dart';
import 'package:task_manager/src/features/tasks/data/models/task.dart';
import 'package:task_manager/src/features/tasks/presentation/screens/screens.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Manager',
        theme: lightTheme,
        darkTheme: darkTheme,
        routes: {
          AppRoutes.home: (context) => TaskScreen(),
          AppRoutes.createOrEditTask: (context) => CreateOrEditTaskScreen(
            task: ModalRoute.of(context)?.settings.arguments as Task?,
          ),
          AppRoutes.viewTask: (context) => ViewTaskScreen(
            task: ModalRoute.of(context)?.settings.arguments as Task,
          ),
        },
        initialRoute: AppRoutes.home,
      ),
    );
  }
}
