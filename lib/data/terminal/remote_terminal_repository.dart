import 'package:shipanther/data/api/api_repository.dart';
import 'package:shipanther/data/terminal/terminal_repository.dart';
import 'package:trober_sdk/api.dart';

class RemoteTerminalRepository extends TerminalRepository {
  const RemoteTerminalRepository(this._apiRepository);
  final ApiRepository _apiRepository;

  @override
  Future<Terminal> fetchTerminal(String id) async {
    final client = await _apiRepository.apiClient();
    return await client.terminalsIdGet(id);
  }

  @override
  Future<List<Terminal>> fetchTerminals(
      {int? page = 1, TerminalType? terminalType, String? name}) async {
    final client = await _apiRepository.apiClient();
    return await client.terminalsGet(
        page: page, type: terminalType, name: name);
  }

  @override
  Future<Terminal> createTerminal(Terminal terminal) async {
    final client = await _apiRepository.apiClient();
    return await client.terminalsPost(terminal: terminal);
  }

  @override
  Future<Terminal> updateTerminal(String id, Terminal terminal) async {
    final client = await _apiRepository.apiClient();
    return await client.terminalsIdPut(id, terminal: terminal);
  }

  @override
  Future<List<Terminal>> filterTerminals(TerminalType terminalType) async {
    final terminals = await fetchTerminals();
    if (terminalType == null) {
      return terminals;
    }
    return terminals.where((e) => e.type == terminalType).toList();
  }
}
