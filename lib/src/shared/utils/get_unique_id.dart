import 'package:uuid/uuid.dart';

String getUniqueId() {
  final uniqueId = Uuid().v4();
  return uniqueId;
}
