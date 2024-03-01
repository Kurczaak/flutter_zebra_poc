import 'package:chicken_barcode_scanner/label_type.dart';

class ScanResult {
  ScanResult({
    required this.labelType,
    required this.barcode,
    required this.timestamp,
  });

  final String barcode;
  final LabelType labelType;
  final DateTime timestamp;
}
