import 'package:axios/models/team_member.dart';
import 'package:axios/utils/responsive_helper.dart';
import 'package:axios/widgets/footer.dart';
import 'package:axios/widgets/team_card.dart';
import 'package:flutter/material.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  // screens/team.dart
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

    final teamMembers = [
      TeamMember(
        name: 'Alex Johnson',
        role: 'Lead Developer',
        bio:
            'Full-stack developer with expertise in Flutter and Firebase. Passionate about creating beautiful and functional mobile applications.',
        skills: ['Flutter', 'Firebase', 'UI/UX', 'Dart'],
        imageUrl:
            'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        githubUrl: '',
        linkedinUrl: '',
        portfolioUrl: '',
        accentColor: const Color(0xFF8A6BF6),
      ),
      TeamMember(
        name: 'Sophia Chen',
        role: 'UI/UX Designer',
        bio:
            'Creative designer with a keen eye for detail. Specializes in creating intuitive and engaging user experiences.',
        skills: ['Figma', 'Adobe XD', 'Animation'],
        imageUrl:
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        githubUrl: '',
        linkedinUrl: '',
        accentColor: const Color(0xFFAC6BF6),
      ),
      TeamMember(
        name: 'Marcus Williams',
        role: 'Backend Developer',
        bio:
            'Experienced in building robust backend systems. Loves solving complex problems and optimizing performance.',
        skills: ['Node.js', 'MongoDB', 'AWS'],
        imageUrl:
            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        githubUrl: '',
        linkedinUrl: '',
        portfolioUrl: '',
        accentColor: const Color(0xFF6B8AF6),
      ),
      TeamMember(
        name: 'Priya Patel',
        role: 'Mobile Developer',
        bio:
            'Passionate about creating cross-platform mobile applications with a focus on performance and user experience.',
        skills: ['Flutter', 'Swift', 'Kotlin'],
        imageUrl:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        githubUrl: '',
        linkedinUrl: '',
        accentColor: const Color(0xFFC46BF6),
      ),
    ];

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
                  "Meet the Team",
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
                  "Get to know the talented individuals driving innovation and collaboration at Axios.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: isMobile ? 14 : 16,
                    color: Colors.white38,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),

            Padding(
              padding: contentPadding,
              child: Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children:
                    teamMembers.map((member) {
                      return TeamCard(
                        name: member.name,
                        role: member.role,
                        bio: member.bio,
                        skills: member.skills,
                        imageUrl: member.imageUrl,
                        githubUrl: member.githubUrl,
                        linkedinUrl: member.linkedinUrl,
                        portfolioUrl: member.portfolioUrl,
                        accentColor:
                            member.accentColor ?? const Color(0xFF8A6BF6),
                      );
                    }).toList(),
              ),
            ),

            SizedBox(height: 60),
            AxiosClubFooter(),
          ],
        ),
      ),
    );
  }
}
