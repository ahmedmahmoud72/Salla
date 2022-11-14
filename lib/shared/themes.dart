import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData theme = ThemeData(
fontFamily:'Oswald' ,
scaffoldBackgroundColor: Colors.white,
appBarTheme: const AppBarTheme(
  iconTheme: IconThemeData(
    color: Colors.black
  ),
titleSpacing: 20.0,
backgroundColor: Colors.white,
elevation: 0.0,
actionsIconTheme: IconThemeData(color: Colors.black),
systemOverlayStyle: SystemUiOverlayStyle(
statusBarColor: Colors.white,
statusBarIconBrightness: Brightness.dark,
),
titleTextStyle: TextStyle(
color: Colors.black,
fontSize: 25.0,
fontWeight: FontWeight.bold),
centerTitle: true,
),
bottomNavigationBarTheme: const BottomNavigationBarThemeData(
type: BottomNavigationBarType.fixed,
),
textTheme: const TextTheme(
bodyText1: TextStyle(
color: Colors.black,
fontWeight: FontWeight.bold,
fontSize: 18.0)));

ThemeData darkTheme = ThemeData(
    fontFamily:'Oswald' ,
    scaffoldBackgroundColor: HexColor('333739'),
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      backgroundColor: HexColor('333739'),
      elevation: 0.0,
      actionsIconTheme: const IconThemeData(color: Colors.white),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light,
      ),
      titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 25.0,
          fontWeight: FontWeight.bold),
      centerTitle: true,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: HexColor('333739'),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey),
    textTheme: const TextTheme(
        bodyText1: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.0)));
