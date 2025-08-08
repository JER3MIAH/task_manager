import 'package:flutter/material.dart';
import 'package:task_manager/src/app.dart';
import 'package:task_manager/src/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppInjectionContainer.init();
  await Future.delayed(const Duration(milliseconds: 600));
  runApp(const MyApp());
}
