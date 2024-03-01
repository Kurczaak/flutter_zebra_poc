import 'dart:convert';

import 'package:chicken_barcode_scanner/barcode_scanner.dart';
import 'package:chicken_barcode_scanner/scan_mode.dart';
import 'package:chicken_barcode_scanner/scan_result.dart';
import 'package:chicken_barcode_scanner/scanner_device_status.dart';
import 'package:chicken_barcode_scanner/src/data_wedge_command.dart';
import 'package:chicken_barcode_scanner/src/device_scan_result_dto.dart';
import 'package:chicken_barcode_scanner/src/mappers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: ChickenBarcodeScanner)
class FlutterBarcodeScannerImpl implements ChickenBarcodeScanner {
  static const _lineColor = "#ff6666";
  static const _cancelButtonText = 'Cancel';
  static const _isShowFlashIcon = true;

  EventChannel? scanChannel;
  EventChannel? deviceStatusChannel;
  MethodChannel? methodChannel;

  @override
  Stream<ScanResult>? cameraContinuousScan(
          {ChickenScanMode scanMode = ChickenScanMode.barcode}) =>
      FlutterBarcodeScanner.getBarcodeStreamReceiver(_lineColor,
              _cancelButtonText, _isShowFlashIcon, scanMode.toScanMode())
          ?.map(
        (event) => ScanResult(
          barcode: event.toString(),
          labelType: scanMode.toLabelType(),
          timestamp: DateTime.now(),
        ),
      );

  @override
  Future<ScanResult> cameraScan(
          {ChickenScanMode scanMode = ChickenScanMode.barcode}) =>
      FlutterBarcodeScanner.scanBarcode(_lineColor, _cancelButtonText,
              _isShowFlashIcon, scanMode.toScanMode())
          .then(
        (event) => ScanResult(
          barcode: event.toString(),
          labelType: scanMode.toLabelType(),
          timestamp: DateTime.now(),
        ),
      );

  @override
  Stream<ScanResult>? openDeviceScanChannel() {
    scanChannel ??= const EventChannel('com.example.flutter_zebra_poc/scan');

    return scanChannel!.receiveBroadcastStream().map((event) {
      return DeviceScanResultDTO.fromJson(jsonDecode(event)).toScanResult();
    });
  }

  @override
  Stream<ScannerDeviceStatus>? openDeviceStatusChannel() {
    // TODO(Kura): implement native code
    deviceStatusChannel ??=
        const EventChannel('com.example.flutter_zebra_poc/status');
    throw UnimplementedError();
  }

  @override
  Future<void> startDeviceScan() => _sendDataWedgeCommand(DataWedgeCommand(
      command: 'com.symbol.datawedge.api.SOFT_SCAN_TRIGGER',
      parameter: 'START_SCANNING'));

  @override
  Future<void> stopDeviceScan() => _sendDataWedgeCommand(DataWedgeCommand(
      command: 'com.symbol.datawedge.api.SOFT_SCAN_TRIGGER',
      parameter: 'STOP_SCANNING'));

  Future<void> _sendDataWedgeCommand(DataWedgeCommand command) async {
    try {
      methodChannel ??=
          const MethodChannel('com.example.flutter_zebra_poc/command');
      await methodChannel?.invokeMethod(
          'sendDataWedgeCommandStringParameter', command.toJson());
    } on PlatformException {
      // TODO: handle error
      //  Error invoking Android method
    }
  }
}
