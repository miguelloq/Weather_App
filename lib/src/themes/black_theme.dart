import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme_colors.dart';

ThemeData blackTheme = ThemeData(
  primarySwatch: ThemeColors.primaryColor,
  primaryColor: ThemeColors.primaryColor,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.grey[900],
  fontFamily: GoogleFonts.ledger().fontFamily,
  textTheme: const TextTheme(
    titleLarge:  TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
    titleMedium:  TextStyle(fontWeight: FontWeight.bold),
    titleSmall:  TextStyle(fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontWeight: FontWeight.bold),
    bodySmall: TextStyle(fontWeight: FontWeight.bold),
  ),
);
