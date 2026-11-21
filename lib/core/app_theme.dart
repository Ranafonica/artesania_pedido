// ============================================================
// app_theme.dart
// ------------------------------------------------------------
// Este archivo es el "cerebro del diseño".
// Aquí definimos TODO lo que tiene que ver con colores,
// tipografías y estilos. Si algún día el cliente quiere
// cambiar el color principal, solo se toca este archivo.
// ============================================================

import 'package:material_ui/material_ui.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // ---- Paleta principal (inspirada en madera cálida) ----
  static const cream = Color(0xFFF5F0EA);       // Fondo principal
  static const warmWhite = Color(0xFFFAF8F5);   // Fondo alternativo
  static const darkBrown = Color(0xFF2C1810);   // Texto principal
  static const mediumBrown = Color(0xFF5C3D2E); // Marrón medio
  static const accentBrown = Color(0xFF8B5E3C); // Acento / hover
  static const lightWood = Color(0xFFD4A97A);   // Detalles cálidos
  static const textSecondary = Color(0xFF7A6355); // Texto secundario
  static const divider = Color(0xFFE8DDD5);     // Líneas divisorias
  static const overlayDark = Color(0xCC1A0D05); // Overlay sobre fotos
}

class AppTheme {
  // ----------------------------------------------------------------
  // Tipografías
  // Google Fonts descarga las fuentes automáticamente.
  // Usamos "Playfair Display" para títulos (elegante, editorial) y
  // "Inter" para el cuerpo del texto (legible, moderno).
  // ----------------------------------------------------------------

  static TextStyle get displayLarge => GoogleFonts.playfairDisplay(
    fontSize: 72,
    fontWeight: FontWeight.w700,
    color: AppColors.darkBrown,
    height: 1.0,
    letterSpacing: -1.5,
  );

  static TextStyle get displayMedium => GoogleFonts.playfairDisplay(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    color: AppColors.darkBrown,
    height: 1.1,
    letterSpacing: -0.5,
  );

  static TextStyle get headingLarge => GoogleFonts.playfairDisplay(
    fontSize: 36,
    fontWeight: FontWeight.w600,
    color: AppColors.darkBrown,
    height: 1.2,
  );

  static TextStyle get headingMedium => GoogleFonts.playfairDisplay(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.darkBrown,
    height: 1.3,
  );

  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  static TextStyle get labelLarge => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.darkBrown,
    letterSpacing: 1.5,
  );

  static TextStyle get navItem => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.darkBrown,
    letterSpacing: 0.3,
  );

  // ----------------------------------------------------------------
  // ThemeData — lo que le pasamos al MaterialApp
  // ----------------------------------------------------------------
  static ThemeData get theme => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.accentBrown,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: AppColors.cream,
    useMaterial3: true,
  );
}

// ----------------------------------------------------------------
// Constantes de espaciado
// Usar estos valores hace que el diseño sea consistente.
// ----------------------------------------------------------------
class AppSpacing {
  static const double xs = 8.0;
  static const double sm = 16.0;
  static const double md = 24.0;
  static const double lg = 40.0;
  static const double xl = 64.0;
  static const double xxl = 96.0;

  // Ancho máximo del contenido (como el sitio de referencia)
  static const double maxContentWidth = 1200.0;
  static const double navHeight = 72.0;
}
