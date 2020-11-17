part of 'terminal_bloc.dart';

@immutable
abstract class TerminalState {
  const TerminalState();
}

class TerminalInitial extends TerminalState {}

class TerminalLoading extends TerminalState {}

class TerminalLoaded extends TerminalState {
  final Terminal terminal;
  const TerminalLoaded(this.terminal);
}

class TerminalsLoaded extends TerminalState {
  final List<Terminal> terminals;
  final TerminalType terminalType;
  const TerminalsLoaded(this.terminals, this.terminalType);
}

class TerminalFailure extends TerminalState {
  final String message;
  const TerminalFailure(this.message);
}
