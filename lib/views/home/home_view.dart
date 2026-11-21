// ============================================================
// home_view.dart
// ------------------------------------------------------------
// La vista principal que arma todas las secciones de la página.
//
// Concepto clave: ScrollController
// Es el "control remoto" del scroll. Lo creamos aquí y lo
// compartimos con la NavBar (para el efecto blur al scrollear)
// y con el body (para controlar el scroll programáticamente).
// ============================================================

import 'package:material_ui/material_ui.dart';
import 'package:the_newpage/core/app_theme.dart';
import 'package:the_newpage/widgets/hero_section/hero_section.dart';
import 'package:the_newpage/widgets/navigation_bar/navigation_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // ScrollController compartido entre la NavBar y el contenido
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      // Stack nos permite poner la NavBar flotante encima del contenido
      body: Stack(
        children: [
          // ---- CONTENIDO SCROLLEABLE ----
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Espacio para que la NavBar fija no tape el contenido
                // (la NavBar mide AppSpacing.navHeight = 72px)
                const HeroSection(),

                // ════════════════════════════════════════════════
                // PRÓXIMAS SECCIONES (las iremos construyendo):
                // - ServicesSection
                // - WorksGallerySection
                // - AboutSection
                // - ContactSection
                // ════════════════════════════════════════════════
                _PlaceholderSection(
                  label: '📦 Sección: Servicios\n(próximo paso)',
                  color: AppColors.warmWhite,
                ),
                _PlaceholderSection(
                  label: '🖼️ Sección: Galería de Trabajos\n(próximo paso)',
                  color: AppColors.cream,
                ),
                _PlaceholderSection(
                  label: '👤 Sección: Sobre mí\n(próximo paso)',
                  color: AppColors.warmWhite,
                ),
                _PlaceholderSection(
                  label: '📬 Sección: Contacto\n(próximo paso)',
                  color: AppColors.cream,
                ),
              ],
            ),
          ),

          // ---- NAVBAR FLOTANTE (siempre visible arriba) ----
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppNavigationBar(scrollController: _scrollController),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------
// Widget temporal para visualizar las secciones que vienen
// ----------------------------------------------------------------
class _PlaceholderSection extends StatelessWidget {
  final String label;
  final Color color;

  const _PlaceholderSection({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      color: color,
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AppTheme.bodyMedium.copyWith(
            color: AppColors.textSecondary.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }
}