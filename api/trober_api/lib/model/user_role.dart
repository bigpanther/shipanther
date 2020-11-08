part of trober_api.api;

enum UserRole { superAdmin, admin, backOffice, driver, customer }

class UserRoleTypeTransformer {
  static Map<String, UserRole> fromJsonMap = {
    "SuperAdmin": UserRole.superAdmin,
    "Admin": UserRole.admin,
    "BackOffice": UserRole.backOffice,
    "Driver": UserRole.driver,
    "Customer": UserRole.customer
  };
  static Map<UserRole, String> toJsonMap = {
    UserRole.superAdmin: "SuperAdmin",
    UserRole.admin: "Admin",
    UserRole.backOffice: "BackOffice",
    UserRole.driver: "Driver",
    UserRole.customer: "Customer"
  };

  static UserRole fromJson(dynamic data) {
    var found = fromJsonMap[data];
    if (found == null) {
      throw ('Unknown enum value to decode: $data');
    }
    return found;
  }

  static dynamic toJson(UserRole data) {
    return toJsonMap[data];
  }

  static List<UserRole> listFromJson(List<dynamic> json) {
    return json == null
        ? <UserRole>[]
        : json.map((value) => fromJson(value)).toList();
  }

  static UserRole copyWith(UserRole instance) {
    return instance;
  }

  static Map<String, UserRole> mapFromJson(Map<String, dynamic> json) {
    final map = <String, UserRole>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = fromJson(value));
    }
    return map;
  }
}
