import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/app_theme.dart';
import '../bloc/main_tab_bloc.dart';
import '../bloc/main_tab_event.dart';
import '../bloc/main_tab_state.dart';

class MainTabPage extends StatefulWidget {
  final Function(int)? onNavigate;

  const MainTabPage({super.key, this.onNavigate});

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Auto focus on mount
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submitCommand() {
    final command = _controller.text.trim();
    context.read<MainTabBloc>().add(CommandSubmitted(command));
    _controller.clear();

    // Scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainTabBloc, MainTabState>(
      listener: (context, state) {
        if (state.navigationCommand != null && widget.onNavigate != null) {
          switch (state.navigationCommand) {
            case 'about':
              widget.onNavigate!(1);
              break;
            case 'projects':
              widget.onNavigate!(2);
              break;
            case 'contact':
              widget.onNavigate!(3);
              break;
          }
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome message
          Padding(
            padding: const EdgeInsets.all(20),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                  'Welcome to my portfolio terminal! Type "help" for available commands.',
                  speed: const Duration(milliseconds: 50),
                ),
              ],
              totalRepeatCount: 1,
              isRepeatingAnimation: false,
            ),
          ).animate().fadeIn(duration: 300.ms),

          Divider(color: Colors.white.withOpacity(0.1), height: 1),

          // Command history
          Expanded(
            child: BlocBuilder<MainTabBloc, MainTabState>(
              builder: (context, state) {
                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(20),
                  itemCount: state.commandHistory.length + 1,
                  itemBuilder: (context, index) {
                    if (index == state.commandHistory.length) {
                      return const SizedBox(height: 20);
                    }

                    final line = state.commandHistory[index];
                    final isCommand = line.startsWith('\$');
                    final isError = line.contains('Error');
                    final isSuccess = line.startsWith('>') && !isError;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            line,
                            textStyle: TextStyle(
                              fontSize: 14,
                              color: isError
                                  ? AppTheme.softPink
                                  : isCommand
                                  ? AppTheme.electricCyan
                                  : isSuccess
                                  ? AppTheme.primaryPurple
                                  : Colors.white70,
                              height: 1.5,
                            ),
                            speed: Duration(milliseconds: 10),
                          ),
                        ],
                        totalRepeatCount: 1,
                        isRepeatingAnimation: false,
                      ),
                    ).animate();
                  },
                );
              },
            ),
          ),

          // Input area
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.white.withOpacity(0.1)),
              ),
            ),
            child: Row(
              children: [
                Text(
                  '\$ ',
                  style: TextStyle(
                    color: AppTheme.primaryPurple,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: TextField(
                    cursorWidth: 8,
                    controller: _controller,
                    focusNode: _focusNode,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter command...',
                      hintStyle: TextStyle(color: Colors.white30),
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onSubmitted: (_) => _submitCommand(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
