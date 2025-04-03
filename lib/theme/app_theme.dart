import 'package:flutter/material.dart';
import 'package:seeker_flutter/theme/colors.dart';
import 'package:seeker_flutter/theme/spacing.dart';
import 'package:seeker_flutter/theme/typography.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: AppColors.primary,
      primaryColor: AppColors.primary[500],
      scaffoldBackgroundColor: AppColors.backgroundPrimary,
      fontFamily: AppTypography._fontFamily, // Ensure this is correctly set
      textTheme: AppTypography.textTheme,

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundPrimary,
        foregroundColor: AppColors.textPrimary,
        elevation: 0, // Consistent with minimal design
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        titleTextStyle: AppTypography.h6.copyWith(color: AppColors.textPrimary),
      ),

      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.primary[500],
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.radiusMd,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.space3, 
          horizontal: AppSpacing.space4,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary[500],
          foregroundColor: AppColors.textInverse,
          textStyle: AppTypography.button.copyWith(color: AppColors.textInverse),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.radiusMd,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.space3, 
            horizontal: AppSpacing.space4,
          ),
          elevation: 2, // Default elevation
        ).copyWith(
          // Disabled state
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return AppColors.primary[200]; // Lighter primary for disabled
              }
              return AppColors.primary[500]; // Use the component's default.
            },
          ),
           foregroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return AppColors.textInverse.withOpacity(0.7);
              }
              return AppColors.textInverse; // Use the component's default.
            },
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary[500],
          textStyle: AppTypography.button.copyWith(color: AppColors.primary[500]),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.radiusMd,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.space3, 
            horizontal: AppSpacing.space4,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: false, // Usually have transparent background or defined by container
        // fillColor: AppColors.backgroundSecondary, 
        contentPadding: const EdgeInsets.symmetric(
          vertical: AppSpacing.space3, // Adjust as needed
          horizontal: AppSpacing.space4,
        ),
        border: OutlineInputBorder(
          borderRadius: AppRadius.radiusMd,
          borderSide: const BorderSide(color: AppColors.borderLight, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.radiusMd,
          borderSide: const BorderSide(color: AppColors.borderLight, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.radiusMd,
          borderSide: BorderSide(color: AppColors.primary[500]!, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.radiusMd,
          borderSide: const BorderSide(color: AppColors.error, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppRadius.radiusMd,
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        labelStyle: AppTypography.body1.copyWith(color: AppColors.textSecondary),
        hintStyle: AppTypography.body1.copyWith(color: AppColors.textTertiary),
        errorStyle: AppTypography.caption.copyWith(color: AppColors.error),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.borderLight,
        thickness: 1.0,
        space: 1.0, // Minimal space around the divider itself
      ),

      // Add other theme customizations here (e.g., CardTheme, ChipTheme)
      cardTheme: CardTheme(
        elevation: 1, // Subtle elevation
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.radiusLg, // Slightly larger radius for cards
          side: const BorderSide(color: AppColors.borderLight, width: 0.5), // Optional subtle border
        ),
        color: AppColors.backgroundPrimary,
        margin: EdgeInsets.zero, // Control margin where card is used
      ),

      chipTheme: ChipThemeData(
        backgroundColor: AppColors.neutral[100],
        labelStyle: AppTypography.body2.copyWith(color: AppColors.textPrimary),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space3, vertical: AppSpacing.space1),
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.radiusFull,
          side: const BorderSide(color: AppColors.borderLight, width: 0.5),
        ),
      ),

      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: AppColors.primary,
        accentColor: AppColors.secondary[500],
        backgroundColor: AppColors.backgroundPrimary,
        errorColor: AppColors.error,
        brightness: Brightness.light,
      ).copyWith(
        // Override specific colors if needed
        primary: AppColors.primary[500],
        secondary: AppColors.secondary[500],
        surface: AppColors.backgroundPrimary,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onSurface: AppColors.textPrimary,
        onError: AppColors.white,
        background: AppColors.backgroundPrimary,
      ),
    );
  }

  // Define a dark theme if needed later
  // static ThemeData get darkTheme { ... }
}
