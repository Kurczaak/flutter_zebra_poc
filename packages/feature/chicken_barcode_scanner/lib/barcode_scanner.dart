import 'package:chicken_barcode_scanner/scan_mode.dart';
import 'package:chicken_barcode_scanner/scan_result.dart';
import 'package:chicken_barcode_scanner/scanner_device_status.dart';

abstract class ChickenBarcodeScanner {
  Future<ScanResult> cameraScan({
    ChickenScanMode scanMode = ChickenScanMode.barcode,
  });

  Stream<ScanResult>? cameraContinuousScan({
    ChickenScanMode scanMode = ChickenScanMode.barcode,
  });

  Stream<ScanResult>? openDeviceScanChannel();

  Stream<ScannerDeviceStatus>? openDeviceStatusChannel();

  Future<void> startDeviceScan();

  Future<void> stopDeviceScan();
}
