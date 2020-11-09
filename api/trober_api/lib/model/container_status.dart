part of trober_api.api;

enum ContainerStatus {
  unassigned,
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
    "Unassigned": ContainerStatus.unassigned,
    "InTransit": ContainerStatus.inTransit,
    "ArrivedAtTerminal": ContainerStatus.arrivedAtTerminal,
    "AssignedForTransport": ContainerStatus.assignedForTransport,
    "ReadyForTransport": ContainerStatus.readyForTransport,
    "Rejected": ContainerStatus.rejected,
    "Loaded": ContainerStatus.loaded,
    "Unloaded": ContainerStatus.unloaded,
    "Abandoned": ContainerStatus.abandoned
  };
  static Map<ContainerStatus, String> toJsonMap = {
    ContainerStatus.unassigned: "Unassigned",
    ContainerStatus.inTransit: "InTransit",
    ContainerStatus.arrivedAtTerminal: "ArrivedAtTerminal",
    ContainerStatus.assignedForTransport: "AssignedForTransport",
    ContainerStatus.readyForTransport: "ReadyForTransport",
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
