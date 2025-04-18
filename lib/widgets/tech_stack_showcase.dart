import 'package:axios/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class TechStackShowcase extends StatefulWidget {
  const TechStackShowcase({super.key});

  @override
  State<TechStackShowcase> createState() => _TechStackShowcaseState();
}

class _TechStackShowcaseState extends State<TechStackShowcase>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;

  final List<TechItem> _techItems = [
    TechItem(
      name: 'React',
      icon: 'assets/icons/react.png',
      color: Color(0xFF61DAFB),
    ),
    TechItem(
      name: 'Node.js',
      icon: 'assets/icons/nodejs.png',
      color: Color(0xFF8CC84B),
    ),
    TechItem(
      name: 'Python',
      icon: 'assets/icons/python.png',
      color: Color(0xFF3776AB),
    ),
    TechItem(
      name: 'Firebase',
      icon: 'assets/icons/firebase.png',
      color: Color(0xFFFFA000),
    ),
    TechItem(
      name: 'Flutter',
      icon: 'assets/icons/flutter.png',
      color: Color(0xFF54C5F8),
    ),
    TechItem(
      name: 'AWS',
      icon: 'assets/icons/aws.png',
      color: Color(0xFFFF9900),
    ),
    TechItem(
      name: 'MongoDB',
      icon: 'assets/icons/mongodb.png',
      color: Color(0xFF47A248),
    ),
    TechItem(
      name: 'TensorFlow',
      icon: 'assets/icons/tensorflow.png',
      color: Color(0xFFFF6F00),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Center(
      child: SizedBox(
        height: isMobile ? 300 : 400,
        width: isMobile ? 300 : 400,
        child: AnimatedBuilder(
          animation: _rotationController,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: isMobile ? 80 : 100,
                  height: isMobile ? 80 : 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF8A6BF6).withValues(alpha: .2),
                    border: Border.all(
                      color: Color(0xFF8A6BF6).withValues(alpha: .5),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "TECH",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: isMobile ? 16 : 18,
                      ),
                    ),
                  ),
                ),

                ..._techItems.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;

                  final angle =
                      (_rotationController.value * 2 * math.pi) +
                      (index * (2 * math.pi / _techItems.length));

                  final radius = isMobile ? 110.0 : 140.0;
                  final x = radius * math.cos(angle);
                  final y = radius * math.sin(angle);

                  return Positioned(
                    left: (isMobile ? 135 : 165) + x,
                    top: (isMobile ? 135 : 165) + y,
                    child: TechItemWidget(
                      item: item,
                      isHovered: false,
                      onHover: (isHovered) {},
                    ),
                  );
                }),
              ],
            );
          },
        ),
      ),
    );
  }
}

class TechItem {
  final String name;
  final String icon;
  final Color color;

  TechItem({required this.name, required this.icon, required this.color});
}

class TechItemWidget extends StatefulWidget {
  final TechItem item;
  final bool isHovered;
  final Function(bool) onHover;

  const TechItemWidget({
    super.key,
    required this.item,
    required this.isHovered,
    required this.onHover,
  });

  @override
  State<TechItemWidget> createState() => _TechItemWidgetState();
}

class _TechItemWidgetState extends State<TechItemWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
        widget.onHover(true);
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
        widget.onHover(false);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: _isHovered ? 90 : 70,
        height: _isHovered ? 90 : 70,
        decoration: BoxDecoration(
          color: widget.item.color.withValues(alpha: _isHovered ? 0.3 : 0.2),
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.item.color.withValues(alpha: _isHovered ? 0.8 : 0.5),
            width: 2,
          ),
          boxShadow:
              _isHovered
                  ? [
                    BoxShadow(
                      color: widget.item.color.withValues(alpha: .5),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ]
                  : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              widget.item.icon,
              color: widget.item.color,
              width: 24,
              height: 24,
            ),
            if (_isHovered)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  widget.item.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
