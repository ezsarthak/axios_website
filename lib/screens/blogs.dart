import 'package:axios/utils/responsive_helper.dart';
import 'package:axios/widgets/blog_card.dart';
import 'package:axios/widgets/footer.dart';
import 'package:flutter/material.dart';

class BlogsScreen extends StatefulWidget {
  const BlogsScreen({super.key});

  @override
  State<BlogsScreen> createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
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
  // screens/blogs.dart
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
            Padding(
              padding: contentPadding.copyWith(top: 20),
              child: Center(
                child: Text(
                  "Axios Journal",
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
                  "Thoughts, trends, and tutorials to fuel your dev journey.",
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
                  // Sample blog data
                  final blogs = [
                    {
                      'title':
                          'How We Built Our College Attendance System Using Machine Learning',
                      'excerpt':
                          'A deep dive into our latest project that uses facial recognition to automate the attendance process in our college classrooms.',
                      'imageUrl':
                          'https://media.istockphoto.com/id/1456166338/photo/finger-print-scan-security-system-on-wall-in-a-office-building.jpg?s=1024x1024&w=is&k=20&c=4nuRWe9PIA1wkE79LCFWVj36a362kxA2Px9Axn8Kqwg=',
                      'author': 'Arjun Mehta',
                      'authorImageUrl':
                          'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      'date': DateTime.now().subtract(const Duration(days: 7)),
                      'accentColor': const Color(0xff6C63FF),
                      'categories': ['ML/AI', 'Python', 'OpenCV'],
                    },
                    {
                      'title':
                          'Web Development Workshop Recap: Building Your First React App',
                      'excerpt':
                          'Check out what we learned in our recent workshop where students built their first React application from scratch with modern tooling.',
                      'imageUrl':
                          'https://images.unsplash.com/photo-1633356122102-3fe601e05bd2?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      'author': 'Rahul Patel',
                      'authorImageUrl':
                          'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      'date': DateTime.now().subtract(const Duration(days: 5)),
                      'accentColor': const Color(0xff34D399),
                      'categories': ['React', 'Web Dev', 'JavaScript'],
                    },
                    {
                      'title': 'Building a Real-time Chat App with Flutter',
                      'excerpt':
                          'Learn how to create a fully functional chat application using Flutter and Firebase Firestore for real-time messaging and user authentication.',
                      'imageUrl':
                          'https://plus.unsplash.com/premium_photo-1676057060928-c717a8e96784?q=80&w=2032&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      'author': 'Priya Sharma',
                      'authorImageUrl':
                          'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      'date': DateTime.now().subtract(const Duration(days: 2)),
                      'accentColor': const Color(0xffF59E0B),
                      'categories': ['Flutter', 'Firebase', 'Mobile'],
                    },
                    {
                      'title':
                          'How We Built Our College Attendance System Using Machine Learning',
                      'excerpt':
                          'A deep dive into our latest project that uses facial recognition to automate the attendance process in our college classrooms.',
                      'imageUrl':
                          'https://media.istockphoto.com/id/1456166338/photo/finger-print-scan-security-system-on-wall-in-a-office-building.jpg?s=1024x1024&w=is&k=20&c=4nuRWe9PIA1wkE79LCFWVj36a362kxA2Px9Axn8Kqwg=',
                      'author': 'Arjun Mehta',
                      'authorImageUrl':
                          'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      'date': DateTime.now().subtract(const Duration(days: 7)),
                      'accentColor': const Color(0xffF7349D),
                      'categories': ['ML/AI', 'Python', 'OpenCV'],
                    },
                    {
                      'title':
                          'Web Development Workshop Recap: Building Your First React App',
                      'excerpt':
                          'Check out what we learned in our recent workshop where students built their first React application from scratch with modern tooling.',
                      'imageUrl':
                          'https://images.unsplash.com/photo-1633356122102-3fe601e05bd2?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      'author': 'Rahul Patel',
                      'authorImageUrl':
                          'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      'date': DateTime.now().subtract(const Duration(days: 5)),
                      'accentColor': const Color(0xffF59E0B),
                      'categories': ['React', 'Web Dev', 'JavaScript'],
                    },
                    {
                      'title': 'Building a Real-time Chat App with Flutter',
                      'excerpt':
                          'Learn how to create a fully functional chat application using Flutter and Firebase Firestore for real-time messaging and user authentication.',
                      'imageUrl':
                          'https://plus.unsplash.com/premium_photo-1676057060928-c717a8e96784?q=80&w=2032&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      'author': 'Priya Sharma',
                      'authorImageUrl':
                          'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      'date': DateTime.now().subtract(const Duration(days: 2)),
                      'accentColor': const Color(0xff3B82F6),
                      'categories': ['Flutter', 'Firebase', 'Mobile'],
                    },
                  ];

                  return Wrap(
                    spacing: 40,
                    runSpacing: 40,
                    alignment: WrapAlignment.center,
                    children:
                        blogs.map((blog) {
                          return BlogCard(
                            title: blog['title'] as String,
                            excerpt: blog['excerpt'] as String,
                            imageUrl: blog['imageUrl'] as String,
                            author: blog['author'] as String,
                            authorImageUrl: blog['authorImageUrl'] as String,
                            date: blog['date'] as DateTime,
                            categories: (blog['categories'] as List<String>),
                            accentColor: blog['accentColor'] as Color,
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
