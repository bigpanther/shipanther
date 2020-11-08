part of trober_api.api;

enum ContainerType { incoming, outGoing }

class ContainerTypeTypeTransformer {
  static Map<String, ContainerType> fromJsonMap = {
    "Incoming": ContainerType.incoming,
    "OutGoing": ContainerType.outGoing
  };
  static Map<ContainerType, String> toJsonMap = {
    ContainerType.incoming: "Incoming",
    ContainerType.outGoing: "OutGoing"
  };

  static ContainerType fromJson(dynamic data) {
    var found = fromJsonMap[data];
    if (found == null) {
      throw ('Unknown enum value to decode: $data');
    }
    return found;
  }

  static dynamic toJson(ContainerType data) {
    return toJsonMap[data];
  }

  static List<ContainerType> listFromJson(List<dynamic> json) {
    return json == null
        ? <ContainerType>[]
        : json.map((value) => fromJson(value)).toList();
  }

  static ContainerType copyWith(ContainerType instance) {
    return instance;
  }

  static Map<String, ContainerType> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ContainerType>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = fromJson(value));
    }
    return map;
  }
}
