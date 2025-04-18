import 'package:entry/entry.dart';
import 'package:flutter/material.dart';

class HoverCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;

  const HoverCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Entry.offset(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 300,
          height: 230,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  isHovered
                      ?  Color(0xffF7349D).withValues(alpha: 0.5) 
                      : Color(0xffF7349D).withValues(alpha: 0.1),
              width: isHovered ? 2.0 : 1.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(widget.icon, color: Color(0xffF7349D), size: 36),
                const SizedBox(height: 16),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.description,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
