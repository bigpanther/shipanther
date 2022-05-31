import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:shipanther/data/terminal/terminal_repository.dart';
import 'package:trober_sdk/trober_sdk.dart';

class RemoteTerminalRepository extends TerminalRepository {
  const RemoteTerminalRepository(this._authRepository);
  final AuthRepository _authRepository;

  @override
  Future<Terminal> fetchTerminal(String id) async {
    final client = await _authRepository.apiClient();
    return (await client.terminalsIdGet(id: id)).data!;
  }

  @override
  Future<List<Terminal>> fetchTerminals(
      {int? page = 1, TerminalType? terminalType, String? name}) async {
    final client = await _authRepository.apiClient();
    return (await client.terminalsGet(
            page: page, type: terminalType, name: name))
        .data!
        .toList();
  }

  @override
  Future<Terminal> createTerminal(Terminal terminal) async {
    final client = await _authRepository.apiClient();
    return (await client.terminalsPost(terminal: terminal)).data!;
  }

  @override
  Future<Terminal> updateTerminal(String id, Terminal terminal) async {
    final client = await _authRepository.apiClient();
    return (await client.terminalsIdPut(id: id, terminal: terminal)).data!;
  }
}
