import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Pallete {
  // Colors
  static const blackColor = Color.fromRGBO(1, 1, 1, 1); // primary color
  static const greyColor = Color.fromRGBO(26, 39, 45, 1); // secondary color
  static const drawerColor = Color.fromRGBO(18, 18, 18, 1);
  static const whiteColor = Colors.white;
  static var redColor = Colors.red.shade500;
  static var blueColor = Colors.blue.shade300;

  // Themes
  static final darkModeAppTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: blackColor,
    cardColor: greyColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: drawerColor,
      iconTheme: IconThemeData(color: whiteColor),
    ),
    drawerTheme: const DrawerThemeData(backgroundColor: drawerColor),
    primaryColor: redColor,

    // 👇 Smooth page & drawer animations
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  static var lightModeAppTheme = ThemeData.light().copyWith(
    textTheme: GoogleFonts.poppinsTextTheme(),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue,
      elevation: 2,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      actionsIconTheme: const IconThemeData(color: Colors.white),
    ),
    drawerTheme: const DrawerThemeData(backgroundColor: whiteColor),
    primaryColor: Colors.blue,

    // 👇 Smooth page & drawer animations
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
