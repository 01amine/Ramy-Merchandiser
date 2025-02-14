// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

const kCornerRadius = 20.0;
const kCornerInputRadius = 8.00;
const kCornerButtonRadius = 20.0;

class AppTheme {
  /// [TextTheme] for light theme mode , here we can define all the text styles
  static TextTheme lightTextTheme = const TextTheme(
    bodyLarge: TextStyle(
      color: kPrimaryColor,
      fontSize: 44,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.22,
      fontFamily: 'Inter',
    ),
    bodyMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.22,
        fontFamily: 'Inter',
        color: Colors.black),
    bodySmall: TextStyle(
      fontSize: 15,
      color: Color.fromARGB(255, 191, 187, 187),
      fontWeight: FontWeight.w400,
      letterSpacing: 0.22,
      fontFamily: 'Inter',
    ),
    displaySmall: TextStyle(
      fontSize: 14,
      color: kBlack,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter',
    ),
    titleMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.22,
      color: kLightGrey,
      fontFamily: 'Inter',
    ),
  );

  ///
  /// [Color] for light theme mode , here we can define all the colors
  /// [primaryLightColor] is used for [MaterialColor] which is used for [primarySwatch] in [ThemeData]
  ///
  ///

  static Map<int, Color> primaryLightColor = {
    50: const Color.fromRGBO(7, 141, 238, .1),
    100: const Color.fromRGBO(7, 141, 238, .2),
    200: const Color.fromRGBO(7, 141, 238, .3),
    300: const Color.fromRGBO(7, 141, 238, .4),
    400: const Color.fromRGBO(7, 141, 238, .5),
    500: const Color.fromRGBO(7, 141, 238, .6),
    600: const Color.fromRGBO(7, 141, 238, .7),
    700: const Color.fromRGBO(7, 141, 238, .8),
    000: const Color.fromRGBO(7, 141, 238, .9),
    900: const Color.fromRGBO(7, 141, 238, 1),
  };

  ///
  static AppBar appBar(
      {required String title,
      required Color? backgroundColor,
      Color? color,
      bool showBackButton = true,
      required BuildContext context}) {
    return AppBar(
      backgroundColor: backgroundColor,
      leading: showBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back_ios, size: 24, color: color),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null,
      title: Text(
        title,
        style: AppTheme.lightTextTheme.titleMedium!.copyWith(color: color),
      ),
      centerTitle: true,
    );
  }

  static ButtonStyle filledElevatedButton = FilledButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    backgroundColor: kPrimaryColor,
    foregroundColor: kWhite,
    elevation: 5,
  );
  static ButtonStyle curvedFilledElevatedButton = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    backgroundColor: kPrimaryColor,
    foregroundColor: kWhite,
    elevation: 5,
  );
  static ButtonStyle emptyCurvedElevatedButton = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    backgroundColor: kWhite,
    side: const BorderSide(
      color: kPrimaryColor,
    ),
  );
  static ButtonStyle outlinedButton = OutlinedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    backgroundColor: kWhite,
    foregroundColor: kPrimaryColor,
    side: const BorderSide(color: kPrimaryColor, width: 1),
  );
  static ButtonStyle filleRoundeddButton = ButtonStyle(
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.symmetric(
        horizontal: 15,
      ),
    ),
    alignment: Alignment.center,
    backgroundColor: WidgetStateProperty.all<Color>(
      kPrimaryColor,
    ),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
  );

  /// [ThemeDate] here we can define all the theme data for light theme mode

  static ThemeData light() {
    return ThemeData(
        brightness: Brightness.light,
        useMaterial3: false,
        textTheme: AppTheme.lightTextTheme,
        primaryColor: kPrimaryColor,
        shadowColor: Colors.black.withOpacity(0.05),
        primarySwatch: MaterialColor(
          0xff078DEE,
          AppTheme.primaryLightColor,
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.transparent,
          elevation: 0,
        ),
        scaffoldBackgroundColor: kScaffoldLightBackgroundColor,
        dividerColor: kInputBorderLightColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
          foregroundColor: kIconLightColor,
          centerTitle: true,
          toolbarHeight: 70,
          titleTextStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: kTitleLightColor,
            letterSpacing: -0.4,
            fontFamily: 'Inter',
          ),
          iconTheme: IconThemeData(
            color: kTitleLightColor,
            size: 24,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: kPrimaryColor,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: kPrimaryColor,
          backgroundColor: Colors.white,
          // unselectedItemColor: kThinTextLightColor,
        ),
        iconTheme: const IconThemeData(
          color: kIconLightColor,
          size: 25,
        ),
        buttonTheme: const ButtonThemeData(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            elevation: WidgetStateProperty.all(16),
            splashFactory: NoSplash.splashFactory,
            backgroundColor: WidgetStateProperty.all(kWhite),
            overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(vertical: 15),
            ),
            side: WidgetStateProperty.all(
              BorderSide(width: 1, color: kGrey),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    kCornerButtonRadius,
                  ),
                ),
              ),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              const RoundedRectangleBorder(
                side: BorderSide(
                  color: kInputBorderLightColor,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    kCornerButtonRadius,
                  ),
                ),
              ),
            ),
            side: WidgetStateProperty.all(
              const BorderSide(color: kPrimaryColor),
            ),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 21, vertical: 20),
          errorMaxLines: 2,
          labelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: kInputLabelColor,
            fontFamily: 'Inter',
          ),
          fillColor: Colors.white,
          filled: true,
          floatingLabelStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: kPrimaryColor,
            fontFamily: 'Inter',
          ),
          iconColor: kInputBorderLightColor,
          hintStyle: TextStyle(
            color: kInputBorderLightColor,
            fontSize: 16,
            fontWeight: FontWeight.w100,
            letterSpacing: -0.4,
            fontFamily: 'Inter',
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                kCornerInputRadius,
              ),
            ),
            borderSide: BorderSide(
              color: kErrorColor,
              width: 1.0,
            ),
          ),
          errorStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: kErrorColor,
            fontFamily: 'Inter',
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: kInputLightColor,
              style: BorderStyle.solid,
              width: 1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                kCornerInputRadius,
              ),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kInputBorderLightColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                kCornerInputRadius,
              ),
            ),
          ),
          focusColor: kInputLabelColor,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kInputLabelColor,
              width: 1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                kCornerInputRadius,
              ),
            ),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kCornerRadius),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.white,
            fontFamily: 'Inter',
          ),
        )));
  }

  static Color getSoftTextColor(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.7);
  }

  static Color getTextColorOnBackground(Brightness brightness) {
    if (brightness == Brightness.light) {
      return Colors.white;
    } else {
      return Colors.white;
    }
  }
}
