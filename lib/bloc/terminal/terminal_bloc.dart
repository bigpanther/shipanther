import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shipanther/data/terminal/terminal_repository.dart';
import 'package:trober_sdk/trober_sdk.dart';

part 'terminal_event.dart';
part 'terminal_state.dart';

class TerminalBloc extends Bloc<TerminalEvent, TerminalState> {
  final TerminalRepository _terminalRepository;
  TerminalBloc(this._terminalRepository) : super(TerminalInitial()) {
    on<GetTerminal>((event, emit) async {
      emit(TerminalLoading());
      try {
        emit(TerminalLoaded(await _terminalRepository.fetchTerminal(event.id)));
      } catch (e) {
        emit(TerminalFailure('Request failed: $e'));
      }
    });
    on<GetTerminals>((event, emit) async {
      emit(TerminalLoading());
      try {
        final terminals = await _terminalRepository.fetchTerminals(
            terminalType: event.terminalType);
        emit(TerminalsLoaded(terminals, event.terminalType));
      } catch (e) {
        emit(TerminalFailure('Request failed: $e'));
      }
    });
    on<UpdateTerminal>((event, emit) async {
      emit(TerminalLoading());
      try {
        await _terminalRepository.updateTerminal(event.id, event.terminal);
        final terminals = await _terminalRepository.fetchTerminals();
        emit(TerminalsLoaded(terminals, null));
      } catch (e) {
        emit(TerminalFailure('Request failed: $e'));
      }
    });
    on<CreateTerminal>((event, emit) async {
      emit(TerminalLoading());
      try {
        await _terminalRepository.createTerminal(event.terminal);
        final terminals = await _terminalRepository.fetchTerminals();
        emit(TerminalsLoaded(terminals, null));
      } catch (e) {
        emit(TerminalFailure('Request failed: $e'));
      }
    });
    on<DeleteTerminal>((event, emit) async {
      emit(const TerminalFailure('Terminal deletion is not supported'));
    });
  }
}
