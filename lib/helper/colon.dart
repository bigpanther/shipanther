import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

Text displaySubtitle<T>(String key, T? value, {DateFormat? formatter}) {
  if (value == null) {
    return Text('$key:');
  }
  if (value is DateTime) {
    if (formatter == null) {
      throw ArgumentError.notNull();
    }
    return Text('$key: ${formatter.format(value.toLocal())}');
  }
  return Text('$key: $value');
}
