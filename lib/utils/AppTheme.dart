import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

class AppThemeData {
  //
  AppThemeData._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: whiteColor,
    primaryColor: primaryColor,
    primaryColorDark: primaryColor,
    hoverColor: Colors.grey,
    dividerColor: viewLineColor,
    fontFamily: GoogleFonts.poppins().fontFamily,
    appBarTheme: AppBarTheme(
      color: app_Background,
      iconTheme: IconThemeData(color: textPrimaryColor),
      systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
    ),
    cardTheme: CardThemeData(color: Colors.white),
    iconTheme: IconThemeData(color: textPrimaryColor),
    pageTransitionsTheme: PageTransitionsTheme(builders: {
      TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: whiteColor),
    cardColor: cardLightColor,
    textTheme: TextTheme(
      labelLarge: TextStyle(color: primaryColor),
      titleLarge: TextStyle(color: textPrimaryColor),
      titleSmall: TextStyle(color: textSecondaryColor),
    ), colorScheme: ColorScheme.light(
      primary: primaryColor,
      primaryContainer: primaryColor,
    ).copyWith(error: Colors.red),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: appBackgroundColorDark,
    highlightColor: appBackgroundColorDark,
    cardColor: cardDarkColor,
    appBarTheme: AppBarTheme(
      color: appBackgroundColorDark,
      iconTheme: IconThemeData(color: whiteColor),
      systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
    ),
    primaryColor: appBackgroundColorDark,
    dividerColor: Color(0xFFDADADA).withOpacity(0.3),
    primaryColorDark: color_primary_black,
    unselectedWidgetColor: appColorPrimaryDarkLight,
    hoverColor: Colors.black,
    pageTransitionsTheme: PageTransitionsTheme(builders: {
      TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
    fontFamily: GoogleFonts.poppins().fontFamily,
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: appBackgroundColorDark),
    primaryTextTheme: TextTheme(
      titleLarge: primaryTextStyle(color: Colors.white),
      labelSmall: primaryTextStyle(color: Colors.white),
    ),
    cardTheme: CardThemeData(color: cardBackgroundBlackDark),
    iconTheme: IconThemeData(color: whiteColor),
    textTheme: TextTheme(
      labelLarge: TextStyle(color: color_primary_black),
      titleLarge: TextStyle(color: whiteColor),
      titleSmall: TextStyle(color: Colors.white54),
    ), colorScheme: ColorScheme.light(
      primary: appBackgroundColorDark,
      onPrimary: cardBackgroundBlackDark,
      secondary: whiteColor,
      primaryContainer: color_primary_black,
    ).copyWith(error: Color(0xFFCF6676)),
  );
}
