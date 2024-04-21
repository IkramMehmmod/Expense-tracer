import 'package:flutter/material.dart';
import 'package:app3/widgets/expenses.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));
    var kDarkColor = 
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 5, 99, 125),
    brightness: Brightness.dark);
void main() {
 
    runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColor,
        cardTheme: const CardTheme().copyWith(
            color: kDarkColor.secondaryContainer,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
           elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColor.primaryContainer,
            ),
          ),
      ),
        theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
          ),
          //This theme is for all the card that are used in the project attional styling can also be done separatly in each car
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          //this theme can be used for all the elevated Buttons that are used in the project 
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer,
            ),
          ),
          // this theme is used for all the text in this project
          textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
              color: kColorScheme.onSecondaryContainer,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            )
          )
        ),
        themeMode: ThemeMode.system,
        home: const Expenses()),
  );
}
