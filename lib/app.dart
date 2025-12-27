import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'core/app_theme.dart';

import 'features/about_me/view/about_me_page.dart';
import 'features/contact/view/contact_page.dart';
import 'features/mainTab/bloc/main_tab_bloc.dart';
import 'features/mainTab/view/main_tab_page.dart';

import 'features/project/view/project_page.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio Terminal',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [BlocProvider(create: (_) => MainTabBloc())],
        child: const PortfolioTerminal(),
      ),
    );
  }
}

class PortfolioTerminal extends StatefulWidget {
  const PortfolioTerminal({super.key});

  @override
  State<PortfolioTerminal> createState() => _PortfolioTerminalState();
}

class _PortfolioTerminalState extends State<PortfolioTerminal>
    with TickerProviderStateMixin {
  int _currentTab = 0;
  final List<String> _tabs = ['main', 'about_me', 'projects', 'contact'];
  late AnimationController _backgroundController;

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    super.dispose();
  }

  void _navigateToTab(int index) {
    setState(() => _currentTab = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _backgroundController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.darkBg,
                  AppTheme.deepPurple.withOpacity(0.2),
                  AppTheme.darkBg,
                ],
                stops: [0.0, 0.5 + _backgroundController.value * 0.3, 1.0],
              ),
            ),
            child: child,
          );
        },
        child: Center(
          child:
              Container(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 40,
                    ),
                    decoration: AppTheme.terminalDecoration,
                    child: Column(
                      children: [
                        // Terminal header
                        _buildTerminalHeader()
                            .animate()
                            .fadeIn(duration: 300.ms)
                            .slideY(begin: -0.2),

                        // Tab bar
                        _buildTabBar().animate().fadeIn(
                          delay: 200.ms,
                          duration: 300.ms,
                        ),

                        // Content
                        Expanded(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0.1, 0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              );
                            },
                            child: _buildTabContent(),
                          ),
                        ),
                      ],
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .scale(begin: const Offset(0.95, 0.95)),
        ),
      ),
    );
  }

  Widget _buildTerminalHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          _buildWindowButton(Colors.red.shade400),
          const SizedBox(width: 8),
          _buildWindowButton(Colors.yellow.shade600),
          const SizedBox(width: 8),
          _buildWindowButton(Colors.green.shade400),
          const SizedBox(width: 16),
          const Text(
            'portfolio.cmd',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const Spacer(),
          // Minimize, maximize, close icons (decorative)
          Icon(Icons.minimize, size: 16, color: Colors.white30),
          const SizedBox(width: 8),
          Icon(Icons.crop_square, size: 14, color: Colors.white30),
          const SizedBox(width: 8),
          Icon(Icons.close, size: 16, color: Colors.white30),
        ],
      ),
    );
  }

  Widget _buildWindowButton(Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: color.withOpacity(0.6), blurRadius: 4)],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
      ),
      child: Row(
        children: List.generate(_tabs.length, (index) {
          final isActive = _currentTab == index;
          return _TabButton(
            label: _tabs[index],
            isActive: isActive,
            onTap: () => _navigateToTab(index),
          );
        }),
      ),
    );
  }

  Widget _buildTabContent() {
    return Container(
      key: ValueKey<int>(_currentTab),
      child: switch (_currentTab) {
        0 => MainTabPage(onNavigate: _navigateToTab),
        1 => const AboutPage(),
        2 => const ProjectsPage(),
        3 => const ContactPage(),
        _ => MainTabPage(onNavigate: _navigateToTab),
      },
    );
  }
}

class _TabButton extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_TabButton> createState() => _TabButtonState();
}

class _TabButtonState extends State<_TabButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: _isHovered && !widget.isActive
                ? Colors.white.withOpacity(0.05)
                : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: widget.isActive
                    ? AppTheme.primaryPurple
                    : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: widget.isActive
                  ? AppTheme.primaryPurple
                  : _isHovered
                  ? Colors.white70
                  : Colors.white54,
              fontSize: 13,
              fontWeight: widget.isActive ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
