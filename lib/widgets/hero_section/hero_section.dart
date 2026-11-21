// ============================================================
// hero_section.dart
// ------------------------------------------------------------
// La "Hero Section" es la primera sección que ve el usuario.
// Es el elemento más importante de la página — debe impactar
// visualmente en los primeros 3 segundos.
//
// Conceptos nuevos de Flutter en este archivo:
//
// 1. Stack: permite superponer widgets uno sobre otro.
//    Úsalo para poner texto encima de una imagen.
//
// 2. AnimationController + Tween: animaciones programáticas.
//    Hacemos que el texto aparezca con un fade-in suave.
//
// 3. TickerProviderStateMixin: requerido para usar animaciones
//    en Flutter. El "ticker" sincroniza la animación con los
//    frames de pantalla (60fps).
// ============================================================

import 'package:material_ui/material_ui.dart';
import 'package:the_newpage/core/app_theme.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

// SingleTickerProviderStateMixin permite que este widget
// sirva como "ticker" para una animación.
class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  // AnimationController: controla el tiempo de la animación
  late AnimationController _controller;

  // Animation<double>: el valor que cambia de 0.0 a 1.0
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Creamos el controlador: dura 900ms
    _controller = AnimationController(
      vsync: this, // 'this' es el TickerProvider
      duration: const Duration(milliseconds: 900),
    );

    // CurvedAnimation: le da una curva suave a la animación
    // Curves.easeOut hace que empiece rápido y termine lento
    final curved = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    // Fade: opacidad de 0.0 a 1.0
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(curved);

    // Slide: el texto baja 30px antes de llegar a su posición
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(curved);

    // Iniciamos la animación automáticamente al cargar
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); // Siempre liberar recursos
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    return SizedBox(
      // La Hero ocupa el 90% de la altura de la ventana (viewport)
      height: MediaQuery.of(context).size.height * 0.9,
      child: Stack(
        children: [
          // ---- FONDO: Imagen con gradiente ----
          _HeroBackground(isDesktop: isDesktop),

          // ---- CONTENIDO: Texto animado ----
          _HeroContent(
            fadeAnimation: _fadeAnimation,
            slideAnimation: _slideAnimation,
            isDesktop: isDesktop,
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------
// Fondo de la Hero (imagen + gradiente oscuro)
// ----------------------------------------------------------------
class _HeroBackground extends StatelessWidget {
  final bool isDesktop;

  const _HeroBackground({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          // Panel izquierdo — color cálido (madera)
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: isDesktop ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width,
            child: Container(
              color: AppColors.cream,
            ),
          ),

          // Panel derecho — imagen de trabajo en madera
          if (isDesktop)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: MediaQuery.of(context).size.width * 0.5,
              child: _WoodImagePanel(),
            ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------
// Panel con la imagen de trabajo en madera
// (Usamos un placeholder visual hasta tener fotos reales)
// ----------------------------------------------------------------
class _WoodImagePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // Gradiente cálido que simula madera hasta tener foto real
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF8B6914),
            Color(0xFF5C3D2E),
            Color(0xFF2C1810),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Patrón decorativo que evoca vetas de madera
          Positioned.fill(
            child: CustomPaint(
              painter: _WoodGrainPainter(),
            ),
          ),
          // Texto de placeholder
          Center(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.carpenter,
                    color: AppColors.lightWood.withValues(alpha: 0.4),
                    size: 80,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Foto del trabajo\ndel artesano',
                    textAlign: TextAlign.center,
                    style: AppTheme.bodyMedium.copyWith(
                      color: AppColors.lightWood.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------
// Pintor personalizado: dibuja líneas que imitan vetas de madera
// CustomPainter es una forma avanzada de dibujar en Flutter.
// ----------------------------------------------------------------
class _WoodGrainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.04)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Dibujamos líneas curvas que simulan la veta de la madera
    for (int i = 0; i < 12; i++) {
      final path = Path();
      final startY = (size.height / 12) * i;
      path.moveTo(0, startY);
      path.cubicTo(
        size.width * 0.3, startY + 20,
        size.width * 0.6, startY - 10,
        size.width, startY + 15,
      );
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ----------------------------------------------------------------
// Contenido principal de la Hero (texto + botones)
// ----------------------------------------------------------------
class _HeroContent extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  final bool isDesktop;

  const _HeroContent({
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 48 : 24,
              vertical: 0,
            ),
            child: Align(
              // En desktop, el texto va a la izquierda
              alignment: isDesktop ? Alignment.centerLeft : Alignment.center,
              child: SizedBox(
                width: isDesktop ? 520 : double.infinity,
                child: FadeTransition(
                  opacity: fadeAnimation,
                  child: SlideTransition(
                    position: slideAnimation,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: isDesktop
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      children: [
                        // ---- Etiqueta superior ----
                        _TagChip(),
                        const SizedBox(height: 24),

                        // ---- Título principal ----
                        Text(
                          'Madera\nHecha a Mano\ncon Pasión',
                          style: isDesktop
                              ? AppTheme.displayLarge
                              : AppTheme.displayMedium,
                          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                        ),
                        const SizedBox(height: 20),

                        // ---- Subtítulo ----
                        Text(
                          'Muebles, sofás, puertas y piezas únicas '
                          'de madera artesanal. Cada trabajo es '
                          'diseñado y construido a medida para ti.',
                          style: AppTheme.bodyLarge,
                          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                        ),
                        const SizedBox(height: 40),

                        // ---- Botones de acción ----
                        isDesktop
                            ? Row(
                                children: [
                                  _PrimaryButton(),
                                  const SizedBox(width: 16),
                                  _SecondaryButton(),
                                ],
                              )
                            : Column(
                                children: [
                                  _PrimaryButton(fullWidth: true),
                                  const SizedBox(height: 12),
                                  _SecondaryButton(),
                                ],
                              ),

                        const SizedBox(height: 40),

                        // ---- Stats ----
                        _StatsRow(isDesktop: isDesktop),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------
// Chip de etiqueta (ej: "Maestro Constructor · +15 años")
// ----------------------------------------------------------------
class _TagChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.lightWood.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: AppColors.lightWood.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: AppColors.accentBrown,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Maestro Constructor · +15 años de experiencia',
            style: AppTheme.labelLarge.copyWith(
              fontSize: 12,
              color: AppColors.mediumBrown,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------
// Botón principal (CTA)
// ----------------------------------------------------------------
class _PrimaryButton extends StatefulWidget {
  final bool fullWidth;

  const _PrimaryButton({this.fullWidth = false});

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: widget.fullWidth ? double.infinity : null,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.mediumBrown : AppColors.darkBrown,
            borderRadius: BorderRadius.circular(8),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.darkBrown.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    )
                  ]
                : [],
          ),
          child: Text(
            'Ver mis Trabajos',
            textAlign: TextAlign.center,
            style: AppTheme.labelLarge.copyWith(
              color: AppColors.cream,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------
// Botón secundario (outline)
// ----------------------------------------------------------------
class _SecondaryButton extends StatefulWidget {
  @override
  State<_SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<_SecondaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.lightWood.withValues(alpha: 0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.mediumBrown.withValues(alpha: 0.5),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Pedir Presupuesto',
                style: AppTheme.labelLarge.copyWith(
                  color: AppColors.mediumBrown,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward,
                size: 16,
                color: AppColors.mediumBrown,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------
// Fila de estadísticas (proyectos completados, años, clientes)
// ----------------------------------------------------------------
class _StatsRow extends StatelessWidget {
  final bool isDesktop;

  const _StatsRow({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: isDesktop ? MainAxisSize.min : MainAxisSize.max,
      mainAxisAlignment: isDesktop
          ? MainAxisAlignment.start
          : MainAxisAlignment.spaceEvenly,
      children: [
        _StatItem(value: '+120', label: 'Proyectos'),
        _StatDivider(),
        _StatItem(value: '+15', label: 'Años'),
        _StatDivider(),
        _StatItem(value: '+80', label: 'Clientes'),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: AppTheme.headingMedium.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            label,
            style: AppTheme.bodyMedium.copyWith(fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 36,
      color: AppColors.divider,
    );
  }
}
