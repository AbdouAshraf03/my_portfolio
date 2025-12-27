import 'package:equatable/equatable.dart';

abstract class MainTabEvent extends Equatable {
  const MainTabEvent();

  @override
  List<Object?> get props => [];
}

class CommandSubmitted extends MainTabEvent {
  final String command;

  const CommandSubmitted(this.command);

  @override
  List<Object?> get props => [command];
}

class CommandCleared extends MainTabEvent {
  const CommandCleared();
}

class InputChanged extends MainTabEvent {
  final String input;

  const InputChanged(this.input);

  @override
  List<Object?> get props => [input];
}
