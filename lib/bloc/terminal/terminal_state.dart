part of 'terminal_bloc.dart';

@immutable
abstract class TerminalState {
  const TerminalState();
}

class TerminalInitial extends TerminalState {}

class TerminalLoading extends TerminalState {}

class TerminalLoaded extends TerminalState {
  const TerminalLoaded(this.terminal);
  final api.Terminal terminal;
}

class TerminalsLoaded extends TerminalState {
  const TerminalsLoaded(this.terminals, this.terminalType);
  final List<api.Terminal> terminals;
  final api.TerminalType? terminalType;
}

class TerminalFailure extends TerminalState {
  const TerminalFailure(this.message);
  final String message;
}
