import 'package:flutter/material.dart';

class AnimatedCounter extends StatefulWidget {
  final int count;
  final String label;
  final IconData icon;

  const AnimatedCounter({
    super.key,
    required this.count,
    required this.label,
    required this.icon,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _displayedCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    )..addListener(() {
      setState(() {
        _displayedCount = (_animation.value * widget.count).round();
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Color(0xFF8A6BF6).withValues(alpha: .1),
            shape: BoxShape.circle,
            border: Border.all(
              color: Color(0xFF8A6BF6).withValues(alpha: .3),
              width: 2,
            ),
          ),
          child: Icon(widget.icon, color: Color(0xFF8A6BF6), size: 36),
        ),
        SizedBox(height: 16),
        Text(
          _displayedCount.toString(),
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          widget.label,
          style: TextStyle(fontSize: 16, color: Colors.white60),
        ),
      ],
    );
  }
}
