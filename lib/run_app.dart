import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_company_app_new_2025/list_of_cubits/list_of_blocs.dart';
import 'package:task_company_app_new_2025/features/change_nav_bar/presentation/screens/button_nav_bar_screen.dart';

class RunApp extends StatelessWidget {
  const RunApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocsProviders,
      child: MaterialApp(
        title: 'Flutter Movie Application',
        debugShowCheckedModeBanner: false,
        home: ButtonNavBarScreen(),
      ),
    );
  }
}
