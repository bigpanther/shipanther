part of trober_api.api;

class LocalApiClient {
  static final _regList = RegExp(r'^List<(.*)>$');
  static final _regMap = RegExp(r'^Map<String,(.*)>$');

  static dynamic serialize(Object value) {
    try {
      if (value == null) {
        return null;
      } else if (value is List) {
        return value.map((v) => serialize(v)).toList();
      } else if (value is Map) {
        return Map.fromIterables(
            value.keys, value.values.map((v) => serialize(v)));
      } else if (value is String) {
        return value;
      } else if (value is bool) {
        return value;
      } else if (value is num) {
        return value;
      } else if (value is DateTime) {
        return value.toUtc().toIso8601String();
      }
      if (value is Carrier) {
        return value.toJson();
      }
      if (value is CarrierType) {
        return CarrierTypeTypeTransformer.toJson(value);
      }
      if (value is Container) {
        return value.toJson();
      }
      if (value is ContainerSize) {
        return ContainerSizeTypeTransformer.toJson(value);
      }
      if (value is ContainerStatus) {
        return ContainerStatusTypeTransformer.toJson(value);
      }
      if (value is ContainerType) {
        return ContainerTypeTypeTransformer.toJson(value);
      }
      if (value is Customer) {
        return value.toJson();
      }
      if (value is Error) {
        return value.toJson();
      }
      if (value is Order) {
        return value.toJson();
      }
      if (value is OrderStatus) {
        return OrderStatusTypeTransformer.toJson(value);
      }
      if (value is Tenant) {
        return value.toJson();
      }
      if (value is TenantType) {
        return TenantTypeTypeTransformer.toJson(value);
      }
      if (value is Terminal) {
        return value.toJson();
      }
      if (value is TerminalType) {
        return TerminalTypeTypeTransformer.toJson(value);
      }
      if (value is User) {
        return value.toJson();
      }
      if (value is UserRole) {
        return UserRoleTypeTransformer.toJson(value);
      }
      if (value is Yard) {
        return value.toJson();
      }
      return value.toString();
    } on Exception catch (e, stack) {
      throw ApiException.withInner(
          500, 'Exception during deserialization.', e, stack);
    }
  }

  static dynamic deserializeFromString(String json, String targetType) {
    if (json == null) {
      // HTTP Code 204
      return null;
    }

    // Remove all spaces.  Necessary for reg expressions as well.
    targetType = targetType.replaceAll(' ', '');

    if (targetType == 'String') return json;

    var decodedJson = jsonDecode(json);
    return deserialize(decodedJson, targetType);
  }

  static dynamic deserialize(dynamic value, String targetType) {
    if (value == null) return null; // 204
    try {
      switch (targetType) {
        case 'String':
          return '$value';
        case 'int':
          return value is int ? value : int.parse('$value');
        case 'bool':
          return value is bool ? value : '$value'.toLowerCase() == 'true';
        case 'double':
          return value is double ? value : double.parse('$value');
        case 'Carrier':
          return Carrier.fromJson(value);
        case 'CarrierType':
          return CarrierTypeTypeTransformer.fromJson(value);
        case 'Container':
          return Container.fromJson(value);
        case 'ContainerSize':
          return ContainerSizeTypeTransformer.fromJson(value);
        case 'ContainerStatus':
          return ContainerStatusTypeTransformer.fromJson(value);
        case 'ContainerType':
          return ContainerTypeTypeTransformer.fromJson(value);
        case 'Customer':
          return Customer.fromJson(value);
        case 'Error':
          return Error.fromJson(value);
        case 'Order':
          return Order.fromJson(value);
        case 'OrderStatus':
          return OrderStatusTypeTransformer.fromJson(value);
        case 'Tenant':
          return Tenant.fromJson(value);
        case 'TenantType':
          return TenantTypeTypeTransformer.fromJson(value);
        case 'Terminal':
          return Terminal.fromJson(value);
        case 'TerminalType':
          return TerminalTypeTypeTransformer.fromJson(value);
        case 'User':
          return User.fromJson(value);
        case 'UserRole':
          return UserRoleTypeTransformer.fromJson(value);
        case 'Yard':
          return Yard.fromJson(value);
        default:
          {
            Match match;
            if (value is List &&
                (match = _regList.firstMatch(targetType)) != null) {
              var newTargetType = match[1];
              return value.map((v) => deserialize(v, newTargetType)).toList();
            } else if (value is Map &&
                (match = _regMap.firstMatch(targetType)) != null) {
              var newTargetType = match[1];
              return Map.fromIterables(value.keys,
                  value.values.map((v) => deserialize(v, newTargetType)));
            }
          }
      }
    } on Exception catch (e, stack) {
      throw ApiException.withInner(
          500, 'Exception during deserialization.', e, stack);
    }
    throw ApiException(
        500, 'Could not find a suitable class for deserialization');
  }

  /// Format the given parameter object into string.
  static String parameterToString(dynamic value) {
    if (value == null) {
      return '';
    } else if (value is DateTime) {
      return value.toUtc().toIso8601String();
    } else if (value is String) {
      return value.toString();
    }

    if (value is CarrierType) {
      return CarrierTypeTypeTransformer.toJson(value).toString();
    }
    if (value is ContainerSize) {
      return ContainerSizeTypeTransformer.toJson(value).toString();
    }
    if (value is ContainerStatus) {
      return ContainerStatusTypeTransformer.toJson(value).toString();
    }
    if (value is ContainerType) {
      return ContainerTypeTypeTransformer.toJson(value).toString();
    }
    if (value is OrderStatus) {
      return OrderStatusTypeTransformer.toJson(value).toString();
    }
    if (value is TenantType) {
      return TenantTypeTypeTransformer.toJson(value).toString();
    }
    if (value is TerminalType) {
      return TerminalTypeTypeTransformer.toJson(value).toString();
    }
    if (value is UserRole) {
      return UserRoleTypeTransformer.toJson(value).toString();
    }

    return jsonEncode(value);
  }
}
