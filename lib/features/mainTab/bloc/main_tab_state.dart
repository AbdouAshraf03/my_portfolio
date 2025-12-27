import 'package:equatable/equatable.dart';

class MainTabState extends Equatable {
  final List<String> commandHistory;
  final String currentInput;
  final bool isProcessing;
  final String? navigationCommand;

  const MainTabState({
    this.commandHistory = const [],
    this.currentInput = '',
    this.isProcessing = false,
    this.navigationCommand,
  });

  MainTabState copyWith({
    List<String>? commandHistory,
    String? currentInput,
    bool? isProcessing,
    String? navigationCommand,
  }) {
    return MainTabState(
      commandHistory: commandHistory ?? this.commandHistory,
      currentInput: currentInput ?? this.currentInput,
      isProcessing: isProcessing ?? this.isProcessing,
      navigationCommand: navigationCommand,
    );
  }

  @override
  List<Object?> get props => [
    commandHistory,
    currentInput,
    isProcessing,
    navigationCommand,
  ];
}
