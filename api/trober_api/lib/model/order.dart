part of trober_api.api;

// Order
class Order {
  String id;

  DateTime createdAt;

  DateTime updatedAt;

  String createdBy;

  String tenantId;

  String customerId;

  String serialNumber;

  OrderStatus status;
  Order();

  @override
  String toString() {
    return 'Order[id=$id, createdAt=$createdAt, updatedAt=$updatedAt, createdBy=$createdBy, tenantId=$tenantId, customerId=$customerId, serialNumber=$serialNumber, status=$status, ]';
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
      final _jsonData = json[r'customer_id'];
      customerId = (_jsonData == null) ? null : _jsonData;
    } // _jsonFieldName
    {
      final _jsonData = json[r'serial_number'];
      serialNumber = (_jsonData == null) ? null : _jsonData;
    } // _jsonFieldName
    {
      final _jsonData = json[r'status'];
      status = (_jsonData == null)
          ? null
          : OrderStatusTypeTransformer.fromJson(_jsonData);
    } // _jsonFieldName
  }

  Order.fromJson(Map<String, dynamic> json) {
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
    if (customerId != null) {
      json[r'customer_id'] = LocalApiClient.serialize(customerId);
    }
    if (serialNumber != null) {
      json[r'serial_number'] = LocalApiClient.serialize(serialNumber);
    }
    if (status != null) {
      json[r'status'] = LocalApiClient.serialize(status);
    }
    return json;
  }

  static List<Order> listFromJson(List<dynamic> json) {
    return json == null
        ? <Order>[]
        : json.map((value) => Order.fromJson(value)).toList();
  }

  static Map<String, Order> mapFromJson(Map<String, dynamic> json) {
    final map = <String, Order>{};
    if (json != null && json.isNotEmpty) {
      json.forEach(
          (String key, dynamic value) => map[key] = Order.fromJson(value));
    }
    return map;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is Order && runtimeType == other.runtimeType) {
      return id == other.id &&
          createdAt == other.createdAt && // other

          updatedAt == other.updatedAt && // other

          createdBy == other.createdBy &&
          tenantId == other.tenantId &&
          customerId == other.customerId &&
          serialNumber == other.serialNumber &&
          status == other.status;
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

    if (customerId != null) {
      hashCode = hashCode ^ customerId.hashCode;
    }

    if (serialNumber != null) {
      hashCode = hashCode ^ serialNumber.hashCode;
    }

    if (status != null) {
      hashCode = hashCode ^ status.hashCode;
    }

    return hashCode;
  }

  Order copyWith({
    String id,
    DateTime createdAt,
    DateTime updatedAt,
    String createdBy,
    String tenantId,
    String customerId,
    String serialNumber,
    OrderStatus status,
  }) {
    Order copy = Order();
    copy.id = id ?? this.id;
    copy.createdAt = createdAt ?? this.createdAt;
    copy.updatedAt = updatedAt ?? this.updatedAt;
    copy.createdBy = createdBy ?? this.createdBy;
    copy.tenantId = tenantId ?? this.tenantId;
    copy.customerId = customerId ?? this.customerId;
    copy.serialNumber = serialNumber ?? this.serialNumber;
    copy.status = status ?? this.status;
    return copy;
  }
}
