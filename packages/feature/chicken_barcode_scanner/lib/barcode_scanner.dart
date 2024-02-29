import 'package:chicken_barcode_scanner/scan_mode.dart';
import 'package:chicken_barcode_scanner/scanning_device.dart';

abstract class ChickenBarcodeScanner {
  Future<String> scanBarcode({
    ScanMode scanMode = ScanMode.barcode,
    ScanningDevice scanningDevice = ScanningDevice.camera,
  });

  Stream<String> getBarcodeStream({
    ScanMode scanMode = ScanMode.barcode,
    ScanningDevice scanningDevice = ScanningDevice.camera,
  });
}
