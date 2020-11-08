part of trober_api.api;

enum CarrierType { air, rail, vessel, road }

class CarrierTypeTypeTransformer {
  static Map<String, CarrierType> fromJsonMap = {
    "Air": CarrierType.air,
    "Rail": CarrierType.rail,
    "Vessel": CarrierType.vessel,
    "Road": CarrierType.road
  };
  static Map<CarrierType, String> toJsonMap = {
    CarrierType.air: "Air",
    CarrierType.rail: "Rail",
    CarrierType.vessel: "Vessel",
    CarrierType.road: "Road"
  };

  static CarrierType fromJson(dynamic data) {
    var found = fromJsonMap[data];
    if (found == null) {
      throw ('Unknown enum value to decode: $data');
    }
    return found;
  }

  static dynamic toJson(CarrierType data) {
    return toJsonMap[data];
  }

  static List<CarrierType> listFromJson(List<dynamic> json) {
    return json == null
        ? <CarrierType>[]
        : json.map((value) => fromJson(value)).toList();
  }

  static CarrierType copyWith(CarrierType instance) {
    return instance;
  }

  static Map<String, CarrierType> mapFromJson(Map<String, dynamic> json) {
    final map = <String, CarrierType>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = fromJson(value));
    }
    return map;
  }
}
