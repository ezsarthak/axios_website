import 'package:axios/utils/responsive_helper.dart' show ResponsiveHelper;
import 'package:axios/widgets/event_card.dart';
import 'package:axios/widgets/footer.dart';
import 'package:flutter/material.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
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
  // screens/events.dart
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
                  "What's Happening",
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
                  "Stay in the loop with upcoming tech talks, hackathons, and all things Axios",
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
            const SizedBox(height: 24),

            Padding(
              padding: gridPadding,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Sample event data
                  final events = List.generate(
                    6,
                    (index) => {
                      'title': 'Haxios',
                      'description':
                          'Join us for a 24-hour coding marathon where you can build innovative solutions, network with fellow developers, and win exciting prizes!',
                      'dateTime': DateTime.now().add(Duration(days: 5)),
                      'location': 'NTB, IIIT Bhopal',
                      'imageUrl':
                          'https://plus.unsplash.com/premium_photo-1681400688788-a5fd7e7bcd89?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      'tags': ['Hackathon', 'Coding', 'Prizes'],
                    },
                  );

                  return Wrap(
                    spacing: 20,
                    runSpacing: 40,
                    alignment: WrapAlignment.center,
                    children:
                        events.map((event) {
                          return EventCard(
                            title: event['title'] as String,
                            description: event['description'] as String,
                            dateTime: event['dateTime'] as DateTime,
                            location: event['location'] as String,
                            imageUrl: event['imageUrl'] as String,
                            tags: (event['tags'] as List<String>),
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
