import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
  bool _isSending = false;
  bool _isSent = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _messageController.text.isEmpty) {
      return;
    }

    setState(() => _isSending = true);

    // Simulate sending
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isSending = false;
      _isSent = true;
    });

    // Reset after 3 seconds
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      setState(() => _isSent = false);
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
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
                Text(
                  '> ./contact.sh',
                  style: TextStyle(color: AppTheme.electricCyan, fontSize: 14),
                ).animate().fadeIn(duration: 300.ms),

                const SizedBox(height: 8),

                Text(
                  'Initialize contact protocol...',
                  style: const TextStyle(color: Colors.white54, fontSize: 14),
                ).animate().fadeIn(delay: 200.ms),

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
                Text(
                  '> Social Links:',
                  style: TextStyle(color: AppTheme.softPink, fontSize: 14),
                ).animate().fadeIn(delay: 600.ms),

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
                    color: Colors.white.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.electricCyan.withOpacity(0.3),
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
                      _buildInfoRow(Icons.access_time, 'Timezone: UTC+0'),
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
            color: Colors.white.withOpacity(0.03),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _isSending || _isSent ? null : _sendMessage,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _isSent
                  ? [Colors.green, Colors.green.shade700]
                  : [AppTheme.primaryPurple, AppTheme.electricCyan],
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: (_isSent ? Colors.green : AppTheme.primaryPurple)
                    .withOpacity(0.4),
                blurRadius: 12,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isSending)
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
                  _isSent ? Icons.check_circle : Icons.send,
                  size: 18,
                  color: Colors.white,
                ),
              const SizedBox(width: 8),
              Text(
                _isSending
                    ? 'Sending...'
                    : _isSent
                    ? 'Success!'
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
                ? widget.color.withOpacity(0.15)
                : Colors.white.withOpacity(0.03),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isHovered
                  ? widget.color.withOpacity(0.6)
                  : Colors.white.withOpacity(0.1),
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
                color: widget.color.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
