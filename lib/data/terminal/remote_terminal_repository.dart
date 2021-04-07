import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:shipanther/data/terminal/terminal_repository.dart';
import 'package:trober_sdk/trober_sdk.dart';

class RemoteTerminalRepository extends TerminalRepository {
  const RemoteTerminalRepository(this._authRepository);
  final AuthRepository _authRepository;

  @override
  Future<Terminal?> fetchTerminal(String id) async {
    final client = await _authRepository.apiClient();
    final resp = await client.terminalsIdGet(id: id);
    return resp.data;
  }

  @override
  Future<Iterable<Terminal>> fetchTerminals(
      {int? page = 1, TerminalType? terminalType, String? name}) async {
    final client = await _authRepository.apiClient();
    final resp =
        await client.terminalsGet(page: page, type: terminalType, name: name);
    return resp.data ?? [];
  }

  @override
  Future<Terminal?> createTerminal(Terminal terminal) async {
    final client = await _authRepository.apiClient();
    final resp = await client.terminalsPost(terminal: terminal);
    return resp.data;
  }

  @override
  Future<Terminal?> updateTerminal(String id, Terminal terminal) async {
    final client = await _authRepository.apiClient();
    final resp = await client.terminalsIdPut(id: id, terminal: terminal);
    return resp.data;
  }
}
