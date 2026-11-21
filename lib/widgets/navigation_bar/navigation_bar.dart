// ============================================================
// navigation_bar.dart
// ------------------------------------------------------------
// La barra de navegación es el primer elemento que ve el usuario.
// Importantes conceptos de Flutter que aprenderás aquí:
//
// 1. StatefulWidget: a diferencia de StatelessWidget, este
//    widget SÍ puede cambiar su apariencia según condiciones.
//    Lo usamos para detectar si el usuario hizo scroll y poner
//    un fondo semitransparente.
//
// 2. ScrollController: escucha el scroll de la página.
//
// 3. LayoutBuilder / MediaQuery: detecta el ancho de pantalla
//    para mostrar el menú hamburguesa en móvil.
// ============================================================

import 'package:material_ui/material_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_newpage/core/app_theme.dart';

class AppNavigationBar extends StatefulWidget {
  // Recibimos el ScrollController desde la página padre.
  // Así la NavBar sabe cuánto ha hecho scroll el usuario.
  final ScrollController scrollController;

  const AppNavigationBar({super.key, required this.scrollController});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  // Variable de estado: ¿hay scroll activo?
  bool _hasScrolled = false;

  @override
  void initState() {
    super.initState();
    // Escuchamos el scroll para cambiar el fondo de la NavBar
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final scrolled = widget.scrollController.offset > 20;
    // Solo actualizamos si el estado cambió (eficiencia)
    if (scrolled != _hasScrolled) {
      setState(() => _hasScrolled = scrolled);
    }
  }

  @override
  void dispose() {
    // Siempre limpiar listeners al destruir el widget
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: AppSpacing.navHeight,
      decoration: BoxDecoration(
        // Fondo semitransparente cuando hay scroll
        color: _hasScrolled
            ? AppColors.cream.withValues(alpha: 0.95)
            : Colors.transparent,
        border: _hasScrolled
            ? Border(
                bottom: BorderSide(
                  color: AppColors.divider,
                  width: 1,
                ),
              )
            : null,
        // Sutil blur effect con BoxShadow cuando hay scroll
        boxShadow: _hasScrolled
            ? [
                BoxShadow(
                  color: AppColors.darkBrown.withValues(alpha: 0.06),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                )
              ]
            : null,
      ),
      child: _buildNavContent(context),
    );
  }

  Widget _buildNavContent(BuildContext context) {
    // MediaQuery.of(context).size.width nos da el ancho de pantalla.
    // Usamos esto para decidir si mostrar el menú completo o hamburguesa.
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    return Center(
      child: ConstrainedBox(
        // Limitamos el ancho del contenido (igual que el sitio de referencia)
        constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ---- LOGO ----
              const _Logo(),

              if (isDesktop) ...[
                // ---- LINKS DE NAVEGACIÓN (solo desktop) ----
                const _NavLinks(),
                // ---- BOTÓN CTA ----
                const _CTAButton(),
              ] else ...[
                // ---- MENÚ HAMBURGUESA (móvil) ----
                const _HamburgerButton(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------
// Logo del artesano
// ----------------------------------------------------------------
class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Ícono representativo de madera/carpintería
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.darkBrown,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Icon(
            Icons.carpenter,
            color: AppColors.lightWood,
            size: 20,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'Artesano\nen Madera',
          style: GoogleFonts.playfairDisplay(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.darkBrown,
            height: 1.2,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}

// ----------------------------------------------------------------
// Links de navegación (desktop)
// ----------------------------------------------------------------
class _NavLinks extends StatelessWidget {
  const _NavLinks();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        _NavItem(label: 'Servicios', anchor: 'servicios'),
        SizedBox(width: 32),
        _NavItem(label: 'Trabajos', anchor: 'trabajos'),
        SizedBox(width: 32),
        _NavItem(label: 'Sobre mí', anchor: 'sobre-mi'),
        SizedBox(width: 32),
        _NavItem(label: 'Contacto', anchor: 'contacto'),
      ],
    );
  }
}

// ----------------------------------------------------------------
// Un ítem del menú de navegación con efecto hover
// ----------------------------------------------------------------
class _NavItem extends StatefulWidget {
  final String label;
  final String anchor;

  const _NavItem({required this.label, required this.anchor});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      // cursor de mano al pasar el mouse
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          // TODO: en próximos pasos implementaremos el scroll a secciones
        },
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: AppTheme.navItem.copyWith(
            color: _isHovered ? AppColors.accentBrown : AppColors.darkBrown,
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------
// Botón de llamada a la acción (CTA)
// ----------------------------------------------------------------
class _CTAButton extends StatefulWidget {
  const _CTAButton();

  @override
  State<_CTAButton> createState() => _CTAButtonState();
}

class _CTAButtonState extends State<_CTAButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          // TODO: scroll a sección contacto
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.mediumBrown : AppColors.darkBrown,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'Pedir Presupuesto',
            style: AppTheme.navItem.copyWith(
              color: AppColors.cream,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------
// Botón hamburguesa (móvil)
// ----------------------------------------------------------------
class _HamburgerButton extends StatelessWidget {
  const _HamburgerButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu, color: AppColors.darkBrown),
      onPressed: () {
        // TODO: implementar drawer móvil en próximos pasos
      },
    );
  }
}