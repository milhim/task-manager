import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/app/logic/app_settings.dart';
import 'package:task_manager/app/theme/app_colors.dart';
import 'package:task_manager/core/utils/managers/database/database_manager.dart';
import 'package:task_manager/features/auth/presentation/pages/login_page.dart';
import 'package:task_manager/features/task_management/presentation/pages/home_page.dart';
import './features/injection.dart' as injection;
import './features/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injection.init();
  await serviceLocator<DatabaseManager>().openBox();

  runApp(ScreenUtilInit(
    designSize: const Size(428, 926),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue),
        useMaterial3: true,
      ),
      home: serviceLocator<AppSettings>().token == '' ? const LoginPage() : const HomePage(),
    );
  }
}