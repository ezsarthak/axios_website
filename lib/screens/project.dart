import 'package:axios/utils/responsive_helper.dart';
import 'package:axios/widgets/footer.dart';
import 'package:axios/widgets/project_card.dart';
import 'package:flutter/material.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  int _selectedTabIndex = 0;
  final List<String> _tabs = [
    'All',
    'Web',
    'App',
    'AI & ML',
    'UI/UX Design',
    'Data Science',
    'Cyber Security',
  ];
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: contentPadding.copyWith(top: 20),
              child: Center(
                child: Text(
                  "Projects That Push Boundaries",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: isMobile ? 24 : 32,
                    letterSpacing: isMobile ? 2 : 3,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: contentPadding,
              child: Center(
                child: Text(
                  "We learn by building — from AI to web and app development, our projects are bold experiments and portfolio-worthy creations",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: isMobile ? 14 : 16,
                    color: Colors.white38,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Tab Bar
            Padding(
              padding: contentPadding,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children:
                      _tabs.asMap().entries.map((entry) {
                        final index = entry.key;
                        final tab = entry.value;
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: FilterChip(
                            selected: _selectedTabIndex == index,
                            label: Text(
                              tab,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color:
                                    _selectedTabIndex != index
                                        ? Colors.white24
                                        : Color(0xffF7349D).withValues(alpha:0.4),
                              ),
                            ),
                            elevation: 0,
                            backgroundColor: Color(0xff13053B),
                            selectedColor: Color(0xff13053B),
                            checkmarkColor: Color(0xffF7349D).withValues(alpha:0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color:
                                    _selectedTabIndex != index
                                        ? Colors.white12
                                        : Color(0xffF7349D).withValues(alpha:0.4),
                              ),
                            ),
                            onSelected: (bool selected) {
                              setState(() {
                                _selectedTabIndex = index;
                              });
                            },
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Project Cards - Responsive Grid
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal:
                    isMobile
                        ? 20
                        : isTablet
                        ? 40
                        : 80,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final projects = [
                    {
                      'title': 'SmartVault',
                      'description':
                          'An offline, AES256-encrypted file vault built using Flutter and Rust with Dart FFI. Ideal for storing sensitive files securely.',
                      'techStack': ['Flutter', 'Rust', 'Dart FFI'],
                      'imageUrl':
                          'https://images.unsplash.com/photo-1514190753789-22afb20bcbbb?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      'accentColor': Color(0xff6C63FF),
                    },
                    {
                      'title': 'EcoCycle',
                      'description':
                          'An AI-powered e-waste management app that helps users recycle or resell electronics using smart classification.',
                      'techStack': ['Flutter', 'TensorFlow', 'Firebase'],
                      'imageUrl':
                          'https://images.unsplash.com/photo-1614201756100-1ccde6a6589e?q=80&w=1976&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      'accentColor': Color(0xff34D399),
                    },
                    {
                      'title': 'DevConnect',
                      'description':
                          'A developer-centric social media platform to share projects, blogs, and collaborate on tech ideas.',
                      'techStack': ['Flutter', 'Node.js', 'MongoDB'],
                      'imageUrl':
                          'https://images.unsplash.com/photo-1639322537228-f710d846310a?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      'accentColor': Color(0xffF59E0B),
                    },
                    {
                      'title': 'Portfolio Generator',
                      'description':
                          'Create stunning developer portfolios in minutes using a drag-and-drop editor built with Flutter web.',
                      'techStack': ['Flutter Web', 'Hive', 'Google Fonts'],
                      'imageUrl':
                          'https://images.unsplash.com/photo-1526739142041-282303fca915?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      'accentColor': Color(0xffF7349D),
                    },
                    {
                      'title': 'CampusKart',
                      'description':
                          'A campus-focused delivery and listing app to connect buyers and sellers within a college environment.',
                      'techStack': ['Flutter', 'Firebase', 'GeoFirestore'],
                      'imageUrl':
                          'https://plus.unsplash.com/premium_photo-1683746792239-6ce8cdd3ac78?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      'accentColor': Color(0xffF59E0B),
                    },
                    {
                      'title': 'E-Commerce App',
                      'description':
                          'A full-featured e-commerce application with product catalog, shopping cart, and payment integration.',
                      'techStack': ['Flutter', 'Firebase', 'Stripe'],
                      'imageUrl':
                          'https://images.unsplash.com/photo-1607082349566-187342175e2f?q=80&w=2070',
                      'accentColor': Color(0xff3B82F6),
                    },
                  ];



                  return Wrap(
                    spacing: 40,
                    runSpacing: 40,
                    alignment: WrapAlignment.center,
                    children:
                        projects.map((project) {
                          return ProjectCard(
                            title: project['title'] as String,
                            description: project['description'] as String,
                            techStack: (project['techStack'] as List<String>),
                            imageUrl: project['imageUrl'] as String,
                            accentColor: project['accentColor'] as Color,
                          );
                        }).toList(),
                  );
                },
              ),
            ),

            SizedBox(height: 120),
            AxiosClubFooter(),
          ],
        ),
      ),
    );
  }
}
