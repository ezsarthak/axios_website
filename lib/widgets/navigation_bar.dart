// widgets/navigation_bar.dart
import 'package:flutter/material.dart';
import 'package:axios/utils/responsive_helper.dart';
import 'package:axios/widgets/type_writer.dart';

class HoverText extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const HoverText({super.key, required this.label, required this.onTap});

  @override
  State<HoverText> createState() => _HoverTextState();
}

class _HoverTextState extends State<HoverText> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.label,
          style: TextStyle(
            color: isHovered ? Color(0xffF7349D) : Colors.white,
            fontSize: 16,
            fontWeight: isHovered ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class ResponsiveNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onIndexChanged;

  const ResponsiveNavBar({
    super.key,
    required this.currentIndex,
    required this.onIndexChanged,
  });

  @override
  State<ResponsiveNavBar> createState() => _ResponsiveNavBarState();
}

class _ResponsiveNavBarState extends State<ResponsiveNavBar> {
  bool isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal:
            isMobile
                ? 20
                : isTablet
                ? 40
                : 60,
        vertical: 20,
      ),
      child: isMobile ? _buildMobileNavBar() : _buildDesktopNavBar(),
    );
  }

  Widget _buildDesktopNavBar() {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Axios Club",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: ResponsiveHelper.isTablet(context) ? 36 : 48,
            color: Color(0xffF7349D),
          ),
        ),
        SizedBox(width: 16),
        if (!isMobile)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TypewriterText(),
          ),
        Spacer(),
        _buildNavItem("Home", 0),
        SizedBox(width: 32),
        _buildNavItem("Projects", 1),
        SizedBox(width: 32),
        _buildNavItem("Blogs", 2),
        SizedBox(width: 32),
        _buildNavItem("Events", 3),
        SizedBox(width: 32),
        _buildNavItem("Team", 4),
        SizedBox(width: 32),
        GestureDetector(
          onTap: () {
            Navigator.restorablePushNamed(context, "about");
          },
          child: CircleAvatar(
            radius: 28,
            foregroundImage: AssetImage("assets/image.png"),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileNavBar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Axios Club",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 28,
                color: Color(0xffF7349D),
              ),
            ),
            IconButton(
              icon: Icon(
                isMenuOpen ? Icons.close : Icons.menu,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () {
                setState(() {
                  isMenuOpen = !isMenuOpen;
                });
              },
            ),
          ],
        ),
        if (isMenuOpen)
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                _buildMobileNavItem("Home", 0),
                _buildMobileNavItem("Projects", 1),
                _buildMobileNavItem("Blogs", 2),
                _buildMobileNavItem("Events", 3),
                _buildMobileNavItem("Team", 4),
                GestureDetector(
                  onTap: () {
                    Navigator.restorablePushNamed(context, "about");
                  },
                  child: CircleAvatar(
                    radius: 20,
                    foregroundImage: AssetImage("assets/image.png"),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildNavItem(String label, int index) {
    return HoverText(
      label: label,
      onTap: () {
        widget.onIndexChanged(index);
      },
    );
  }

  Widget _buildMobileNavItem(String label, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: GestureDetector(
        onTap: () {
          widget.onIndexChanged(index);
          setState(() {
            isMenuOpen = false;
          });
        },
        child: Text(
          label,
          style: TextStyle(
            color:
                widget.currentIndex == index ? Color(0xffF7349D) : Colors.white,
            fontSize: 18,
            fontWeight:
                widget.currentIndex == index
                    ? FontWeight.w700
                    : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
