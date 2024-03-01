part of 'scanner_bloc.dart';

@freezed
class ScannerEvent with _$ScannerEvent {
  const factory ScannerEvent.init() = _Init;
  const factory ScannerEvent.scanWithCamera() = _ScanWithCamera;
  const factory ScannerEvent.toggleDeviceScanner({
    required bool turnOn,
  }) = _ToggleDeviceScanner;
  const factory ScannerEvent.receivedScanData({
    required ScanData scanData,
  }) = _ReceivedScanData;
}
