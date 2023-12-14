import 'package:flutter/material.dart';
import 'package:meals/screens/home_screen.dart';
import 'package:meals/theme/theme.dart';

class MealsApp extends StatelessWidget {
  const MealsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: mealsAppTheme,
      home: const HomeScreen(),
    );
  }
}
