part of trober_api.api;

// Carrier
class Carrier {
  String id;

  DateTime createdAt;

  DateTime updatedAt;

  String createdBy;

  String tenantId;

  String name;

  DateTime eta;

  CarrierType type;
  Carrier();

  @override
  String toString() {
    return 'Carrier[id=$id, createdAt=$createdAt, updatedAt=$updatedAt, createdBy=$createdBy, tenantId=$tenantId, name=$name, eta=$eta, type=$type, ]';
  }

  fromJson(Map<String, dynamic> json) {
    if (json == null) return;

    {
      final _jsonData = json[r'id'];
      id = (_jsonData == null) ? null : _jsonData;
    } // _jsonFieldName
    {
      final _jsonData = json[r'created_at'];
      createdAt = (_jsonData == null) ? null : DateTime.parse(_jsonData);
    } // _jsonFieldName
    {
      final _jsonData = json[r'updated_at'];
      updatedAt = (_jsonData == null) ? null : DateTime.parse(_jsonData);
    } // _jsonFieldName
    {
      final _jsonData = json[r'created_by'];
      createdBy = (_jsonData == null) ? null : _jsonData;
    } // _jsonFieldName
    {
      final _jsonData = json[r'tenant_id'];
      tenantId = (_jsonData == null) ? null : _jsonData;
    } // _jsonFieldName
    {
      final _jsonData = json[r'name'];
      name = (_jsonData == null) ? null : _jsonData;
    } // _jsonFieldName
    {
      final _jsonData = json[r'eta'];
      eta = (_jsonData == null) ? null : DateTime.parse(_jsonData);
    } // _jsonFieldName
    {
      final _jsonData = json[r'type'];
      type = (_jsonData == null)
          ? null
          : CarrierTypeTypeTransformer.fromJson(_jsonData);
    } // _jsonFieldName
  }

  Carrier.fromJson(Map<String, dynamic> json) {
    fromJson(json); // allows child classes to call
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (id != null) {
      json[r'id'] = LocalApiClient.serialize(id);
    }
    if (createdAt != null) {
      json[r'created_at'] = createdAt.toUtc().toIso8601String();
    }
    if (updatedAt != null) {
      json[r'updated_at'] = updatedAt.toUtc().toIso8601String();
    }
    if (createdBy != null) {
      json[r'created_by'] = LocalApiClient.serialize(createdBy);
    }
    if (tenantId != null) {
      json[r'tenant_id'] = LocalApiClient.serialize(tenantId);
    }
    if (name != null) {
      json[r'name'] = LocalApiClient.serialize(name);
    }
    if (eta != null) {
      json[r'eta'] = eta.toUtc().toIso8601String();
    }
    if (type != null) {
      json[r'type'] = LocalApiClient.serialize(type);
    }
    return json;
  }

  static List<Carrier> listFromJson(List<dynamic> json) {
    return json == null
        ? <Carrier>[]
        : json.map((value) => Carrier.fromJson(value)).toList();
  }

  static Map<String, Carrier> mapFromJson(Map<String, dynamic> json) {
    final map = <String, Carrier>{};
    if (json != null && json.isNotEmpty) {
      json.forEach(
          (String key, dynamic value) => map[key] = Carrier.fromJson(value));
    }
    return map;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is Carrier && runtimeType == other.runtimeType) {
      return id == other.id &&
          createdAt == other.createdAt && // other

          updatedAt == other.updatedAt && // other

          createdBy == other.createdBy &&
          tenantId == other.tenantId &&
          name == other.name &&
          eta == other.eta && // other

          type == other.type;
    }

    return false;
  }

  @override
  int get hashCode {
    var hashCode = runtimeType.hashCode;

    if (id != null) {
      hashCode = hashCode ^ id.hashCode;
    }

    if (createdAt != null) {
      hashCode = hashCode ^ createdAt.hashCode;
    }

    if (updatedAt != null) {
      hashCode = hashCode ^ updatedAt.hashCode;
    }

    if (createdBy != null) {
      hashCode = hashCode ^ createdBy.hashCode;
    }

    if (tenantId != null) {
      hashCode = hashCode ^ tenantId.hashCode;
    }

    if (name != null) {
      hashCode = hashCode ^ name.hashCode;
    }

    if (eta != null) {
      hashCode = hashCode ^ eta.hashCode;
    }

    if (type != null) {
      hashCode = hashCode ^ type.hashCode;
    }

    return hashCode;
  }

  Carrier copyWith({
    String id,
    DateTime createdAt,
    DateTime updatedAt,
    String createdBy,
    String tenantId,
    String name,
    DateTime eta,
    CarrierType type,
  }) {
    Carrier copy = Carrier();
    copy.id = id ?? this.id;
    copy.createdAt = createdAt ?? this.createdAt;
    copy.updatedAt = updatedAt ?? this.updatedAt;
    copy.createdBy = createdBy ?? this.createdBy;
    copy.tenantId = tenantId ?? this.tenantId;
    copy.name = name ?? this.name;
    copy.eta = eta ?? this.eta;
    copy.type = type ?? this.type;
    return copy;
  }
}
