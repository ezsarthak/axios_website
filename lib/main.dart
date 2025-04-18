import 'package:axios/screens/blogs.dart';
import 'package:axios/screens/events.dart';
import 'package:axios/screens/home.dart';
import 'package:axios/screens/project.dart';
import 'package:axios/screens/roadmap.dart';
import 'package:axios/screens/team.dart';
import 'package:axios/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Axios Club',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        'nav': (context) => Navigator(),
        '': (context) => Navigation(),
        'roadmap': (context) => RoadmapScreen(),
      },
      theme: ThemeData(
        fontFamily: 'Montserrat',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Navigation(),
    );
  }
}

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  List<Widget> pages = [
    MyHomePage(),
    ProjectScreen(),
    BlogsScreen(),
    EventsScreen(),
    TeamScreen(),
  ];
  int currIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xff13053B),
      child: Column(
        children: [
          ResponsiveNavBar(
            currentIndex: currIndex,
            onIndexChanged: (index) {
              setState(() {
                currIndex = index;
              });
            },
          ),
          Expanded(
            child: PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return pages[currIndex];
              },
            ),
          ),
        ],
      ),
    );
  }
}
