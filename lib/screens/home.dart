import 'package:axios/utils/responsive_helper.dart';
import 'package:axios/widgets/animated_button.dart';
import 'package:axios/widgets/animated_counter.dart';
import 'package:axios/widgets/event_countdown.dart';
import 'package:axios/widgets/footer.dart';
import 'package:axios/widgets/hower_crad.dart';
import 'package:axios/widgets/particle_background.dart';
import 'package:axios/widgets/project_showcase.dart';
import 'package:axios/widgets/tech_stack_showcase.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int index = 0;
  late ScrollController _scrollController;
  late AnimationController _parallaxController;
  bool _showScrollToTop = false;

  Offset _mousePosition = Offset.zero;

  final List<String> _techWords = [
    'Flutter',
    'React',
    'Node.js',
    'Python',
    'Machine Learning',
    'Web3',
    'Cloud',
    'DevOps',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    _parallaxController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..repeat(reverse: true);
  }

  void _scrollListener() {
    if (_scrollController.offset > 300 && !_showScrollToTop) {
      setState(() {
        _showScrollToTop = true;
      });
    } else if (_scrollController.offset <= 300 && _showScrollToTop) {
      setState(() {
        _showScrollToTop = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _parallaxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);
    final contentPadding = EdgeInsets.symmetric(
      horizontal:
          isMobile
              ? 20
              : isTablet
              ? 40
              : 60,
    );

    return Scaffold(
      extendBody: true,
      backgroundColor: Color(0xff13053B),
      body: MouseRegion(
        onHover: (event) {
          setState(() {
            _mousePosition = event.position;
          });
        },
        child: Stack(
          children: [
            // Particle Background Effect
            Positioned.fill(
              child: ParticleBackground(
                particleCount: isMobile ? 30 : 50,
                mousePosition: _mousePosition,
              ),
            ),

            // Main Content
            SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  if (!isMobile)
                    AnimatedBuilder(
                      animation: _parallaxController,
                      builder: (context, child) {
                        return Positioned(
                          right: 60 + (_parallaxController.value * 20),
                          top: 20 + (_parallaxController.value * 10),
                          child: SizedBox(
                            width: screenSize.width * (isTablet ? 0.35 : 0.45),
                            child: Lottie.asset(
                              'assets/bg.json',
                              repeat: true,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: contentPadding,
                        child: Entry.all(
                          duration: Duration(milliseconds: 1000),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: isMobile ? 80 : 180,
                              left: isMobile ? 0 : 60,
                            ),
                            child: ShaderMask(
                              shaderCallback: (bounds) {
                                return LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Color(0xFF8A6BF6),
                                    Colors.white,
                                  ],
                                  stops: [0.0, 0.5, 1.0],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  tileMode: TileMode.mirror,
                                ).createShader(bounds);
                              },
                              child: Text(
                                "Development Club \nIIIT Bhopal",
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  letterSpacing: isMobile ? 2 : 4,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                          right: isMobile ? 20 : 60,
                          left: isMobile ? 20 : 120,
                        ),
                        child: Entry.all(
                          duration: Duration(milliseconds: 1000),
                          child: Row(
                            children: [
                              Text(
                                "Explore ",
                                style: TextStyle(
                                  fontSize: isMobile ? 18 : 24,
                                  color: Colors.white60,
                                ),
                              ),
                              AnimatedTextKit(
                                animatedTexts:
                                    _techWords
                                        .map(
                                          (word) => TyperAnimatedText(
                                            word,
                                            textStyle: TextStyle(
                                              fontSize: isMobile ? 18 : 24,
                                              color: Color(0xFF8A6BF6),
                                              fontWeight: FontWeight.bold,
                                            ),
                                            speed: Duration(milliseconds: 80),
                                          ),
                                        )
                                        .toList(),
                                totalRepeatCount: 1000,
                                pause: Duration(milliseconds: 1000),
                                displayFullTextOnTap: true,
                              ),
                              Text(
                                " with us",
                                style: TextStyle(
                                  fontSize: isMobile ? 18 : 24,
                                  color: Colors.white60,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: contentPadding,
                        child: Entry.all(
                          duration: Duration(milliseconds: 1000),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 18.0,
                              left: isMobile ? 0 : 60,
                            ),
                            child:
                                isMobile
                                    ? Column(
                                      children: [
                                        GlowingBorderButton(
                                          text: 'Roadmaps',
                                          width: double.infinity,
                                          onPressed: () {
                                            Navigator.restorablePushNamed(
                                              context,
                                              "roadmap",
                                            );
                                          },
                                        ),
                                        SizedBox(height: 16),
                                        GlowingBorderButton(
                                          text: 'Join Us',
                                          width: double.infinity,
                                          onPressed: () {},
                                          glowColor: Color(0xFF8A6BF6),
                                        ),
                                      ],
                                    )
                                    : Row(
                                      children: [
                                        GlowingBorderButton(
                                          text: 'Roadmaps',
                                          onPressed: () {
                                            Navigator.restorablePushNamed(
                                              context,
                                              "roadmap",
                                            );
                                          },
                                        ),
                                        SizedBox(width: 20),
                                        GlowingBorderButton(
                                          text: 'Join Us',
                                          onPressed: () {},
                                          glowColor: Color(0xFF8A6BF6),
                                        ),
                                      ],
                                    ),
                          ),
                        ),
                      ),

                      SizedBox(height: isMobile ? 60 : 120),
                      Padding(
                        padding: contentPadding,
                        child: Entry.offset(
                          duration: Duration(milliseconds: 800),
                          xOffset: 0,
                          yOffset: 30,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withValues(alpha: .05),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: .1),
                                width: 1,
                              ),
                            ),
                            child:
                                isMobile
                                    ? SizedBox(
                                      width: double.maxFinite,
                                      child: Column(
                                        children: [
                                          AnimatedCounter(
                                            count: 500,
                                            label: "Members",
                                            icon: Icons.people,
                                          ),
                                          SizedBox(height: 30),
                                          AnimatedCounter(
                                            count: 50,
                                            label: "Projects",
                                            icon: Icons.code,
                                          ),
                                          SizedBox(height: 30),
                                          AnimatedCounter(
                                            count: 30,
                                            label: "Events",
                                            icon: Icons.event,
                                          ),
                                          SizedBox(height: 30),
                                          AnimatedCounter(
                                            count: 15,
                                            label: "Awards",
                                            icon: Icons.emoji_events,
                                          ),
                                        ],
                                      ),
                                    )
                                    : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        AnimatedCounter(
                                          count: 500,
                                          label: "Members",
                                          icon: Icons.people,
                                        ),
                                        AnimatedCounter(
                                          count: 50,
                                          label: "Projects",
                                          icon: Icons.code,
                                        ),
                                        AnimatedCounter(
                                          count: 30,
                                          label: "Events",
                                          icon: Icons.event,
                                        ),
                                        AnimatedCounter(
                                          count: 15,
                                          label: "Awards",
                                          icon: Icons.emoji_events,
                                        ),
                                      ],
                                    ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              isMobile
                                  ? 20
                                  : isTablet
                                  ? 40
                                  : 120,
                          vertical: 40,
                        ),
                        child:
                            isMobile
                                ? Column(
                                  children: List.generate(4, (index) {
                                    final items = [
                                      {
                                        'icon': Icons.code,
                                        'title': 'Learn',
                                        'description':
                                            'Master modern technologies through hands-on projects and workshops',
                                      },
                                      {
                                        'icon': Icons.psychology,
                                        'title': 'Innovate',
                                        'description':
                                            'Build solutions that impact thousands of students',
                                      },
                                      {
                                        'icon': Icons.people,
                                        'title': 'Connect',
                                        'description':
                                            'Join a vibrant community of passionate developers',
                                      },
                                      {
                                        'icon': Icons.rocket_launch,
                                        'title': 'Grow',
                                        'description':
                                            'Launch your tech career with industry exposure',
                                      },
                                    ];

                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 20,
                                      ),
                                      child: Entry.offset(
                                        duration: Duration(milliseconds: 800),
                                        delay: Duration(
                                          milliseconds: 100 * index,
                                        ),
                                        xOffset: 0,
                                        yOffset: 30,
                                        child: HoverCard(
                                          icon:
                                              items[index]['icon'] as IconData,
                                          title:
                                              items[index]['title'] as String,
                                          description:
                                              items[index]['description']
                                                  as String,
                                        ),
                                      ),
                                    );
                                  }),
                                )
                                : isTablet
                                ? Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: List.generate(4, (index) {
                                    final items = [
                                      {
                                        'icon': Icons.code,
                                        'title': 'Learn',
                                        'description':
                                            'Master modern technologies through hands-on projects and workshops',
                                      },
                                      {
                                        'icon': Icons.psychology,
                                        'title': 'Innovate',
                                        'description':
                                            'Build solutions that impact thousands of students',
                                      },
                                      {
                                        'icon': Icons.people,
                                        'title': 'Connect',
                                        'description':
                                            'Join a vibrant community of passionate developers',
                                      },
                                      {
                                        'icon': Icons.rocket_launch,
                                        'title': 'Grow',
                                        'description':
                                            'Launch your tech career with industry exposure',
                                      },
                                    ];

                                    return Entry.offset(
                                      duration: Duration(milliseconds: 800),
                                      delay: Duration(
                                        milliseconds: 100 * index,
                                      ),
                                      xOffset: 0,
                                      yOffset: 30,
                                      child: HoverCard(
                                        icon: items[index]['icon'] as IconData,
                                        title: items[index]['title'] as String,
                                        description:
                                            items[index]['description']
                                                as String,
                                      ),
                                    );
                                  }),
                                )
                                : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(4, (index) {
                                    final items = [
                                      {
                                        'icon': Icons.code,
                                        'title': 'Learn',
                                        'description':
                                            'Master modern technologies through hands-on projects and workshops',
                                      },
                                      {
                                        'icon': Icons.psychology,
                                        'title': 'Innovate',
                                        'description':
                                            'Build solutions that impact thousands of students',
                                      },
                                      {
                                        'icon': Icons.people,
                                        'title': 'Connect',
                                        'description':
                                            'Join a vibrant community of passionate developers',
                                      },
                                      {
                                        'icon': Icons.rocket_launch,
                                        'title': 'Grow',
                                        'description':
                                            'Launch your tech career with industry exposure',
                                      },
                                    ];

                                    return Entry.offset(
                                      duration: Duration(milliseconds: 800),
                                      delay: Duration(
                                        milliseconds: 100 * index,
                                      ),
                                      xOffset: 0,
                                      yOffset: 30,
                                      child: HoverCard(
                                        icon: items[index]['icon'] as IconData,
                                        title: items[index]['title'] as String,
                                        description:
                                            items[index]['description']
                                                as String,
                                      ),
                                    );
                                  }),
                                ),
                      ),

                      if (!isMobile) TechStackShowcase(),
                      if (!isMobile) SizedBox(height: 80),
                      ProjectShowcase(),
                      SizedBox(height: 80),

                      EventCountdown(
                        eventName: 'Hackathon',
                        eventDate: DateTime(2025, 5, 21),
                      ),
                      // ...
                      SizedBox(height: 80),
                      AxiosClubFooter(),
                    ],
                  ),
                ],
              ),
            ),

            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              bottom: _showScrollToTop ? 30 : -60,
              right: 30,
              child: FloatingActionButton(
                backgroundColor: Color(0xFF8A6BF6),
                onPressed: () {
                  _scrollController.animateTo(
                    0,
                    duration: Duration(milliseconds: 800),
                    curve: Curves.easeInOut,
                  );
                },
                child: Icon(FontAwesomeIcons.arrowUp, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton:
          isMobile
              ? null
              : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  HowerIcons(icon: FontAwesomeIcons.instagram, onTap: () {}),
                  SizedBox(height: 20),
                  HowerIcons(icon: FontAwesomeIcons.linkedinIn, onTap: () {}),
                  SizedBox(height: 20),
                  HowerIcons(icon: FontAwesomeIcons.github, onTap: () {}),
                  SizedBox(height: 20),
                ],
              ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

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
      onEnter: (_) => _setHover(true),
      onExit: (_) => _setHover(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.label,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: isHovered ? Color(0xffF7349D) : Colors.white60,
          ),
        ),
      ),
    );
  }

  void _setHover(bool hovered) {
    setState(() {
      isHovered = hovered;
    });
  }
}

class HowerIcons extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  const HowerIcons({super.key, required this.icon, required this.onTap});

  @override
  State<HowerIcons> createState() => _HowerIconsState();
}

class _HowerIconsState extends State<HowerIcons> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _setHover(true),
      onExit: (_) => _setHover(false),
      cursor: SystemMouseCursors.click,
      child: Icon(
        widget.icon,
        size: 28,
        color: isHovered ? Color(0xffF7349D) : Colors.white60,
      ),
    );
  }

  void _setHover(bool hovered) {
    setState(() {
      isHovered = hovered;
    });
  }
}
