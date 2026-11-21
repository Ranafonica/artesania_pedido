// ============================================================
// main.dart
// ------------------------------------------------------------
// El punto de entrada de toda aplicación Flutter.
// Aquí configuramos el tema global y la ruta inicial.
// ============================================================

import 'package:material_ui/material_ui.dart';
import 'package:the_newpage/core/app_theme.dart';
import 'package:the_newpage/views/home/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Artesano en Madera — Muebles y Puertas Personalizadas',
      debugShowCheckedModeBanner: false, // Quitamos el banner rojo de "debug"
      theme: AppTheme.theme,            // Usamos nuestro tema personalizado
      home: const HomeView(),
    );
  }
}