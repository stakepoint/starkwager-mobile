import 'package:flutter/material.dart';
import 'package:starkwager/core/constants/screen_layout.dart';

import '../theme/app_colors.dart';

extension ThemeModeExtension on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  bool get isMobile => ScreenLayout.isMobile(this);
  bool get isTablet => ScreenLayout.isTablet(this);
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  Color get primaryBackgroundColor =>
      isDarkMode ? AppColors.grayCool900 : AppColors.mono0;

  Color get secondaryBackgroundColor =>
      isDarkMode ? AppColors.mono100 : AppColors.mono20;

  Color get secondaryWidgetColor =>
      isDarkMode ? AppColors.mono90 : AppColors.mono0;

  Color get primaryTextColor =>
      isDarkMode ? AppColors.white : AppColors.blue950;

  Color get secondaryTextColor =>
      isDarkMode ? AppColors.mono40 : AppColors.grayCool100;

  Color get subTitleTextColor =>
      isDarkMode ? AppColors.grayCool25 : AppColors.grayCool600;

  Color get successColor =>
      isDarkMode ? AppColors.success500 : AppColors.success500;

  Color get textBoxTextColor =>
      isDarkMode ? AppColors.gradient40 : AppColors.grayCool100;

  Color get buttonTextColor =>
      isDarkMode ? AppColors.tabSelectedColor : AppColors.tabSelectedColor;

  Color get dividerColor =>
      isDarkMode ? AppColors.mono80 : AppColors.dividerColour;

  Color get containerColor =>
      isDarkMode ? AppColors.grayNeutral800 : AppColors.white;
  // AppColors.gradient40

  Color get tabSelectedBackgroundColor =>
      isDarkMode ? AppColors.white : AppColors.tabSelectedColor;

  Color get tabUnselectedBackgroundColor =>
      isDarkMode ? AppColors.gradient40 : AppColors.tabUnselectedColor;

  Color get primaryButtonColor =>
      isDarkMode ? AppColors.buttonColor : AppColors.buttonColor;

  Color get textHintColor =>
      isDarkMode ? AppColors.grayNeutral500 : AppColors.grayCool400;

  Color get avatarBgColor =>
      isDarkMode ? AppColors.grayCool200 : AppColors.grayCool200;

  Color get uploadDialog =>
      isDarkMode ? AppColors.grayNeutral800 : AppColors.white;

  Color get rotateColor => isDarkMode ? AppColors.white : AppColors.grayCool100;

  Color get textField =>
      isDarkMode ? AppColors.grayNeutral700 : AppColors.grayCool100;

  Color get snapProofColor => isDarkMode ? AppColors.white : AppColors.mono0;

  Color get menuBackgroundColor =>
      isDarkMode ? AppColors.grayCool800 : AppColors.grayCool800;
  Color get error => isDarkMode ? AppColors.rambutan100 : AppColors.rambutan100;

  Color get menuTextColor =>
      isDarkMode ? AppColors.grayNeutral500 : AppColors.grayNeutral500;

  Color get transparentColor => Colors.transparent;

  Color get tabTextColor =>
      isDarkMode ? AppColors.primaryColor : AppColors.white;

  Color get iconColor => isDarkMode ? AppColors.white : AppColors.primaryColor;

  Color get unselectedTabTextColor =>
      isDarkMode ? AppColors.white : AppColors.primaryColor;

  Color get shadowColor => AppColors.black.withValues(alpha: 0.1);

  Color get sidebarBackgroundColor => AppColors.black;

  Color get menuShadowColor => AppColors.black.withValues(alpha: 0.2);

  // Dialog colors
  Color get dialogDarkBackground => AppColors.dialogDarkBackground;
  Color get cancelButtonLight => AppColors.cancelButtonLight;

  ThemeData get lightTheme => ThemeData.light().copyWith(
        scaffoldBackgroundColor: AppColors.mono0,
        colorScheme: Theme.of(this).colorScheme.copyWith(
              brightness: Brightness.light,
              primary: AppColors.primaryColor,
              error: AppColors.rambutan100,
            ),
        textTheme: Theme.of(this).textTheme.apply(
              bodyColor: AppColors.mono100,
            ),
      );

  ThemeData get darkTheme => ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.mono100,
        colorScheme: Theme.of(this).colorScheme.copyWith(
              brightness: Brightness.dark,
              primary: AppColors.primaryColor,
              error: AppColors.rambutan100,
            ),
        textTheme: Theme.of(this).textTheme.apply(
              bodyColor: AppColors.mono20,
            ),
      );
}
