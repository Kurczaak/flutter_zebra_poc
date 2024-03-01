import 'package:chicken_barcode_scanner/label_type.dart';
import 'package:chicken_barcode_scanner/scan_mode.dart';
import 'package:chicken_barcode_scanner/scan_result.dart';
import 'package:chicken_barcode_scanner/src/device_scan_result_dto.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

extension ChickenScanModeExt on ChickenScanMode {
  LabelType toLabelType() => switch (this) {
        ChickenScanMode.barcode => LabelType.ean13,
        ChickenScanMode.qr => LabelType.qr,
      };

  ScanMode toScanMode() => switch (this) {
        ChickenScanMode.barcode => ScanMode.BARCODE,
        ChickenScanMode.qr => ScanMode.QR,
      };
}

extension DeviceScanResultDTOExt on DeviceScanResultDTO {
  ScanResult toScanResult() => ScanResult(
        barcode: scanData,
        labelType: LabelTypeExt.fromString(symbology),
        timestamp: DateTime.now(),
      );
}

extension LabelTypeExt on LabelType {
  static LabelType fromString(String labelType) {
    final labelString = labelType.split('LABEL-TYPE-').last;
    for (final label in LabelType.values) {
      if (label.name.contains(labelString.substring(0, 3))) {
        return label;
      }
    }
    return LabelType.unknown;
  }
}
