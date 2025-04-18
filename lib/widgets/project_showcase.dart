import 'package:axios/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProjectShowcase extends StatefulWidget {
  const ProjectShowcase({super.key});

  @override
  State<ProjectShowcase> createState() => _ProjectShowcaseState();
}

class _ProjectShowcaseState extends State<ProjectShowcase> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  final List<Project> _projects = [
    Project(
      title: 'Campus Connect',
      description:
          'A mobile app connecting students across campus for events, study groups, and more.',
      imageUrl:
          'https://images.unsplash.com/photo-1639322537228-f710d846310a?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      techStack: ['Flutter', 'Firebase', 'Node.js'],
    ),
    Project(
      title: 'Smart Attendance',
      description:
          'Automated attendance system using facial recognition and machine learning.',
      imageUrl:
          'https://images.unsplash.com/photo-1514190753789-22afb20bcbbb?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      techStack: ['Python', 'TensorFlow', 'React'],
    ),
    Project(
      title: 'CodeCollab',
      description:
          'Real-time collaborative code editor with syntax highlighting and version control.',
      imageUrl:
          'https://images.unsplash.com/photo-1529661197280-63dc545366c8?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      techStack: ['JavaScript', 'Socket.io', 'MongoDB'],
    ),
    Project(
      title: 'AR Campus Tour',
      description:
          'Augmented reality tour guide for campus visitors and new students.',
      imageUrl:
          'https://plus.unsplash.com/premium_photo-1683746792239-6ce8cdd3ac78?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      techStack: ['Unity', 'ARCore', 'Flutter'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Column(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
            height: isMobile ? 300 : 400,
            viewportFraction: isMobile ? 0.9 : 0.8,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
          ),
          items:
              _projects.map((project) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha:.3),
                            blurRadius: 15,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            // Project Image
                            Positioned.fill(
                              child: CachedNetworkImage(
                                imageUrl: project.imageUrl,
                                fit: BoxFit.cover,
                                placeholder:
                                    (context, url) => Container(
                                      color: Colors.grey.shade800,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white54,
                                        ),
                                      ),
                                    ),
                                errorWidget:
                                    (context, url, error) => Container(
                                      color: Colors.grey.shade900,
                                      child: Icon(
                                        Icons.error_outline,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                    ),
                              ),
                            ),

                            // Gradient Overlay
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withValues(alpha:.8),
                                    ],
                                    stops: [0.6, 1.0],
                                  ),
                                ),
                              ),
                            ),

                            // Project Info
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      project.title,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: isMobile ? 20 : 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      project.description,
                                      style: TextStyle(
                                        color: Colors.white.withValues(alpha:.8),
                                        fontSize: isMobile ? 14 : 16,
                                      ),
                                      maxLines: isMobile ? 2 : 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 12),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children:
                                            project.techStack.map((tech) {
                                              return Container(
                                                margin: EdgeInsets.only(
                                                  right: 8,
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 5,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Color(
                                                    0xFF8A6BF6,
                                                  ).withValues(alpha:.3),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                    color: Color(
                                                      0xFF8A6BF6,
                                                    ).withValues(alpha:.5),
                                                  ),
                                                ),
                                                child: Text(
                                                  tech,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
        ),

        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              _projects.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _carouselController.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          _currentIndex == entry.key
                              ? Color(0xFF8A6BF6)
                              : Color(0xFF8A6BF6).withValues(alpha:.3),
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}

class Project {
  final String title;
  final String description;
  final String imageUrl;
  final List<String> techStack;

  Project({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.techStack,
  });
}
