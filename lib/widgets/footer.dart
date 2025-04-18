import 'package:axios/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AxiosClubFooter extends StatelessWidget {
  const AxiosClubFooter({super.key});
  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      width: double.infinity,
      color: Color.fromARGB(255, 15, 5, 46),
      padding: EdgeInsets.symmetric(
        vertical: 40,
        horizontal: isMobile ? 20 : 20,
      ),
      child: Column(
        children: [
          Wrap(
            spacing: 40,
            runSpacing: 40,
            alignment: WrapAlignment.spaceAround,
            children: [
              SizedBox(
                width: isMobile ? double.infinity : 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          foregroundImage: AssetImage("assets/image.png"),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Axios IIIT Bhopal',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Driving a spirit of innovation and cutting-edge software development at IIIT Bhopal. Be a part of our journey to empower the next generation of tech leaders.',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),

              SizedBox(
                width: isMobile ? double.infinity : 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Quick Links',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildFooterLink('Events & Workshops', ''),
                    const SizedBox(height: 10),
                    _buildFooterLink('Projects', ''),
                    const SizedBox(height: 10),
                    _buildFooterLink('Our Team', ''),
                  ],
                ),
              ),

              // Contact
              SizedBox(
                width: isMobile ? double.infinity : 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Contact',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          const Icon(
                            Icons.email_outlined,
                            color: Colors.white70,
                            size: 18,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'axios@iiitbhopal.ac.in',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Colors.white70,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'IIIT Bhopal, NTB, MANIT Campus, Bhopal, India',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(
                width: isMobile ? double.infinity : 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Follow Us',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        _buildSocialIcon(
                          FontAwesomeIcons.instagram,
                          'https://instagram.com',
                        ),
                        _buildSocialIcon(
                          FontAwesomeIcons.xTwitter,
                          'https://twitter.com',
                        ),
                        _buildSocialIcon(
                          FontAwesomeIcons.linkedinIn,
                          'https://linkedin.com',
                        ),
                        _buildSocialIcon(
                          FontAwesomeIcons.github,
                          'https://github.com',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Stay updated with our latest news, events, and projects!',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),
          Container(
            height: 1,
            color: Colors.white24,
            width: MediaQuery.of(context).size.width * (isMobile ? 0.95 : 0.85),
          ),
          const SizedBox(height: 20),

          const Text(
            '© 2025 Axios Club IIIT Bhopal. All rights reserved.',
            style: TextStyle(color: Colors.white70, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Made with ',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const Icon(Icons.favorite, color: Colors.red, size: 14),
              const Text(
                ' by Sarthak Patil',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink(String title, String url) {
    return InkWell(
      onTap: () {},
      child: Text(
        title,
        style: const TextStyle(color: Colors.white70, fontSize: 14),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: InkWell(
        onTap: () {},
        child: FaIcon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
