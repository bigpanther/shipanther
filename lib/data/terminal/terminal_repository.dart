import 'package:trober_sdk/trober_sdk.dart';

abstract class TerminalRepository {
  const TerminalRepository();
  Future<Terminal?> fetchTerminal(String id);
  Future<Terminal?> createTerminal(Terminal terminal);
  Future<Terminal?> updateTerminal(String id, Terminal terminal);
  Future<Iterable<Terminal>> fetchTerminals(
      {int? page = 1, TerminalType? terminalType, String? name});
}
