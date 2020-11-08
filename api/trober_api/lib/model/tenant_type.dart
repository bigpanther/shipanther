part of trober_api.api;

enum TenantType { system, test, production }

class TenantTypeTypeTransformer {
  static Map<String, TenantType> fromJsonMap = {
    "System": TenantType.system,
    "Test": TenantType.test,
    "Production": TenantType.production
  };
  static Map<TenantType, String> toJsonMap = {
    TenantType.system: "System",
    TenantType.test: "Test",
    TenantType.production: "Production"
  };

  static TenantType fromJson(dynamic data) {
    var found = fromJsonMap[data];
    if (found == null) {
      throw ('Unknown enum value to decode: $data');
    }
    return found;
  }

  static dynamic toJson(TenantType data) {
    return toJsonMap[data];
  }

  static List<TenantType> listFromJson(List<dynamic> json) {
    return json == null
        ? <TenantType>[]
        : json.map((value) => fromJson(value)).toList();
  }

  static TenantType copyWith(TenantType instance) {
    return instance;
  }

  static Map<String, TenantType> mapFromJson(Map<String, dynamic> json) {
    final map = <String, TenantType>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = fromJson(value));
    }
    return map;
  }
}
