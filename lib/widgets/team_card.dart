import 'package:axios/utils/responsive_helper.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TeamCard extends StatefulWidget {
  final String name;
  final String role;
  final String bio;
  final List<String> skills;
  final String imageUrl;
  final String? githubUrl;
  final String? linkedinUrl;
  final String? portfolioUrl;
  final Color accentColor;

  const TeamCard({
    super.key,
    required this.name,
    required this.role,
    required this.bio,
    required this.skills,
    required this.imageUrl,
    this.githubUrl,
    this.linkedinUrl,
    this.portfolioUrl,
    this.accentColor = const Color(0xFF8A6BF6),
  });

  @override
  State<TeamCard> createState() => _TeamCardState();
}

class _TeamCardState extends State<TeamCard>
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
                    ? 280
                    : 320,
            height: isMobile ? 455 : 455,
            decoration: BoxDecoration(
              color: const Color(0xFF1E0A5C),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color:
                      isHovered
                          ? widget.accentColor.withValues(alpha: .3)
                          : Colors.black.withValues(alpha: .3),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 180,
                    width: double.infinity,
                    color: widget.accentColor.withValues(alpha: .1),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned.fill(
                          child: CustomPaint(
                            painter: PatternPainter(
                              color: widget.accentColor.withValues(alpha: .05),
                            ),
                          ),
                        ),

                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: widget.accentColor,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: widget.accentColor.withValues(alpha: .3),
                                blurRadius: 12,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: ClipOval(
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
                                      Icons.person,
                                      color: Colors.white30,
                                      size: 40,
                                    ),
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: widget.accentColor.withValues(alpha: .2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              widget.role,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: widget.accentColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          Text(
                            widget.bio,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade300,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 16),

                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 8,
                            runSpacing: 8,
                            children:
                                widget.skills
                                    .map(
                                      (skill) => SkillChip(
                                        label: skill,
                                        accentColor: widget.accentColor,
                                      ),
                                    )
                                    .toList(),
                          ),
                          const Spacer(),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (widget.githubUrl != null)
                                SocialButton(
                                  icon: FontAwesomeIcons.github,
                                  onPressed: () {},
                                  accentColor: widget.accentColor,
                                ),
                              if (widget.linkedinUrl != null) ...[
                                const SizedBox(width: 12),
                                SocialButton(
                                  icon: FontAwesomeIcons.linkedin,
                                  onPressed: () {},
                                  accentColor: widget.accentColor,
                                ),
                              ],
                              if (widget.portfolioUrl != null) ...[
                                const SizedBox(width: 12),
                                SocialButton(
                                  icon: FontAwesomeIcons.globe,
                                  onPressed: () {},
                                  accentColor: widget.accentColor,
                                ),
                              ],
                            ],
                          ),
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

class SkillChip extends StatelessWidget {
  final String label;
  final Color accentColor;

  const SkillChip({super.key, required this.label, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: .15),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: accentColor.withValues(alpha: .3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: accentColor.withValues(alpha: .9),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color accentColor;

  const SocialButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: accentColor.withValues(alpha: .1),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: FaIcon(icon, size: 18, color: accentColor),
        tooltip: 'Social Link',
        style: IconButton.styleFrom(padding: const EdgeInsets.all(12)),
      ),
    );
  }
}

class PatternPainter extends CustomPainter {
  final Color color;

  PatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = 1.0
          ..style = PaintingStyle.stroke;

    const spacing = 20.0;

    // Draw diagonal lines
    for (double i = -size.width; i < size.width + size.height; i += spacing) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
