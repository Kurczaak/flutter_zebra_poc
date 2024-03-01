import 'package:freezed_annotation/freezed_annotation.dart';

part 'scanner_failure.freezed.dart';

@freezed
abstract class ScannerFailure with _$ScannerFailure {
  const factory ScannerFailure.unexpected() = _Unexpected;
}
