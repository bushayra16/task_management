import 'package:flutter/material.dart';
import 'package:task_management/ui/Screens/Splash_screen.dart.dart';
import 'package:task_management/ui/utils/app_colors.dart';

class TaskManagementApp extends StatefulWidget {
  const TaskManagementApp({super.key});
 static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManagementApp> createState() => _TaskManagementAppState();
}

class _TaskManagementAppState extends State<TaskManagementApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: TaskManagementApp.navigatorKey,
      theme: ThemeData(
        colorSchemeSeed: AppColors.themeColor,
        textTheme: TextTheme(),
        inputDecorationTheme: _inputDecorationTheme(),
        elevatedButtonTheme: _elevatedButtonTheme(),
      ),
      home: const SplashScreen(),
    );
  }
}

ElevatedButtonThemeData _elevatedButtonTheme () {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        fixedSize: const Size.fromWidth(double.maxFinite),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
        )
    ),
  );
}

InputDecorationTheme _inputDecorationTheme () {
  return InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      hintStyle: const TextStyle(
        fontWeight: FontWeight.w300
      ),
      border:  _inputBorder(),
      enabledBorder: _inputBorder(),
      errorBorder:  _inputBorder(),
      focusedBorder:  _inputBorder()
  );
}
OutlineInputBorder _inputBorder () {
return OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(8)
);
}



