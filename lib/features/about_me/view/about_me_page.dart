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
          Text(
            '> Loading developer profile...',
            style: TextStyle(color: AppTheme.electricCyan, fontSize: 14),
          ).animate().fadeIn(duration: 300.ms),

          const SizedBox(height: 24),

          // Bio Section
          _buildInfoSection(
            'Name',
            AppConstants.name,
            Icons.person_outline,
          ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.1),

          _buildInfoSection(
            'Role',
            AppConstants.role,
            Icons.code,
          ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1),

          _buildInfoSection(
            'Location',
            AppConstants.location,
            Icons.location_on_outlined,
          ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.1),

          _buildInfoSection(
            'Status',
            AppConstants.status,
            Icons.check_circle_outline,
          ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.1),

          const SizedBox(height: 32),

          // Skills Section
          Text(
            '> Initializing skill matrix...',
            style: TextStyle(color: AppTheme.electricCyan, fontSize: 14),
          ).animate().fadeIn(delay: 500.ms),

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
                .fadeIn(delay: (600 + index * 100).ms)
                .slideX(begin: -0.2);
          }),

          const SizedBox(height: 32),

          // Tech Stack
          Text(
            '> Tech Stack:',
            style: TextStyle(color: AppTheme.electricCyan, fontSize: 14),
          ).animate().fadeIn(delay: 1000.ms),

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
                  color: AppTheme.primaryPurple.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: AppTheme.primaryPurple.withOpacity(0.5),
                  ),
                ),
                child: Text(
                  tech,
                  style: TextStyle(color: AppTheme.primaryPurple, fontSize: 12),
                ),
              );
            }).toList(),
          ).animate().fadeIn(delay: 1100.ms),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppTheme.primaryPurple.withOpacity(0.8)),
          const SizedBox(width: 10),
          Text(
            '$label: ',
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
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
              color: Colors.white.withOpacity(0.05),
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
                              colors: [color.withOpacity(0.5), color],
                            ),
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: color.withOpacity(0.5),
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
    if (skill.contains('Backend')) return Icons.storage;
    if (skill.contains('Performance')) return Icons.speed;
    return Icons.code;
  }
}
