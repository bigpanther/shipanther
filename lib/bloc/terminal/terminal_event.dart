part of 'terminal_bloc.dart';

@immutable
abstract class TerminalEvent {
  const TerminalEvent();
}

class GetTerminal extends TerminalEvent {
  const GetTerminal(this.id);
  final String id;
}

class UpdateTerminal extends TerminalEvent {
  const UpdateTerminal(this.id, this.terminal);
  final String id;
  final api.Terminal terminal;
}

class CreateTerminal extends TerminalEvent {
  const CreateTerminal(this.terminal);
  final api.Terminal terminal;
}

class DeleteTerminal extends TerminalEvent {
  const DeleteTerminal(this.id);
  final String id;
}

class GetTerminals extends TerminalEvent {
  const GetTerminals({this.terminalType});
  final api.TerminalType? terminalType;
}
