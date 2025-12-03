import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffE18925),
      surfaceTint: Color(0xffE18925),
      onPrimary: Color(0xff04305f),
      primaryContainer: Color(0xff244777),
      onPrimaryContainer: Color(0xffd5e3ff),
      secondary: Color(0xffbdc7dc),
      onSecondary: Color(0xff273141),
      secondaryContainer: Color(0xff3d4758),
      onSecondaryContainer: Color(0xffd9e3f8),
      tertiary: Color(0xfffeb876),
      onTertiary: Color(0xff4b2800),
      tertiaryContainer: Color(0xff6a3b02),
      onTertiaryContainer: Color(0xffffdcbf),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xFF151D2A),
      onSurface: Color(0xffe1e2e9),
      onSurfaceVariant: Color(0xffc4c6cf),
      outline: Color(0xff8e9199),
      outlineVariant: Color(0xff43474e),
      shadow: Color(0xff244777),
      scrim: Color(0xff244777),
      inverseSurface: Color(0xffe1e2e9),
      inversePrimary: Color(0xff3e5f90),
      primaryFixed: Color(0xffd5e3ff),
      onPrimaryFixed: Color(0xff001b3c),
      primaryFixedDim: Color(0xffE18925),
      onPrimaryFixedVariant: Color(0xff244777),
      secondaryFixed: Color(0xffd9e3f8),
      onSecondaryFixed: Color(0xFF151D2A),
      secondaryFixedDim: Color(0xffbdc7dc),
      onSecondaryFixedVariant: Color(0xff3d4758),
      tertiaryFixed: Color(0xffffdcbf),
      onTertiaryFixed: Color(0xff2d1600),
      tertiaryFixedDim: Color(0xfffeb876),
      onTertiaryFixedVariant: Color(0xff6a3b02),
      surfaceDim: Color(0xff111318),
      surfaceBright: Color(0xff37393e),
      surfaceContainerLowest: Color(0xFF151D2A),
      surfaceContainerLow: Color(0xff1C222E),
      surfaceContainer: Color(0xFF15222E),
      surfaceContainerHigh: Color(0xff1C2735),
      surfaceContainerHighest: Color(0xff33353a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
    iconTheme: IconThemeData(
      color: Color(0xffE18925),
    ),
  );
}
