import 'package:shipanther/data/api/api_repository.dart';
import 'package:shipanther/data/terminal/terminal_repository.dart';
import 'package:trober_sdk/api.dart';

class RemoteTerminalRepository extends TerminalRepository {
  final ApiRepository _apiRepository;

  const RemoteTerminalRepository(this._apiRepository);
  @override
  Future<Terminal> fetchTerminal(String id) async {
    var client = await _apiRepository.apiClient();
    return await client.terminalsIdGet(id);
  }

  @override
  Future<List<Terminal>> fetchTerminals() async {
    var client = await _apiRepository.apiClient();
    return await client.terminalsGet();
  }

  @override
  Future<Terminal> createTerminal(Terminal terminal) async {
    var client = await _apiRepository.apiClient();
    return await client.terminalsPost(terminal: terminal);
  }

  @override
  Future<Terminal> updateTerminal(String id, Terminal terminal) async {
    var client = await _apiRepository.apiClient();
    return await client.terminalsIdPatch(id, terminal: terminal);
  }

  @override
  Future<List<Terminal>> filterTerminals(TerminalType terminalType) async {
    var terminals = await fetchTerminals();
    if (terminalType == null) {
      return terminals;
    }
    return terminals.where((e) => e.type == terminalType).toList();
  }
}
