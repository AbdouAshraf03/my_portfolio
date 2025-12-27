import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/app_theme.dart';
import '../data/project_model.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '</> > cat projects.json',
            style: TextStyle(color: AppTheme.electricCyan, fontSize: 14),
          ).animate().fadeIn(duration: 300.ms),

          const SizedBox(height: 8),

          Text(
            'Loading project portfolio...',
            style: const TextStyle(color: Colors.white54, fontSize: 14),
          ).animate().fadeIn(delay: 200.ms),

          const SizedBox(height: 32),

          ...sampleProjects.asMap().entries.map((entry) {
            final index = entry.key;
            final project = entry.value;
            return _ProjectCard(project: project, index: index);
          }),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;
  final int index;

  const _ProjectCard({required this.project, required this.index});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  Color get _color {
    switch (widget.project.color) {
      case ProjectColor.purple:
        return AppTheme.primaryPurple;
      case ProjectColor.cyan:
        return AppTheme.electricCyan;
      case ProjectColor.pink:
        return AppTheme.softPink;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child:
          Container(
                margin: const EdgeInsets.only(bottom: 24),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.terminalBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _isHovered
                        ? _color.withAlpha(0.6 * 255 ~/ 1)
                        : Colors.white.withAlpha(0.1 * 255 ~/ 1),
                    width: _isHovered ? 2 : 1,
                  ),
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: _color.withAlpha(0.3 * 255 ~/ 1),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ]
                      : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Row(
                      children: [
                        Icon(Icons.star, size: 18, color: _color),
                        const SizedBox(width: 8),
                        Text(
                          widget.project.title,
                          style: TextStyle(
                            color: _color,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Description
                    Text(
                      widget.project.description,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Technologies
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.project.technologies.map((tech) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _color.withAlpha(0.15 * 255 ~/ 1),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: _color.withAlpha(0.3 * 255 ~/ 1),
                            ),
                          ),
                          child: Text(
                            tech,
                            style: TextStyle(color: _color, fontSize: 11),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 16),

                    // Links
                    Row(
                      children: [
                        if (widget.project.codeUrl != null)
                          _LinkButton(
                            label: 'Code',
                            icon: Icons.code,
                            url: widget.project.codeUrl!,
                            color: _color,
                          ),
                        if (widget.project.codeUrl != null &&
                            widget.project.demoUrl != null)
                          const SizedBox(width: 12),
                        if (widget.project.demoUrl != null)
                          _LinkButton(
                            label: 'Demo',
                            icon: Icons.open_in_new,
                            url: widget.project.demoUrl!,
                            color: _color,
                          ),
                      ],
                    ),
                  ],
                ),
              )
              .animate()
              .fadeIn(delay: (300 + widget.index * 100).ms)
              .slideY(begin: 0.2, end: 0),
    );
  }
}

class _LinkButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final String url;
  final Color color;

  const _LinkButton({
    required this.label,
    required this.icon,
    required this.url,
    required this.color,
  });

  @override
  State<_LinkButton> createState() => _LinkButtonState();
}

class _LinkButtonState extends State<_LinkButton> {
  bool _isHovered = false;

  Future<void> _launchUrl() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: _launchUrl,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovered
                ? widget.color.withAlpha(0.2 * 255 ~/ 1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: widget.color.withAlpha(
                _isHovered ? 0.8 * 255 ~/ 1 : 0.4 * 255 ~/ 1,
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 14, color: widget.color),
              const SizedBox(width: 6),
              Text(
                widget.label,
                style: TextStyle(color: widget.color, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
