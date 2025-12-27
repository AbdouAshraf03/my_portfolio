import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/features/contact/cubit/contact_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/app_const.dart';
import '../../../core/app_theme.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side - Form
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      '> ./contact.sh',
                      textStyle: TextStyle(
                        color: AppTheme.electricCyan,
                        fontSize: 14,
                      ),
                      speed: Duration(milliseconds: 70),
                    ),
                  ],
                  isRepeatingAnimation: false,
                ),

                const SizedBox(height: 8),

                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Initialize contact protocol...',
                      textStyle: const TextStyle(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
                      speed: Duration(milliseconds: 70),
                    ),
                  ],
                  isRepeatingAnimation: false,
                ),

                const SizedBox(height: 32),

                // Name field
                _buildInputField(
                  label: 'name',
                  controller: _nameController,
                  hint: 'Enter your name...',
                ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.1),

                const SizedBox(height: 20),

                // Email field
                _buildInputField(
                  label: 'email',
                  controller: _emailController,
                  hint: 'your@email.com',
                ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.1),

                const SizedBox(height: 20),

                // Message field
                _buildInputField(
                  label: 'message',
                  controller: _messageController,
                  hint: 'Type your message...',
                  maxLines: 5,
                ).animate().fadeIn(delay: 500.ms).slideX(begin: -0.1),

                const SizedBox(height: 24),

                // Submit button
                _buildSubmitButton(),
              ],
            ),
          ),

          const SizedBox(width: 40),

          // Right side - Social Links
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      '> Social Links:',
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

                _SocialLink(
                  icon: Icons.code,
                  label: 'GitHub',
                  url: AppConstants.githubUrl,
                  color: AppTheme.primaryPurple,
                ).animate().fadeIn(delay: 700.ms).slideX(begin: 0.1),

                _SocialLink(
                  icon: Icons.work_outline,
                  label: 'LinkedIn',
                  url: AppConstants.linkedinUrl,
                  color: AppTheme.electricCyan,
                ).animate().fadeIn(delay: 800.ms).slideX(begin: 0.1),

                _SocialLink(
                  icon: Icons.email_outlined,
                  label: 'Email',
                  url: 'mailto:${AppConstants.email}',
                  color: AppTheme.primaryPurple,
                ).animate().fadeIn(delay: 1000.ms).slideX(begin: 0.1),

                const SizedBox(height: 32),

                // Quick Info
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(0.03 * 255 ~/ 1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.electricCyan.withAlpha(0.3 * 255 ~/ 1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '> Quick Info:',
                        style: TextStyle(
                          color: AppTheme.electricCyan,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildInfoRow(
                        Icons.location_on_outlined,
                        'Location: ${AppConstants.location}',
                      ),
                      _buildInfoRow(
                        Icons.access_time,
                        'Timezone: ${DateTime.now().timeZoneName}',
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 1100.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '\$ $label:',
          style: TextStyle(
            color: AppTheme.electricCyan,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(0.03 * 255 ~/ 1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withAlpha(0.1 * 255 ~/ 1)),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.white.withAlpha(0.3 * 255 ~/ 1),
              ),
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return BlocConsumer<ContactCubit, ContactState>(
      listener: (_, state) async {
        if (state is ContactError || state is ContactSucces) {
          await Future.delayed(Duration(seconds: 3));
          if (mounted) {
            if (state is ContactSucces) {
              _nameController.clear();
              _emailController.clear();
              _messageController.clear();
            }
            context.read<ContactCubit>().rest();
          }
        }
      },
      builder: (context, state) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: state is ContactLoading
                ? null
                : () {
                    context.read<ContactCubit>().sendMail(
                      _nameController.text,
                      _emailController.text,
                      _messageController.text,
                    );
                  },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: state is ContactSucces
                      ? [Colors.green, Colors.green.shade700]
                      : state is ContactError
                      ? [AppTheme.softPink, AppTheme.softPink]
                      : [AppTheme.primaryPurple, AppTheme.electricCyan],
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color:
                        (state is ContactSucces
                                ? Colors.green
                                : AppTheme.primaryPurple)
                            .withAlpha(0.4 * 255 ~/ 1),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state is ContactLoading)
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  else
                    Icon(
                      state is ContactSucces ? Icons.check_circle : Icons.send,
                      size: 18,
                      color: Colors.white,
                    ),
                  const SizedBox(width: 8),
                  Text(
                    state is ContactLoading
                        ? 'Sending...'
                        : state is ContactSucces
                        ? 'Success!'
                        : state is ContactError
                        ? state.massage
                        : 'Send Message',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).animate().fadeIn(delay: 600.ms);
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.white54),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialLink extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;
  final Color color;

  const _SocialLink({
    required this.icon,
    required this.label,
    required this.url,
    required this.color,
  });

  @override
  State<_SocialLink> createState() => _SocialLinkState();
}

class _SocialLinkState extends State<_SocialLink> {
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
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _isHovered
                ? widget.color.withAlpha(0.15 * 255 ~/ 1)
                : Colors.white.withAlpha(0.03 * 255 ~/ 1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isHovered
                  ? widget.color.withAlpha(0.6 * 255 ~/ 1)
                  : Colors.white.withAlpha(0.1 * 255 ~/ 1),
            ),
          ),
          child: Row(
            children: [
              Icon(widget.icon, size: 18, color: widget.color),
              const SizedBox(width: 12),
              Text(
                widget.label,
                style: TextStyle(
                  color: _isHovered ? widget.color : Colors.white70,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward,
                size: 16,
                color: widget.color.withAlpha(0.5 * 255 ~/ 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
