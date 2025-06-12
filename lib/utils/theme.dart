import 'package:coursera/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: prefer_function_declarations_over_variables
final customTheme = (BuildContext context, Brightness brightness) => ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor, brightness: brightness),
    useMaterial3: true,
    brightness: brightness,
    textTheme: GoogleFonts.montserratTextTheme(),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.backgroundColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        // borderSide: BorderSide(width: 1, color: Colors.white10),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: AppColors.primaryColor,
            foregroundColor: AppColors.backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)))),
    filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
            textStyle: Theme.of(context).textTheme.bodyLarge,
            backgroundColor: AppColors.primaryColor,
            minimumSize: const Size(0, 46),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)))));
