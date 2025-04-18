import 'package:flutter/material.dart';

class TeamMember {
  final String name;
  final String role;
  final String bio;
  final List<String> skills;
  final String imageUrl;
  final String? githubUrl;
  final String? linkedinUrl;
  final String? portfolioUrl;
  final Color? accentColor;

  TeamMember({
    required this.name,
    required this.role,
    required this.bio,
    required this.skills,
    required this.imageUrl,
    this.githubUrl,
    this.linkedinUrl,
    this.portfolioUrl,
    this.accentColor,
  });
}
