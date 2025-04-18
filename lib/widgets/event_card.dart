import 'package:axios/utils/responsive_helper.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventCard extends StatefulWidget {
  final String title;
  final String description;
  final DateTime dateTime;
  final String location;
  final String imageUrl;
  final List<String> tags;
  final String registerUrl;

  const EventCard({
    super.key,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.location,
    this.imageUrl = '',
    this.tags = const [],
    this.registerUrl = '',
  });

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard>
    with SingleTickerProviderStateMixin {
  bool _isHovering = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.03,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);

    return Entry.all(
      duration: Duration(milliseconds: 1000),
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            _isHovering = true;
          });
          _controller.forward();
        },
        onExit: (_) {
          setState(() {
            _isHovering = false;
          });
          _controller.reverse();
        },
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.registerUrl.isNotEmpty ? () {} : null,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: child,
              );
            },
            child: Container(
              width:
                  isMobile
                      ? double.infinity
                      : isTablet
                      ? 380
                      : 420,
              constraints: BoxConstraints(
                maxWidth: isMobile ? double.infinity : 400,
              ),
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color:
                        _isHovering
                            ? Colors.white.withValues(alpha:.1)
                            : Colors.black.withValues(alpha:.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
                border: Border.all(
                  color:
                      _isHovering
                          ? Colors.white.withValues(alpha:.2)
                          : Colors.white.withValues(alpha:.05),
                  width: 1,
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      widget.imageUrl.isNotEmpty
                          ? Image.network(
                            widget.imageUrl,
                            width: double.infinity,
                            height: 180,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: double.infinity,
                                height: 180,
                                color: const Color(0xFF111111),
                                child: const Center(
                                  child: Icon(
                                    Icons.event,
                                    color: Colors.white24,
                                    size: 40,
                                  ),
                                ),
                              );
                            },
                          )
                          : Container(
                            width: double.infinity,
                            height: 180,
                            color: const Color(0xFF111111),
                            child: const Center(
                              child: Icon(
                                Icons.event,
                                color: Colors.white24,
                                size: 40,
                              ),
                            ),
                          ),

                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha:.7),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            DateFormat('MMM d, yyyy').format(widget.dateTime),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      AnimatedBuilder(
                        animation: _opacityAnimation,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _opacityAnimation.value * 0.4,
                            child: Container(
                              width: double.infinity,
                              height: 180,
                              color: Colors.black,
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.tags.isNotEmpty)
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children:
                                widget.tags
                                    .map((tag) => _buildTag(tag))
                                    .toList(),
                          ),

                        if (widget.tags.isNotEmpty) const SizedBox(height: 12),

                        Text(
                          widget.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 14,
                              color: Colors.white.withValues(alpha:.6),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              DateFormat('h:mm a').format(widget.dateTime),
                              style: TextStyle(
                                color: Colors.white.withValues(alpha:.6),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 14,
                              color: Colors.white.withValues(alpha:.6),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                widget.location,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha:.6),
                                  fontSize: 13,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        Text(
                          widget.description,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha:.7),
                            fontSize: 14,
                            height: 1.5,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 16),

                        AnimatedBuilder(
                          animation: _opacityAnimation,
                          builder: (context, child) {
                            return Opacity(
                              opacity: _opacityAnimation.value,
                              child: Container(
                                width: double.infinity,
                                height: 36,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha:.3),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    'View Details',
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha:.9),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: Colors.white.withValues(alpha: .8),
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
