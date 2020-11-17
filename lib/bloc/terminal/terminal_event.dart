part of 'terminal_bloc.dart';

@immutable
abstract class TerminalEvent {
  const TerminalEvent();
}

class GetTerminal extends TerminalEvent {
  final String id;
  const GetTerminal(this.id);
}

class UpdateTerminal extends TerminalEvent {
  final String id;
  final Terminal terminal;
  const UpdateTerminal(this.id, this.terminal);
}

class CreateTerminal extends TerminalEvent {
  final Terminal terminal;
  const CreateTerminal(this.terminal);
}

class DeleteTerminal extends TerminalEvent {
  final String id;
  const DeleteTerminal(this.id);
}

class GetTerminals extends TerminalEvent {
  final TerminalType terminalType;
  const GetTerminals(this.terminalType);
}
