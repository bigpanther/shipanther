part of trober_api.api;

enum TerminalType { rail, port, custom }

class TerminalTypeTypeTransformer {
  static Map<String, TerminalType> fromJsonMap = {
    "Rail": TerminalType.rail,
    "Port": TerminalType.port,
    "Custom": TerminalType.custom
  };
  static Map<TerminalType, String> toJsonMap = {
    TerminalType.rail: "Rail",
    TerminalType.port: "Port",
    TerminalType.custom: "Custom"
  };

  static TerminalType fromJson(dynamic data) {
    var found = fromJsonMap[data];
    if (found == null) {
      throw ('Unknown enum value to decode: $data');
    }
    return found;
  }

  static dynamic toJson(TerminalType data) {
    return toJsonMap[data];
  }

  static List<TerminalType> listFromJson(List<dynamic> json) {
    return json == null
        ? <TerminalType>[]
        : json.map((value) => fromJson(value)).toList();
  }

  static TerminalType copyWith(TerminalType instance) {
    return instance;
  }

  static Map<String, TerminalType> mapFromJson(Map<String, dynamic> json) {
    final map = <String, TerminalType>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = fromJson(value));
    }
    return map;
  }
}
