import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shipanther/data/terminal/terminal_repository.dart';
import 'package:trober_sdk/api.dart';

part 'terminal_event.dart';
part 'terminal_state.dart';

class TerminalBloc extends Bloc<TerminalEvent, TerminalState> {
  TerminalBloc(this._terminalRepository) : super(TerminalInitial());
  final TerminalRepository _terminalRepository;

  @override
  Stream<TerminalState> mapEventToState(
    TerminalEvent event,
  ) async* {
    yield TerminalLoading();
    try {
      if (event is GetTerminal) {
        yield TerminalLoaded(await _terminalRepository.fetchTerminal(event.id));
      }
      if (event is GetTerminals) {
        final terminals = await _terminalRepository.fetchTerminals(
            terminalType: event.terminalType);
        yield TerminalsLoaded(terminals, event.terminalType);
      }
      if (event is UpdateTerminal) {
        await _terminalRepository.updateTerminal(event.id, event.terminal);
        final terminals = await _terminalRepository.fetchTerminals();
        yield TerminalsLoaded(terminals, null);
      }
      if (event is CreateTerminal) {
        await _terminalRepository.createTerminal(event.terminal);
        final terminals = await _terminalRepository.fetchTerminals();
        yield TerminalsLoaded(terminals, null);
      }
      if (event is DeleteTerminal) {
        yield const TerminalFailure('Terminal deletion is not supported');
      }
    } catch (e) {
      yield TerminalFailure('Request failed: $e');
    }
  }
}
