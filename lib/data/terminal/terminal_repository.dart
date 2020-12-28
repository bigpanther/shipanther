import 'package:trober_sdk/api.dart';

abstract class TerminalRepository {
  const TerminalRepository();
  Future<Terminal> fetchTerminal(String id);
  Future<Terminal> createTerminal(Terminal terminal);
  Future<Terminal> updateTerminal(String id, Terminal terminal);
  Future<List<Terminal>> fetchTerminals(
      {int? page = 1, TerminalType? terminalType, String? name});
}
