import 'package:chicken_barcode_scanner/barcode_scanner.dart';
import 'package:chicken_barcode_scanner/scan_mode.dart';
import 'package:chicken_barcode_scanner/scanning_device.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart' as fbs;

class FlutterBarcodeScannerImpl implements ChickenBarcodeScanner {
  static const _lineColor = "#ff6666";
  static const _cancelButtonText = 'Cancel';
  static const _isShowFlashIcon = true;

  @override
  Stream<String> getBarcodeStream(
      {ScanMode scanMode = ScanMode.barcode,
      ScanningDevice scanningDevice = ScanningDevice.camera}) {
    // TODO: implement getBarcodeStream
    throw UnimplementedError();
  }

  @override
  Future<String> scanBarcode(
      {ScanMode scanMode = ScanMode.barcode,
      ScanningDevice scanningDevice = ScanningDevice.camera}) {
    // TODO: implement scanBarcode
    throw UnimplementedError();
  }

  Stream<String>? _getBarcodeStreamFlutterBarcodeScannerImpl(
      {ScanMode scanMode = ScanMode.barcode,
      ScanningDevice scanningDevice = ScanningDevice.camera}) {
    return fbs.FlutterBarcodeScanner.getBarcodeStreamReceiver(_lineColor,
            _cancelButtonText, _isShowFlashIcon, _mapScanMode(scanMode))
        ?.map((event) => event.toString());
  }

  Future<String> _scanBardoceFlutterBarcodeScannerImpl(
          {ScanMode scanMode = ScanMode.barcode,
          ScanningDevice scanningDevice = ScanningDevice.camera}) =>
      fbs.FlutterBarcodeScanner.scanBarcode(_lineColor, _cancelButtonText,
          _isShowFlashIcon, _mapScanMode(scanMode));

  fbs.ScanMode _mapScanMode(ScanMode scanMode) => switch (scanMode) {
        ScanMode.barcode => fbs.ScanMode.BARCODE,
        ScanMode.qr => fbs.ScanMode.QR,
      };
}
