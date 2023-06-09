import 'package:flutter/material.dart';

import 'theme_colors.dart';

ThemeData myTheme=ThemeData(
  primarySwatch: ThemeColors.primaryColor,
  primaryColor: ThemeColors.primaryColor,
  brightness: Brightness.dark,
  //fontFamily: ''
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
        fontSize: 16,
      ),
      bodyLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ), 
  )
);