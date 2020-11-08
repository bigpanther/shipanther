part of trober_api.api;

enum ContainerSize { n40sT, n20sT, n40hC, n40hW, custom }

class ContainerSizeTypeTransformer {
  static Map<String, ContainerSize> fromJsonMap = {
    "40ST": ContainerSize.n40sT,
    "20ST": ContainerSize.n20sT,
    "40HC": ContainerSize.n40hC,
    "40HW": ContainerSize.n40hW,
    "Custom": ContainerSize.custom
  };
  static Map<ContainerSize, String> toJsonMap = {
    ContainerSize.n40sT: "40ST",
    ContainerSize.n20sT: "20ST",
    ContainerSize.n40hC: "40HC",
    ContainerSize.n40hW: "40HW",
    ContainerSize.custom: "Custom"
  };

  static ContainerSize fromJson(dynamic data) {
    var found = fromJsonMap[data];
    if (found == null) {
      throw ('Unknown enum value to decode: $data');
    }
    return found;
  }

  static dynamic toJson(ContainerSize data) {
    return toJsonMap[data];
  }

  static List<ContainerSize> listFromJson(List<dynamic> json) {
    return json == null
        ? <ContainerSize>[]
        : json.map((value) => fromJson(value)).toList();
  }

  static ContainerSize copyWith(ContainerSize instance) {
    return instance;
  }

  static Map<String, ContainerSize> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ContainerSize>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = fromJson(value));
    }
    return map;
  }
}
