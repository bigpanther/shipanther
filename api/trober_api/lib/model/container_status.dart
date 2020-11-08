part of trober_api.api;

enum ContainerStatus {
  new_,
  inTransit,
  arrivedAtTerminal,
  assignedForTransport,
  readyForTransport,
  rejected,
  loaded,
  unloaded,
  abandoned
}

class ContainerStatusTypeTransformer {
  static Map<String, ContainerStatus> fromJsonMap = {
    "New": ContainerStatus.new_,
    "In Transit": ContainerStatus.inTransit,
    "Arrived at terminal": ContainerStatus.arrivedAtTerminal,
    "Assigned for transport": ContainerStatus.assignedForTransport,
    "Ready for transport": ContainerStatus.readyForTransport,
    "Rejected": ContainerStatus.rejected,
    "Loaded": ContainerStatus.loaded,
    "Unloaded": ContainerStatus.unloaded,
    "Abandoned": ContainerStatus.abandoned
  };
  static Map<ContainerStatus, String> toJsonMap = {
    ContainerStatus.new_: "New",
    ContainerStatus.inTransit: "In Transit",
    ContainerStatus.arrivedAtTerminal: "Arrived at terminal",
    ContainerStatus.assignedForTransport: "Assigned for transport",
    ContainerStatus.readyForTransport: "Ready for transport",
    ContainerStatus.rejected: "Rejected",
    ContainerStatus.loaded: "Loaded",
    ContainerStatus.unloaded: "Unloaded",
    ContainerStatus.abandoned: "Abandoned"
  };

  static ContainerStatus fromJson(dynamic data) {
    var found = fromJsonMap[data];
    if (found == null) {
      throw ('Unknown enum value to decode: $data');
    }
    return found;
  }

  static dynamic toJson(ContainerStatus data) {
    return toJsonMap[data];
  }

  static List<ContainerStatus> listFromJson(List<dynamic> json) {
    return json == null
        ? <ContainerStatus>[]
        : json.map((value) => fromJson(value)).toList();
  }

  static ContainerStatus copyWith(ContainerStatus instance) {
    return instance;
  }

  static Map<String, ContainerStatus> mapFromJson(Map<String, dynamic> json) {
    final map = <String, ContainerStatus>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = fromJson(value));
    }
    return map;
  }
}
