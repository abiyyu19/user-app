import 'dart:convert';

extension MapExtension on Map {
  String getPrettyJSONString() {
    const JsonEncoder encoder = JsonEncoder.withIndent('     ');
    return encoder.convert(this);
  }
}
