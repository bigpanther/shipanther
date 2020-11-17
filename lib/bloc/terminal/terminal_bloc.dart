import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shipanther/data/terminal/terminal_repository.dart';
import 'package:trober_sdk/api.dart';

part 'terminal_event.dart';
part 'terminal_state.dart';

class TerminalBloc extends Bloc<TerminalEvent, TerminalState> {
  final TerminalRepository _terminalRepository;

  TerminalBloc(this._terminalRepository) : super(TerminalInitial());

  @override
  Stream<TerminalState> mapEventToState(
    TerminalEvent event,
  ) async* {
    yield TerminalLoading();
    if (event is GetTerminal) {
      yield TerminalLoaded(await _terminalRepository.fetchTerminal(event.id));
    }
    if (event is GetTerminals) {
      var terminals =
          await _terminalRepository.filterTerminals(event.terminalType);
      yield TerminalsLoaded(terminals, event.terminalType);
    }
    if (event is UpdateTerminal) {
      await _terminalRepository.updateTerminal(event.id, event.terminal);
      var terminals = await _terminalRepository.filterTerminals(null);
      yield TerminalsLoaded(terminals, null);
    }
    if (event is CreateTerminal) {
      await _terminalRepository.createTerminal(event.terminal);
      var terminals = await _terminalRepository.filterTerminals(null);
      yield TerminalsLoaded(terminals, null);
    }
    if (event is DeleteTerminal) {
      yield TerminalFailure("Terminal deletion is not supported");
    }
  }
}
