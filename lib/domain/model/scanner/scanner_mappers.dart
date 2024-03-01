import 'package:chicken_barcode_scanner/scan_result.dart';
import 'package:flutter_zebra_poc/domain/model/scanner/scan_data.dart';

extension ScanResultExt on ScanResult {
  ScanData toDomain() => ScanData(
        barcode: barcode,
        timestamp: timestamp,
      );
}
