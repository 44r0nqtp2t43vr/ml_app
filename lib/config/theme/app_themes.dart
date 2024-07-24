import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    // scaffoldBackgroundColor: const Color(0XFF275492),
    // fontFamily: 'Muli',
    appBarTheme: appBarTheme(),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Color(0XFF275492),
    elevation: 0,
    centerTitle: true,
  );
}
