import 'package:axios/utils/responsive_helper.dart';
import 'package:axios/widgets/blog_card.dart';
import 'package:axios/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RoadmapScreen extends StatefulWidget {
  const RoadmapScreen({super.key});

  @override
  State<RoadmapScreen> createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen> {
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
    final gridPadding = EdgeInsets.symmetric(
      horizontal:
          isMobile
              ? 20
              : isTablet
              ? 40
              : 80,
    );

    return Scaffold(
      backgroundColor: Color(0xff13053B),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            AppBar(
              backgroundColor: Color(0xff13053B),
              elevation: 0,
              title: Center(
                child: Text(
                  "Our Roadmap",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: isMobile ? 28 : 32,
                    letterSpacing: 3,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
            Padding(
              padding: contentPadding,
              child: Center(
                child: Text(
                  "Explore our vision, milestones, and the journey we're taking to empower developers and build impactful projects",
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

            Padding(
              padding: gridPadding,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final roadmaps = [
                    {
                      'title': 'App Development Roadmap',
                      'excerpt':
                          'Step-by-step guide to becoming a proficient app developer using Flutter or native tools.',
                      'imageUrl':
                          'https://guarana-technologies.com/hubfs/is-mobile-app-development-profitable.png',
                      'author': 'Team Axios',
                      'authorImageUrl':
                          'https://avatars.githubusercontent.com/u/9919?s=280&v=4',
                      'date': DateTime.now().subtract(const Duration(days: 3)),
                      'accentColor': Color(0xff6C63FF),
                      'categories': ['Flutter', 'Kotlin', 'Swift'],
                      'onTap': () async {
                        Uri url = Uri(
                          path: 'flutter',
                          host: 'roadmap.sh',
                          scheme: 'https',
                        );
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    },
                    {
                      'title': 'Web Development Roadmap',
                      'excerpt':
                          'Explore the essential skills and tools needed to master frontend and backend web development.',
                      'imageUrl':
                          'https://www.simplilearn.com/ice9/free_resources_article_thumb/is_web_development_good_career.jpg',
                      'author': 'Team Axios',
                      'authorImageUrl':
                          'https://avatars.githubusercontent.com/u/9919?s=280&v=4',
                      'date': DateTime.now().subtract(const Duration(days: 2)),
                      'accentColor': Color(0xff34D399),
                      'categories': ['HTML', 'CSS', 'JavaScript', 'React'],
                      'onTap': () async {
                        Uri url = Uri(
                          path: 'frontend',
                          host: 'roadmap.sh',
                          scheme: 'https',
                        );
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    },
                    {
                      "title": 'AI/ML Roadmap',
                      'excerpt':
                          'A comprehensive path to understanding Artificial Intelligence and Machine Learning from scratch.',
                      'imageUrl':
                          'https://www.innovapptive.com/hubfs/The%20Impact%20of%20Artificial%20Intelligence%20%26amp_%20Machine%20Learning%20%28AI_ML%29%20on%20Operations_BLOG%20COVER_20200225.png',
                      'author': 'Team Axios',
                      'authorImageUrl':
                          'https://avatars.githubusercontent.com/u/9919?s=280&v=4',
                      'date': DateTime.now().subtract(const Duration(days: 1)),
                      'accentColor': Color(0xffF59E0B),
                      'onTap': () async {
                        Uri url = Uri(
                          path: 'ai-engineer',
                          host: 'roadmap.sh',
                          scheme: 'https',
                        );
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      'categories': ['Python', 'TensorFlow', 'NLP'],
                    },
                    {
                      'title': 'Data Science Roadmap',
                      'excerpt':
                          'From data cleaning to visualization and machine learning, learn how to become a data scientist.',
                      'imageUrl':
                          'https://www.mygreatlearning.com/blog/wp-content/uploads/2019/09/What-is-data-science-2.jpg',
                      'author': 'Team Axios',
                      'authorImageUrl':
                          'https://avatars.githubusercontent.com/u/9919?s=280&v=4',
                      'date': DateTime.now().subtract(const Duration(days: 4)),
                      'accentColor': Color(0xffF7349D),
                      'categories': ['Pandas', 'Matplotlib', 'SciKit-Learn'],
                      'onTap': () async {
                        Uri url = Uri(
                          path: 'ai-data-scientist',
                          host: 'roadmap.sh',
                          scheme: 'https',
                        );
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    },
                    {
                      'title': 'Cybersecurity Roadmap',
                      'excerpt':
                          'Dive into the world of cybersecurity, from ethical hacking to secure systems architecture.',
                      'imageUrl':
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReArpfupmkmZi3gFxf1R2T8TjPMHMTk604uw&s',
                      'author': 'Team Axios',
                      'authorImageUrl':
                          'https://avatars.githubusercontent.com/u/9919?s=280&v=4',
                      'date': DateTime.now().subtract(const Duration(days: 6)),
                      'accentColor': Color(0xff3B82F6),
                      'onTap': () async {
                        Uri url = Uri(
                          path: 'cyber-security',
                          host: 'roadmap.sh',
                          scheme: 'https',
                        );
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      'categories': ['Linux', 'Networking', 'Pen Testing'],
                    },
                    {
                      'title': 'DevOps & Cloud Roadmap',
                      'excerpt':
                          'Learn how to deploy, monitor, and scale applications with modern DevOps practices.',
                      'imageUrl':
                          'https://www.simplilearn.com/ice9/free_resources_article_thumb/Mastering_The_Future_With_A_Master_Degree_In_Cloud_Computing.jpg',
                      'author': 'Team Axios',
                      'authorImageUrl':
                          'https://avatars.githubusercontent.com/u/9919?s=280&v=4',
                      'date': DateTime.now().subtract(const Duration(days: 5)),
                      'accentColor': Color(0xff10B981),
                      'categories': ['Docker', 'Kubernetes', 'AWS'],
                      'onTap': () async {
                        Uri url = Uri(
                          path: 'devops',
                          host: 'roadmap.sh',
                          scheme: 'https',
                        );
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    },
                  ];

                  return Wrap(
                    spacing: 20,
                    runSpacing: 40,
                    alignment: WrapAlignment.center,
                    children:
                        roadmaps.map((roadmap) {
                          return BlogCard(
                            title: roadmap['title'] as String,
                            excerpt: roadmap['excerpt'] as String,
                            imageUrl: roadmap['imageUrl'] as String,
                            author: roadmap['author'] as String,
                            authorImageUrl: roadmap['authorImageUrl'] as String,
                            date: roadmap['date'] as DateTime,
                            categories: (roadmap['categories'] as List<String>),
                            accentColor: roadmap['accentColor'] as Color,
                            onTap: roadmap['onTap'] as VoidCallback,
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
