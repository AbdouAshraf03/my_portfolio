import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_const.dart';
import 'main_tab_event.dart';
import 'main_tab_state.dart';

class MainTabBloc extends Bloc<MainTabEvent, MainTabState> {
  MainTabBloc() : super(const MainTabState()) {
    on<CommandSubmitted>(_onCommandSubmitted);
    on<CommandCleared>(_onCommandCleared);
    on<InputChanged>(_onInputChanged);
  }

  void _onCommandSubmitted(
    CommandSubmitted event,
    Emitter<MainTabState> emit,
  ) async {
    final command = event.command.trim().toLowerCase();
    final newHistory = List<String>.from(state.commandHistory)
      ..add('\$ ${event.command}');

    emit(state.copyWith(isProcessing: true));

    // Simulate processing delay
    await Future.delayed(const Duration(milliseconds: 300));

    String response;
    String? navigationCommand;

    switch (command) {
      case 'about':
        response = '> Navigating to About Me...';
        navigationCommand = 'about';
        break;
      case 'projects':
        response = '> Loading projects...';
        navigationCommand = 'projects';
        break;
      case 'contact':
        response = '> Opening contact form...';
        navigationCommand = 'contact';
        break;
      case 'fact':
        response = '> This web site made with flutter :)';
      case 'help':
        response = AppConstants.helpMessage;
        break;
      case 'clear':
        emit(const MainTabState());
        return;
      case '':
        emit(
          state.copyWith(
            commandHistory: newHistory,
            currentInput: '',
            isProcessing: false,
          ),
        );
        return;
      default:
        response =
            '> Error: Command not found: "$command"\n> Type "help" for available commands.';
    }

    newHistory.add(response);

    emit(
      state.copyWith(
        commandHistory: newHistory,
        currentInput: '',
        isProcessing: false,
        navigationCommand: navigationCommand,
      ),
    );

    // Clear navigation command after emitting
    if (navigationCommand != null) {
      // await Future.delayed(const Duration(milliseconds: 100));
      emit(state.copyWith(navigationCommand: null));
    }
  }

  void _onCommandCleared(CommandCleared event, Emitter<MainTabState> emit) {
    emit(const MainTabState());
  }

  void _onInputChanged(InputChanged event, Emitter<MainTabState> emit) {
    emit(state.copyWith(currentInput: event.input));
  }
}
