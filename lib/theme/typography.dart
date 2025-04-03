import 'package:flutter/material.dart';
import 'package:seeker_flutter/theme/colors.dart';

// Note: Flutter uses FontWeight constants instead of strings.
// We'll map the conceptual weights to Flutter's constants.

class AppTypography {
  static const String _fontFamily = 'System'; // Or specify a custom font family

  static const double _fontSizeXs = 12.0;
  static const double _fontSizeSm = 14.0;
  static const double _fontSizeMd = 16.0;
  static const double _fontSizeLg = 18.0;
  static const double _fontSizeXl = 20.0;
  static const double _fontSize2xl = 24.0;
  static const double _fontSize3xl = 30.0;
  static const double _fontSize4xl = 36.0;
  static const double _fontSize5xl = 48.0;

  // Flutter uses height multiplier, not absolute line height.
  // We calculate it based on fontSize and original lineHeight.
  static double _calculateHeight(double fontSize, double lineHeight) {
    return lineHeight / fontSize;
  }

  static const FontWeight _fontWeightNormal = FontWeight.w400;
  static const FontWeight _fontWeightMedium = FontWeight.w500;
  static const FontWeight _fontWeightSemibold = FontWeight.w600;
  static const FontWeight _fontWeightBold = FontWeight.w700;

  static TextStyle h1 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: _fontSize5xl,
    fontWeight: _fontWeightBold,
    height: _calculateHeight(_fontSize5xl, 60.0),
    color: AppColors.textPrimary,
  );

  static TextStyle h2 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: _fontSize4xl,
    fontWeight: _fontWeightBold,
    height: _calculateHeight(_fontSize4xl, 48.0),
    color: AppColors.textPrimary,
  );

  static TextStyle h3 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: _fontSize3xl,
    fontWeight: _fontWeightBold,
    height: _calculateHeight(_fontSize3xl, 40.0),
    color: AppColors.textPrimary,
  );

  static TextStyle h4 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: _fontSize2xl,
    fontWeight: _fontWeightBold,
    height: _calculateHeight(_fontSize2xl, 36.0),
    color: AppColors.textPrimary,
  );

  static TextStyle h5 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: _fontSizeXl,
    fontWeight: _fontWeightMedium,
    height: _calculateHeight(_fontSizeXl, 32.0),
    color: AppColors.textPrimary,
  );

  static TextStyle h6 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: _fontSizeLg,
    fontWeight: _fontWeightMedium,
    height: _calculateHeight(_fontSizeLg, 28.0),
    color: AppColors.textPrimary,
  );

  static TextStyle body1 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: _fontSizeMd,
    fontWeight: _fontWeightNormal,
    height: _calculateHeight(_fontSizeMd, 24.0),
    color: AppColors.textPrimary,
  );

  static TextStyle body2 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: _fontSizeSm,
    fontWeight: _fontWeightNormal,
    height: _calculateHeight(_fontSizeSm, 20.0),
    color: AppColors.textPrimary,
  );

  static TextStyle caption = TextStyle(
    fontFamily: _fontFamily,
    fontSize: _fontSizeXs,
    fontWeight: _fontWeightNormal,
    height: _calculateHeight(_fontSizeXs, 16.0),
    color: AppColors.textSecondary, // Captions often use secondary color
  );

  static TextStyle button = TextStyle(
    fontFamily: _fontFamily,
    fontSize: _fontSizeMd,
    fontWeight: _fontWeightMedium,
    height: _calculateHeight(_fontSizeMd, 24.0),
    color: AppColors.textPrimary, // Default button text color
  );

  // Helper method to easily create TextTheme for ThemeData
  static TextTheme get textTheme => TextTheme(
        displayLarge: h1, // M3 Headline Large maps roughly to H1
        displayMedium: h2, // M3 Headline Medium maps roughly to H2
        displaySmall: h3, // M3 Headline Small maps roughly to H3
        headlineMedium: h4, // M3 Title Large maps roughly to H4
        headlineSmall: h5, // M3 Title Medium maps roughly to H5
        titleLarge: h6, // M3 Title Small maps roughly to H6
        bodyLarge: body1,
        bodyMedium: body2,
        labelLarge: button, // M3 Label Large maps well to Button text
        bodySmall: caption,
      ).apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      );
}
