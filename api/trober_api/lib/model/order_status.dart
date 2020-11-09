part of trober_api.api;

enum OrderStatus {
  open,
  accepted,
  cancelled,
  inProgress,
  delivered,
  invoiced,
  paymentReceived
}

class OrderStatusTypeTransformer {
  static Map<String, OrderStatus> fromJsonMap = {
    "Open": OrderStatus.open,
    "Accepted": OrderStatus.accepted,
    "Cancelled": OrderStatus.cancelled,
    "InProgress": OrderStatus.inProgress,
    "Delivered": OrderStatus.delivered,
    "Invoiced": OrderStatus.invoiced,
    "PaymentReceived": OrderStatus.paymentReceived
  };
  static Map<OrderStatus, String> toJsonMap = {
    OrderStatus.open: "Open",
    OrderStatus.accepted: "Accepted",
    OrderStatus.cancelled: "Cancelled",
    OrderStatus.inProgress: "InProgress",
    OrderStatus.delivered: "Delivered",
    OrderStatus.invoiced: "Invoiced",
    OrderStatus.paymentReceived: "PaymentReceived"
  };

  static OrderStatus fromJson(dynamic data) {
    var found = fromJsonMap[data];
    if (found == null) {
      throw ('Unknown enum value to decode: $data');
    }
    return found;
  }

  static dynamic toJson(OrderStatus data) {
    return toJsonMap[data];
  }

  static List<OrderStatus> listFromJson(List<dynamic> json) {
    return json == null
        ? <OrderStatus>[]
        : json.map((value) => fromJson(value)).toList();
  }

  static OrderStatus copyWith(OrderStatus instance) {
    return instance;
  }

  static Map<String, OrderStatus> mapFromJson(Map<String, dynamic> json) {
    final map = <String, OrderStatus>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = fromJson(value));
    }
    return map;
  }
}
