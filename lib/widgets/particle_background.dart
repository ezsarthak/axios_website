import 'dart:math' as math;
import 'package:axios/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class ParticleBackground extends StatefulWidget {
  final int particleCount;
  final Offset mousePosition;

  const ParticleBackground({
    super.key,
    this.particleCount = 50,
    required this.mousePosition,
  });

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with TickerProviderStateMixin {
  late List<Particle> particles;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _initParticles();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..repeat();
  }

  void _initParticles() {
    final random = math.Random();
    particles = List.generate(
      widget.particleCount,
      (_) => Particle(
        position: Offset(
          random.nextDouble() * 1000,
          random.nextDouble() * 2000,
        ),
        speed: Offset(
          (random.nextDouble() - 0.5) * 0.5,
          (random.nextDouble() - 0.5) * 0.5,
        ),
        radius: random.nextDouble() * 3 + 1,
        alpha: random.nextDouble() * 0.5 + 0.1,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        _updateParticles();
        return CustomPaint(
          painter: ParticlePainter(
            particles: particles,
            mousePosition: widget.mousePosition,
            density: isMobile ? 0.5 : 1.0,
          ),
          size: Size.infinite,
        );
      },
    );
  }

  void _updateParticles() {
    final size = MediaQuery.of(context).size;

    for (var particle in particles) {
      particle.position += particle.speed;

      if (particle.position.dx < 0) {
        particle.position = Offset(size.width, particle.position.dy);
      } else if (particle.position.dx > size.width) {
        particle.position = Offset(0, particle.position.dy);
      }

      if (particle.position.dy < 0) {
        particle.position = Offset(particle.position.dx, size.height);
      } else if (particle.position.dy > size.height) {
        particle.position = Offset(particle.position.dx, 0);
      }

      final distance = (particle.position - widget.mousePosition).distance;
      if (distance < 100) {
        final angle = math.atan2(
          particle.position.dy - widget.mousePosition.dy,
          particle.position.dx - widget.mousePosition.dx,
        );
        final repelForce = (100 - distance) / 100 * 2;
        particle.position += Offset(
          math.cos(angle) * repelForce,
          math.sin(angle) * repelForce,
        );
      }
    }
  }
}

class Particle {
  Offset position;
  Offset speed;
  double radius;
  double alpha;

  Particle({
    required this.position,
    required this.speed,
    required this.radius,
    required this.alpha,
  });
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final Offset mousePosition;
  final double density;

  ParticlePainter({
    required this.particles,
    required this.mousePosition,
    this.density = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      final paint =
          Paint()
            ..color = Color(0xFF8A6BF6).withValues(alpha:particle.alpha * density)
            ..style = PaintingStyle.fill;

      canvas.drawCircle(particle.position, particle.radius * density, paint);

      for (var otherParticle in particles) {
        if (particle == otherParticle) continue;

        final distance = (particle.position - otherParticle.position).distance;
        if (distance < 100) {
          final linePaint =
              Paint()
                ..color = Color(
                  0xFF8A6BF6,
                ).withValues(alpha:(100 - distance) / 100 * 0.2 * density)
                ..strokeWidth = 0.5 * density;

          canvas.drawLine(particle.position, otherParticle.position, linePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
