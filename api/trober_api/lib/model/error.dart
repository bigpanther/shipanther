part of trober_api.api;

// Error
class Error {
  int code;

  String message;

  String id;
  Error();

  @override
  String toString() {
    return 'Error[code=$code, message=$message, id=$id, ]';
  }

  fromJson(Map<String, dynamic> json) {
    if (json == null) return;

    {
      final _jsonData = json[r'code'];
      code = (_jsonData == null) ? null : _jsonData;
    } // _jsonFieldName
    {
      final _jsonData = json[r'message'];
      message = (_jsonData == null) ? null : _jsonData;
    } // _jsonFieldName
    {
      final _jsonData = json[r'id'];
      id = (_jsonData == null) ? null : _jsonData;
    } // _jsonFieldName
  }

  Error.fromJson(Map<String, dynamic> json) {
    fromJson(json); // allows child classes to call
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (code != null) {
      json[r'code'] = LocalApiClient.serialize(code);
    }
    if (message != null) {
      json[r'message'] = LocalApiClient.serialize(message);
    }
    if (id != null) {
      json[r'id'] = LocalApiClient.serialize(id);
    }
    return json;
  }

  static List<Error> listFromJson(List<dynamic> json) {
    return json == null
        ? <Error>[]
        : json.map((value) => Error.fromJson(value)).toList();
  }

  static Map<String, Error> mapFromJson(Map<String, dynamic> json) {
    final map = <String, Error>{};
    if (json != null && json.isNotEmpty) {
      json.forEach(
          (String key, dynamic value) => map[key] = Error.fromJson(value));
    }
    return map;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is Error && runtimeType == other.runtimeType) {
      return code == other.code && message == other.message && id == other.id;
    }

    return false;
  }

  @override
  int get hashCode {
    var hashCode = runtimeType.hashCode;

    if (code != null) {
      hashCode = hashCode ^ code.hashCode;
    }

    if (message != null) {
      hashCode = hashCode ^ message.hashCode;
    }

    if (id != null) {
      hashCode = hashCode ^ id.hashCode;
    }

    return hashCode;
  }

  Error copyWith({
    int code,
    String message,
    String id,
  }) {
    Error copy = Error();
    copy.code = code ?? this.code;
    copy.message = message ?? this.message;
    copy.id = id ?? this.id;
    return copy;
  }
}
