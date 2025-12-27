import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_portfolio/core/app_const.dart';

import '../../../core/app_theme.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                '> Loading developer profile...',
                textStyle: const TextStyle(
                  color: AppTheme.electricCyan,
                  fontSize: 14,
                ),
                speed: Duration(milliseconds: 70),
              ),
            ],
            isRepeatingAnimation: false,
          ),

          const SizedBox(height: 24),

          // Bio Section
          _buildInfoSection('Name', AppConstants.name, Icons.person_outline),

          _buildInfoSection('Role', AppConstants.role, Icons.code),

          _buildInfoSection(
            'Location',
            AppConstants.location,
            Icons.location_on_outlined,
          ),

          _buildInfoSection(
            'Status',
            AppConstants.status,
            Icons.check_circle_outline,
          ),

          const SizedBox(height: 32),

          // Skills Section
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                '> Initializing skill matrix...',
                textStyle: const TextStyle(
                  color: AppTheme.electricCyan,
                  fontSize: 14,
                ),
                speed: Duration(milliseconds: 70),
              ),
            ],
            isRepeatingAnimation: false,
          ),

          const SizedBox(height: 20),

          ...AppConstants.skills.entries.map((entry) {
            final index = AppConstants.skills.keys.toList().indexOf(entry.key);
            final colors = [
              AppTheme.electricCyan,
              AppTheme.softPink,
              AppTheme.primaryPurple,
              AppTheme.electricCyan,
            ];

            return _buildSkillBar(
                  entry.key,
                  entry.value,
                  colors[index % colors.length],
                )
                .animate()
                .fadeIn(delay: (500 + index * 200).ms)
                .slideX(begin: -0.2);
          }),

          const SizedBox(height: 32),

          // Tech Stack
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                '> Tech Stack:',
                textStyle: const TextStyle(
                  color: AppTheme.electricCyan,
                  fontSize: 14,
                ),
                speed: Duration(milliseconds: 70),
              ),
            ],
            isRepeatingAnimation: false,
          ),

          const SizedBox(height: 16),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: AppConstants.techStack.map((tech) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.primaryPurple.withAlpha(0.2 * 255 ~/ 1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: AppTheme.primaryPurple.withAlpha(0.5 * 255 ~/ 1),
                  ),
                ),
                child: Text(
                  tech,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              );
            }).toList(),
          ).animate().fadeIn(delay: 600.ms),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: AppTheme.primaryPurple.withAlpha(0.8 * 255 ~/ 1),
          ),
          const SizedBox(width: 10),
          Text(
            '$label: ',
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          Expanded(
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  value,
                  textStyle: const TextStyle(color: Colors.white, fontSize: 14),
                  speed: Duration(milliseconds: 70),
                  cursor: '|',
                ),
              ],
              isRepeatingAnimation: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillBar(String skill, double value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(_getSkillIcon(skill), size: 16, color: color),
                  const SizedBox(width: 8),
                  Text(
                    skill,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
              Text(
                '${(value * 100).toInt()}%',
                style: TextStyle(
                  color: color,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(0.05 * 255 ~/ 1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Container(
                          width: constraints.maxWidth * value,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [color.withAlpha(0.5 * 255 ~/ 1), color],
                            ),
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: color.withAlpha(0.5 * 255 ~/ 1),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                        )
                        .animate(onPlay: (controller) => controller.forward())
                        .scaleX(
                          begin: 0,
                          end: 1,
                          duration: 1000.ms,
                          curve: Curves.easeOut,
                          alignment: Alignment.centerLeft,
                        ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _getSkillIcon(String skill) {
    if (skill.contains('Frontend')) return Icons.web;
    if (skill.contains('Design')) return Icons.palette;
    // if (skill.contains('Backend')) return Icons.storage;
    if (skill.contains('Performance')) return Icons.speed;
    return Icons.code;
  }
}
