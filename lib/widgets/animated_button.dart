import 'dart:ui';
import 'package:flutter/material.dart';

class GlowingBorderButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? glowColor;
  final Color? textColor;
  final double? width;
  final double? height;

  const GlowingBorderButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.glowColor,
    this.textColor,
    this.width,
    this.height,
  });

  @override
  State<GlowingBorderButton> createState() => _GlowingBorderButtonState();
}

class _GlowingBorderButtonState extends State<GlowingBorderButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final glowColor = widget.glowColor ?? const Color(0xffF7349D);
    final textColor = widget.textColor ?? Colors.white;
    final width = widget.width ?? 160.0;
    final height = widget.height ?? 50.0;

    return GestureDetector(
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: GlowingBorderPainter(
              progress: _controller.value,
              glowColor: glowColor,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: .3),
                        Colors.white.withValues(alpha: .1),
                        Colors.white.withValues(alpha: .02),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: .2),
                      width: 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsetsDirectional.only(bottom: 4),
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class GlowingBorderPainter extends CustomPainter {
  final double progress;
  final Color glowColor;

  GlowingBorderPainter({
    required this.progress,
    required this.glowColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(24),
    );

    final path = Path()..addRRect(rrect);
    final pathMetrics = path.computeMetrics().toList();

    final basePaint = Paint()
      ..color = Colors.white.withValues(alpha:0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth =2;
    canvas.drawRRect(rrect, basePaint);

    final glowPaint = Paint()
      ..color = glowColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 1);

    for (final metric in pathMetrics) {
      final length = metric.length;
      final start = length * progress;
      final end = start + length * 0.1;

      if (end <= length) {
        final glowSegment = metric.extractPath(start, end);
        canvas.drawPath(glowSegment, glowPaint);
      } else {
        final first = metric.extractPath(start, length);
        final second = metric.extractPath(0, end - length);
        canvas.drawPath(first, glowPaint);
        canvas.drawPath(second, glowPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant GlowingBorderPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.glowColor != glowColor;
  }
}
