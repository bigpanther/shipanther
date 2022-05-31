import 'package:uuid/uuid.dart';

String uuid() {
  const uuid = Uuid();
  return uuid.v4();
}
