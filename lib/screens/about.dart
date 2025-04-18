import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:axios/utils/responsive_helper.dart';
import 'package:axios/widgets/footer.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
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
    final contentPadding = EdgeInsets.symmetric(
      horizontal:
          isMobile
              ? 20
              : isTablet
              ? 40
              : 60,
    );

    return Scaffold(
      backgroundColor: Color(0xff13053B),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(isMobile, isTablet, contentPadding),

            _buildMissionVisionSection(isMobile, isTablet, contentPadding),

            _buildWhatWeDoSection(isMobile, isTablet, contentPadding),

            _buildTimelineSection(isMobile, isTablet, contentPadding),

            _buildStatsSection(isMobile, isTablet, contentPadding),

            _buildJoinUsSection(isMobile, isTablet, contentPadding),

            AxiosClubFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(bool isMobile, bool isTablet, EdgeInsets padding) {
    return Container(
      width: double.infinity,
      padding: padding.copyWith(top: 60, bottom: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: isMobile ? 30 : 40,
                foregroundImage: AssetImage("assets/image.png"),
              ),
              const SizedBox(width: 16),
              Text(
                "AXIOS CLUB",
                style: TextStyle(
                  fontSize: isMobile ? 32 : 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3, end: 0),
            ],
          ),
          const SizedBox(height: 20),

          Container(
            constraints: BoxConstraints(maxWidth: 800),
            child: Text(
              "Innovate. Code. Transform.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 18 : 24,
                fontWeight: FontWeight.w500,
                color: Color(0xFFF7349D),
                letterSpacing: 1.5,
              ),
            ),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 30),

          Container(
            constraints: BoxConstraints(maxWidth: 800),
            child: Text(
              "The official development club of IIIT Bhopal, fostering innovation and technical excellence through collaborative learning and real-world projects.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 16 : 18,
                color: Colors.white70,
                height: 1.6,
              ),
            ),
          ).animate().fadeIn(delay: 800.ms),
          const SizedBox(height: 40),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialButton(
                FontAwesomeIcons.github,
                "https://github.com/axios-iiitb",
              ),
              const SizedBox(width: 16),
              _buildSocialButton(
                FontAwesomeIcons.instagram,
                "https://instagram.com/axios_iiitb",
              ),
              const SizedBox(width: 16),
              _buildSocialButton(
                FontAwesomeIcons.linkedinIn,
                "https://linkedin.com/company/axios-iiitb",
              ),
              const SizedBox(width: 16),
              _buildSocialButton(
                FontAwesomeIcons.xTwitter,
                "https://twitter.com/axios_iiitb",
              ),
            ],
          ).animate().fadeIn(delay: 1200.ms),
        ],
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, String url) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: FaIcon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildMissionVisionSection(
    bool isMobile,
    bool isTablet,
    EdgeInsets padding,
  ) {
    return Container(
      width: double.infinity,
      padding: padding.copyWith(top: 80, bottom: 80),
      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.2)),
      child: Column(
        children: [
          Text(
                "OUR MISSION & VISION",
                style: TextStyle(
                  fontSize: isMobile ? 24 : 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              )
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(
                duration: 3.seconds,
                color: Color(0xFF8A6BF6).withValues(alpha: 0.8),
              ),
          const SizedBox(height: 60),

          isMobile
              ? Column(
                children: [
                  _buildMissionVisionCard(
                    "Our Mission",
                    "To foster a community of passionate developers who collaborate, innovate, and build solutions that matter. We aim to bridge the gap between academic learning and industry requirements by providing hands-on experience through real-world projects.",
                    Icons.rocket_launch_rounded,
                    Color(0xFF8A6BF6),
                  ),
                  const SizedBox(height: 30),
                  _buildMissionVisionCard(
                    "Our Vision",
                    "To be recognized as a hub of technical excellence that nurtures future tech leaders and innovators. We envision creating an ecosystem where students can explore, experiment, and excel in various domains of software development and technology.",
                    Icons.visibility_rounded,
                    Color(0xFFF7349D),
                  ),
                ],
              )
              : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildMissionVisionCard(
                      "Our Mission",
                      "To foster a community of passionate developers who collaborate, innovate, and build solutions that matter. We aim to bridge the gap between academic learning and industry requirements by providing hands-on experience through real-world projects.",
                      Icons.rocket_launch_rounded,
                      Color(0xFF8A6BF6),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: _buildMissionVisionCard(
                      "Our Vision",
                      "To be recognized as a hub of technical excellence that nurtures future tech leaders and innovators. We envision creating an ecosystem where students can explore, experiment, and excel in various domains of software development and technology.",
                      Icons.visibility_rounded,
                      Color(0xFFF7349D),
                    ),
                  ),
                ],
              ),
        ],
      ),
    );
  }

  Widget _buildMissionVisionCard(
    String title,
    String description,
    IconData icon,
    Color accentColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accentColor.withValues(alpha: 0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 40, color: accentColor),
          const SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: TextStyle(fontSize: 16, color: Colors.white70, height: 1.6),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildWhatWeDoSection(
    bool isMobile,
    bool isTablet,
    EdgeInsets padding,
  ) {
    final activities = [
      {
        'title': 'Workshops & Training',
        'description':
            'Regular workshops on cutting-edge technologies, programming languages, and development tools to enhance technical skills.',
        'icon': Icons.code_rounded,
        'color': Color(0xFF8A6BF6),
      },
      {
        'title': 'Hackathons',
        'description':
            'Organizing and participating in hackathons to foster innovation, problem-solving, and teamwork under time constraints.',
        'icon': Icons.timer_rounded,
        'color': Color(0xFFF7349D),
      },
      {
        'title': 'Project Development',
        'description':
            'Collaborative projects that solve real-world problems, providing hands-on experience in software development lifecycle.',
        'icon': Icons.build_rounded,
        'color': Color(0xFF6B8AF6),
      },
      {
        'title': 'Tech Talks',
        'description':
            'Inviting industry experts and alumni to share insights, experiences, and the latest trends in technology.',
        'icon': Icons.mic_rounded,
        'color': Color(0xFFAC6BF6),
      },
      {
        'title': 'Open Source Contributions',
        'description':
            'Encouraging and guiding students to contribute to open-source projects and build their developer portfolio.',
        'icon': Icons.public_rounded,
        'color': Color(0xFF34D399),
      },
      {
        'title': 'Mentorship Program',
        'description':
            'Connecting experienced developers with beginners to provide guidance, support, and learning paths.',
        'icon': Icons.people_rounded,
        'color': Color(0xFFF59E0B),
      },
    ];

    return Container(
      width: double.infinity,
      padding: padding.copyWith(top: 80, bottom: 80),
      child: Column(
        children: [
          Text(
                "WHAT WE DO",
                style: TextStyle(
                  fontSize: isMobile ? 24 : 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              )
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(
                duration: 3.seconds,
                color: Color(0xFF8A6BF6).withValues(alpha: 0.8),
              ),
          const SizedBox(height: 20),

          Container(
            constraints: BoxConstraints(maxWidth: 800),
            child: Text(
              "At Axios Club, we're committed to creating a vibrant tech ecosystem through various activities and initiatives",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 16 : 18,
                color: Colors.white70,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 60),

          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children:
                activities.asMap().entries.map((entry) {
                  final index = entry.key;
                  final activity = entry.value;

                  return _buildActivityCard(
                        activity['title'] as String,
                        activity['description'] as String,
                        activity['icon'] as IconData,
                        activity['color'] as Color,
                      )
                      .animate()
                      .fadeIn(delay: (200 * index).ms)
                      .slideY(begin: 0.2, end: 0);
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(
    String title,
    String description,
    IconData icon,
    Color accentColor,
  ) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);

    return Container(
      width:
          isMobile
              ? double.infinity
              : isTablet
              ? 300
              : 350,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accentColor.withValues(alpha: 0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 28, color: accentColor),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(fontSize: 15, color: Colors.white70, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineSection(
    bool isMobile,
    bool isTablet,
    EdgeInsets padding,
  ) {
    final timelineEvents = [
      {
        'year': '2025',
        'title': 'Club Foundation',
        'description':
            'Axios Club was established with a vision to create a community of tech enthusiasts at IIIT Bhopal.',
        'color': Color(0xFF8A6BF6),
      },
      {
        'year': '2025',
        'title': 'First Hackathon',
        'description':
            'Successfully organized the first intra-college hackathon with participation from over 100 students.',
        'color': Color(0xFFF7349D),
      },
      {
        'year': '2025',
        'title': 'Industry Partnerships',
        'description':
            'Formed partnerships with leading tech companies to provide internship opportunities and industry exposure.',
        'color': Color(0xFF6B8AF6),
      },
      {
        'year': '2025',
        'title': 'Open Source Initiative',
        'description':
            'Launched the open source initiative, contributing to various projects and creating our own repositories.',
        'color': Color(0xFFAC6BF6),
      },
      {
        'year': '2025',
        'title': 'National Recognition',
        'description':
            'Received recognition at national level tech competitions and expanded our community to over 300 active members.',
        'color': Color(0xFF34D399),
      },
      {
        'year': '2025',
        'title': 'Innovation Hub',
        'description':
            'Established a dedicated innovation hub with state-of-the-art facilities for project development and research.',
        'color': Color(0xFFF59E0B),
      },
    ];

    return Container(
      width: double.infinity,
      padding: padding.copyWith(top: 80, bottom: 80),
      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.2)),
      child: Column(
        children: [
          Text(
                "OUR JOURNEY",
                style: TextStyle(
                  fontSize: isMobile ? 24 : 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              )
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(
                duration: 3.seconds,
                color: Color(0xFF8A6BF6).withValues(alpha: 0.8),
              ),
          const SizedBox(height: 60),

          // Timeline
          isMobile
              ? Column(
                children:
                    timelineEvents.asMap().entries.map((entry) {
                      final index = entry.key;
                      final event = entry.value;
                      final isLast = index == timelineEvents.length - 1;

                      return _buildMobileTimelineItem(
                        event['year'] as String,
                        event['title'] as String,
                        event['description'] as String,
                        event['color'] as Color,
                        isLast,
                        index,
                      );
                    }).toList(),
              )
              : Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 1000),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children:
                              timelineEvents
                                  .asMap()
                                  .entries
                                  .where((entry) => entry.key % 2 == 0)
                                  .map((entry) {
                                    final index = entry.key;
                                    final event = entry.value;

                                    return _buildDesktopTimelineItem(
                                      event['year'] as String,
                                      event['title'] as String,
                                      event['description'] as String,
                                      event['color'] as Color,
                                      true,
                                      index,
                                    );
                                  })
                                  .toList(),
                        ),
                      ),

                      Container(
                        width: 2,
                        height: timelineEvents.length * 180 / 2,
                        color: Colors.white.withValues(alpha: 0.2),
                      ),

                      Expanded(
                        child: Column(
                          children:
                              timelineEvents
                                  .asMap()
                                  .entries
                                  .where((entry) => entry.key % 2 == 1)
                                  .map((entry) {
                                    final index = entry.key;
                                    final event = entry.value;

                                    return _buildDesktopTimelineItem(
                                      event['year'] as String,
                                      event['title'] as String,
                                      event['description'] as String,
                                      event['color'] as Color,
                                      false,
                                      index,
                                    );
                                  })
                                  .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildMobileTimelineItem(
    String year,
    String title,
    String description,
    Color color,
    bool isLast,
    int index,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.4),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 100,
                  color: Colors.white.withValues(alpha: 0.2),
                ),
            ],
          ),
          const SizedBox(width: 20),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    year,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (200 * index).ms).slideX(begin: -0.1, end: 0);
  }

  Widget _buildDesktopTimelineItem(
    String year,
    String title,
    String description,
    Color color,
    bool isLeft,
    int index,
  ) {
    return Container(
          height: 230,
          padding: EdgeInsets.only(
            bottom: 16,
            left: isLeft ? 0 : 30,
            right: isLeft ? 30 : 0,
          ),
          child: Row(
            mainAxisAlignment:
                isLeft ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                width: 300,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: color.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        year,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: (200 * index).ms)
        .slideX(begin: isLeft ? -0.1 : 0.1, end: 0);
  }

  Widget _buildStatsSection(bool isMobile, bool isTablet, EdgeInsets padding) {
    final stats = [
      {
        'value': '30+',
        'label': 'Active Members in Club',
        'icon': Icons.people_rounded,
        'color': Color(0xFF8A6BF6),
      },
      {
        'value': '50+',
        'label': 'Projects Completed',
        'icon': Icons.code_rounded,
        'color': Color(0xFFF7349D),
      },
      {
        'value': '20+',
        'label': 'Workshops Conducted',
        'icon': Icons.school_rounded,
        'color': Color(0xFF6B8AF6),
      },
      {
        'value': '10+',
        'label': 'Hackathons Organized',
        'icon': Icons.emoji_events_rounded,
        'color': Color(0xFFAC6BF6),
      },
    ];

    return Container(
      width: double.infinity,
      padding: padding.copyWith(top: 80, bottom: 80),
      child: Column(
        children: [
          Text(
                "OUR IMPACT",
                style: TextStyle(
                  fontSize: isMobile ? 24 : 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              )
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(
                duration: 3.seconds,
                color: Color(0xFF8A6BF6).withValues(alpha: 0.8),
              ),
          const SizedBox(height: 60),

          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children:
                stats.asMap().entries.map((entry) {
                  final index = entry.key;
                  final stat = entry.value;

                  return _buildStatCard(
                    stat['value'] as String,
                    stat['label'] as String,
                    stat['icon'] as IconData,
                    stat['color'] as Color,
                    index,
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String value,
    String label,
    IconData icon,
    Color color,
    int index,
  ) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
          width: isMobile ? double.infinity : 200,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.1),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 16),
              Text(
                    value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(
                    duration: 3.seconds,
                    color: color.withValues(alpha: 0.8),
                  ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: (200 * index).ms)
        .scale(begin: Offset(0.9, 0.9), end: Offset(1, 1));
  }

  Widget _buildJoinUsSection(bool isMobile, bool isTablet, EdgeInsets padding) {
    return Container(
      width: double.infinity,
      padding: padding.copyWith(top: 80, bottom: 80),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF8A6BF6).withValues(alpha: 0.2),
            Color(0xFFF7349D).withValues(alpha: 0.2),
          ],
        ),
      ),
      child: Column(
        children: [
          Text(
                "JOIN OUR COMMUNITY",
                style: TextStyle(
                  fontSize: isMobile ? 24 : 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              )
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(
                duration: 3.seconds,
                color: Color(0xFF8A6BF6).withValues(alpha: 0.8),
              ),
          const SizedBox(height: 20),

          Container(
            constraints: BoxConstraints(maxWidth: 800),
            child: Text(
              "Be part of a vibrant community that's passionate about technology, innovation, and growth. Join Axios Club to learn, build, and grow together.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 16 : 18,
                color: Colors.white70,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 40),

          // Benefits of joining
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _buildBenefitCard(
                "Skill Development",
                "Enhance your technical skills through workshops, projects, and peer learning.",
                Icons.trending_up_rounded,
              ),
              _buildBenefitCard(
                "Networking",
                "Connect with like-minded individuals, alumni, and industry professionals.",
                Icons.people_alt_rounded,
              ),
              _buildBenefitCard(
                "Portfolio Building",
                "Work on real projects that you can showcase in your professional portfolio.",
                Icons.work_rounded,
              ),
            ],
          ),

          const SizedBox(height: 50),

          ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF8A6BF6),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                  shadowColor: Color(0xFF8A6BF6).withValues(alpha: 0.5),
                ),
                child: Text(
                  "Join Axios Club",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              )
              .animate()
              .fadeIn(delay: 400.ms)
              .scale(begin: Offset(0.9, 0.9), end: Offset(1, 1)),
        ],
      ),
    );
  }

  Widget _buildBenefitCard(String title, String description, IconData icon) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      width: isMobile ? double.infinity : 250,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 30, color: Color(0xFF8A6BF6)),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: 15, color: Colors.white70, height: 1.5),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.2, end: 0);
  }
}
