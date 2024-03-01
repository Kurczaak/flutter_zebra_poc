import 'package:freezed_annotation/freezed_annotation.dart';

part 'scan_data.freezed.dart';

@freezed
class ScanData with _$ScanData {
  const factory ScanData({
    required String barcode,
    required DateTime timestamp,
  }) = _ScanData;
}
