import 'package:axios/utils/responsive_helper.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class BlogCard extends StatefulWidget {
  final String title;
  final String excerpt;
  final String imageUrl;
  final String author;
  final String authorImageUrl;
  final DateTime date;
  final VoidCallback? onTap;
  final List<String> categories;
  final Color accentColor;

  const BlogCard({
    super.key,
    required this.title,
    required this.excerpt,
    required this.imageUrl,
    required this.author,
    required this.authorImageUrl,
    required this.date,
    required this.categories,
    this.accentColor = const Color(0xFF3B82F6),
    this.onTap, // Default blue accent
  });

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard>
    with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d, yyyy');
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);

    return Entry.all(
      duration: Duration(milliseconds: 1000),
      child: MouseRegion(
        onEnter: (_) {
          setState(() => isHovered = true);
          _controller.forward();
        },
        onExit: (_) {
          setState(() => isHovered = false);
          _controller.reverse();
        },
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            width:
                isMobile
                    ? double.infinity
                    : isTablet
                    ? 380
                    : 420,
            height: isMobile ? 420 : 420,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color:
                      isHovered
                          ? widget.accentColor.withValues(alpha:.3)
                          : Colors.black.withValues(alpha:.3),
                  blurRadius: isHovered ? 16 : 10,
                  spreadRadius: isHovered ? 2 : 1,
                  offset: const Offset(0, 8),
                ),
              ],
              border: Border.all(
                color: isHovered ? widget.accentColor : Colors.transparent,
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 180,
                        width: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: widget.imageUrl,
                          fit: BoxFit.cover,
                          placeholder:
                              (context, url) => Container(
                                color: Colors.grey.shade800,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white54,
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                          errorWidget:
                              (context, url, error) => Container(
                                color: Colors.grey.shade900,
                                child: const Icon(
                                  Icons.image_not_supported,
                                  color: Colors.white30,
                                  size: 40,
                                ),
                              ),
                        ),
                      ),

                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha:.7),
                              ],
                              stops: const [0.6, 1.0],
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 12,
                        left: 20,
                        right: 20,
                        child: Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black54,
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 16,
                        left: 16,
                        top: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.excerpt,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade300,
                              height: 1.5,
                              letterSpacing: 0.2,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 16),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.tag,
                                    size: 16,
                                    color: widget.accentColor.withValues(alpha:.8),
                                  ),
                                  const SizedBox(width: 6),
                                  const Text(
                                    "Categories",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children:
                                    widget.categories
                                        .map(
                                          (category) => CategoryChip(
                                            label: category,
                                            accentColor: widget.accentColor,
                                          ),
                                        )
                                        .toList(),
                              ),
                            ],
                          ),

                          const Spacer(),

                          Row(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: widget.accentColor.withValues(alpha:
                                  .2,
                                ),
                                backgroundImage: NetworkImage(
                                  widget.authorImageUrl,
                                ),
                              ),
                              const SizedBox(width: 12),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.author,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      dateFormat.format(widget.date),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              ElevatedButton.icon(
                                onPressed: widget.onTap ?? () {},
                                icon: const Icon(
                                  Icons.article_outlined,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'Read Post',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: widget.accentColor,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                        ],
                      ),
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
}

class CategoryChip extends StatelessWidget {
  final String label;
  final Color accentColor;

  const CategoryChip({
    super.key,
    required this.label,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: .15),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: accentColor.withValues(alpha: .3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: accentColor.withValues(alpha: .9),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
