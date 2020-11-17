import 'package:trober_sdk/api.dart';

abstract class TerminalRepository {
  const TerminalRepository();
  Future<Terminal> fetchTerminal(String id);
  Future<Terminal> createTerminal(Terminal terminal);
  Future<Terminal> updateTerminal(String id, Terminal terminal);
  Future<List<Terminal>> fetchTerminals();
  Future<List<Terminal>> filterTerminals(TerminalType terminalType);
}
