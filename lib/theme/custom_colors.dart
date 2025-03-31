import 'package:flutter/material.dart';

  class CustomColors extends ThemeExtension<CustomColors> {
    final Color? customBackgroundColor;
    final Color? customTextColor;

    CustomColors({
      this.customBackgroundColor,
      this.customTextColor,
    });

    @override
    CustomColors copyWith({
      Color? customBackgroundColor,
      Color? customTextColor,
    }) {
      return CustomColors(
        customBackgroundColor: customBackgroundColor ?? this.customBackgroundColor,
        customTextColor: customTextColor ?? this.customTextColor,
      );
    }

    @override
    CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
      if (other is! CustomColors) {
        return this;
      }
      return CustomColors(
        customBackgroundColor: Color.lerp(customBackgroundColor, other.customBackgroundColor, t),
        customTextColor: Color.lerp(customTextColor, other.customTextColor, t),
      );
    }
  }