part of trober_api.api;

// Container
class Container {
  String id;

  DateTime createdAt;

  DateTime updatedAt;

  String createdBy;

  String tenantId;

  String carrierId;

  String terminalId;

  String yardId;

  String orderId;

  String serialNumber;

  String origin;

  String destination;

  DateTime lfd;

  DateTime reservationTime;

  ContainerSize size;

  ContainerType type;

  ContainerStatus status;

  String driverId;

  String gpsUrl;
  Container();

  @override
  String toString() {
    return 'Container[id=$id, createdAt=$createdAt, updatedAt=$updatedAt, createdBy=$createdBy, tenantId=$tenantId, carrierId=$carrierId, terminalId=$terminalId, yardId=$yardId, orderId=$orderId, serialNumber=$serialNumber, origin=$origin, destination=$destination, lfd=$lfd, reservationTime=$reservationTime, size=$size, type=$type, status=$status, driverId=$driverId, gpsUrl=$gpsUrl, ]';
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
      final _jsonData = json[r'carrier_id'];
      carrierId = (_jsonData == null) ? null : _jsonData;
    } // _jsonFieldName
    {
      final _jsonData = json[r'terminal_id'];
      terminalId = (_jsonData == null) ? null : _jsonData;
    } // _jsonFieldName
    {
      final _jsonData = json[r'yard_id'];
      yardId = (_jsonData == null) ? null : _jsonData;
    } // _jsonFieldName
    {
      final _jsonData = json[r'order_id'];
      orderId = (_jsonData == null) ? null : _jsonData;
    } // _jsonFieldName
    {
      final _jsonData = json[r'serial_number'];
      serialNumber = (_jsonData == null) ? null : _jsonData;
    } // _jsonFieldName
    {
      final _jsonData = json[r'origin'];
      origin = (_jsonData == null) ? null : _jsonData;
    } // _jsonFieldName
    {
      final _jsonData = json[r'destination'];
      destination = (_jsonData == null) ? null : _jsonData;
    } // _jsonFieldName
    {
      final _jsonData = json[r'lfd'];
      lfd = (_jsonData == null) ? null : DateTime.parse(_jsonData);
    } // _jsonFieldName
    {
      final _jsonData = json[r'reservation_time'];
      reservationTime = (_jsonData == null) ? null : DateTime.parse(_jsonData);
    } // _jsonFieldName
    {
      final _jsonData = json[r'size'];
      size = (_jsonData == null)
          ? null
          : ContainerSizeTypeTransformer.fromJson(_jsonData);
    } // _jsonFieldName
    {
      final _jsonData = json[r'type'];
      type = (_jsonData == null)
          ? null
          : ContainerTypeTypeTransformer.fromJson(_jsonData);
    } // _jsonFieldName
    {
      final _jsonData = json[r'status'];
      status = (_jsonData == null)
          ? null
          : ContainerStatusTypeTransformer.fromJson(_jsonData);
    } // _jsonFieldName
    {
      final _jsonData = json[r'driver_id'];
      driverId = (_jsonData == null) ? null : _jsonData;
    } // _jsonFieldName
    {
      final _jsonData = json[r'gps_url'];
      gpsUrl = (_jsonData == null) ? null : _jsonData;
    } // _jsonFieldName
  }

  Container.fromJson(Map<String, dynamic> json) {
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
    if (carrierId != null) {
      json[r'carrier_id'] = LocalApiClient.serialize(carrierId);
    }
    if (terminalId != null) {
      json[r'terminal_id'] = LocalApiClient.serialize(terminalId);
    }
    if (yardId != null) {
      json[r'yard_id'] = LocalApiClient.serialize(yardId);
    }
    if (orderId != null) {
      json[r'order_id'] = LocalApiClient.serialize(orderId);
    }
    if (serialNumber != null) {
      json[r'serial_number'] = LocalApiClient.serialize(serialNumber);
    }
    if (origin != null) {
      json[r'origin'] = LocalApiClient.serialize(origin);
    }
    if (destination != null) {
      json[r'destination'] = LocalApiClient.serialize(destination);
    }
    if (lfd != null) {
      json[r'lfd'] = lfd.toUtc().toIso8601String();
    }
    if (reservationTime != null) {
      json[r'reservation_time'] = reservationTime.toUtc().toIso8601String();
    }
    if (size != null) {
      json[r'size'] = LocalApiClient.serialize(size);
    }
    if (type != null) {
      json[r'type'] = LocalApiClient.serialize(type);
    }
    if (status != null) {
      json[r'status'] = LocalApiClient.serialize(status);
    }
    if (driverId != null) {
      json[r'driver_id'] = LocalApiClient.serialize(driverId);
    }
    if (gpsUrl != null) {
      json[r'gps_url'] = LocalApiClient.serialize(gpsUrl);
    }
    return json;
  }

  static List<Container> listFromJson(List<dynamic> json) {
    return json == null
        ? <Container>[]
        : json.map((value) => Container.fromJson(value)).toList();
  }

  static Map<String, Container> mapFromJson(Map<String, dynamic> json) {
    final map = <String, Container>{};
    if (json != null && json.isNotEmpty) {
      json.forEach(
          (String key, dynamic value) => map[key] = Container.fromJson(value));
    }
    return map;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is Container && runtimeType == other.runtimeType) {
      return id == other.id &&
          createdAt == other.createdAt && // other

          updatedAt == other.updatedAt && // other

          createdBy == other.createdBy &&
          tenantId == other.tenantId &&
          carrierId == other.carrierId &&
          terminalId == other.terminalId &&
          yardId == other.yardId &&
          orderId == other.orderId &&
          serialNumber == other.serialNumber &&
          origin == other.origin &&
          destination == other.destination &&
          lfd == other.lfd && // other

          reservationTime == other.reservationTime && // other

          size == other.size && // other

          type == other.type && // other

          status == other.status && // other

          driverId == other.driverId &&
          gpsUrl == other.gpsUrl;
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

    if (carrierId != null) {
      hashCode = hashCode ^ carrierId.hashCode;
    }

    if (terminalId != null) {
      hashCode = hashCode ^ terminalId.hashCode;
    }

    if (yardId != null) {
      hashCode = hashCode ^ yardId.hashCode;
    }

    if (orderId != null) {
      hashCode = hashCode ^ orderId.hashCode;
    }

    if (serialNumber != null) {
      hashCode = hashCode ^ serialNumber.hashCode;
    }

    if (origin != null) {
      hashCode = hashCode ^ origin.hashCode;
    }

    if (destination != null) {
      hashCode = hashCode ^ destination.hashCode;
    }

    if (lfd != null) {
      hashCode = hashCode ^ lfd.hashCode;
    }

    if (reservationTime != null) {
      hashCode = hashCode ^ reservationTime.hashCode;
    }

    if (size != null) {
      hashCode = hashCode ^ size.hashCode;
    }

    if (type != null) {
      hashCode = hashCode ^ type.hashCode;
    }

    if (status != null) {
      hashCode = hashCode ^ status.hashCode;
    }

    if (driverId != null) {
      hashCode = hashCode ^ driverId.hashCode;
    }

    if (gpsUrl != null) {
      hashCode = hashCode ^ gpsUrl.hashCode;
    }

    return hashCode;
  }

  Container copyWith({
    String id,
    DateTime createdAt,
    DateTime updatedAt,
    String createdBy,
    String tenantId,
    String carrierId,
    String terminalId,
    String yardId,
    String orderId,
    String serialNumber,
    String origin,
    String destination,
    DateTime lfd,
    DateTime reservationTime,
    ContainerSize size,
    ContainerType type,
    ContainerStatus status,
    String driverId,
    String gpsUrl,
  }) {
    Container copy = Container();
    copy.id = id ?? this.id;
    copy.createdAt = createdAt ?? this.createdAt;
    copy.updatedAt = updatedAt ?? this.updatedAt;
    copy.createdBy = createdBy ?? this.createdBy;
    copy.tenantId = tenantId ?? this.tenantId;
    copy.carrierId = carrierId ?? this.carrierId;
    copy.terminalId = terminalId ?? this.terminalId;
    copy.yardId = yardId ?? this.yardId;
    copy.orderId = orderId ?? this.orderId;
    copy.serialNumber = serialNumber ?? this.serialNumber;
    copy.origin = origin ?? this.origin;
    copy.destination = destination ?? this.destination;
    copy.lfd = lfd ?? this.lfd;
    copy.reservationTime = reservationTime ?? this.reservationTime;
    copy.size = size ?? this.size;
    copy.type = type ?? this.type;
    copy.status = status ?? this.status;
    copy.driverId = driverId ?? this.driverId;
    copy.gpsUrl = gpsUrl ?? this.gpsUrl;
    return copy;
  }
}
