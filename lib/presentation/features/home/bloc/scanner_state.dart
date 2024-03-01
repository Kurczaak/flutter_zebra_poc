part of 'scanner_bloc.dart';

@freezed
class ScannerState with _$ScannerState {
  const factory ScannerState.initial() = _Initial;
  const factory ScannerState.loading() = _Loading;
  const factory ScannerState.loaded({
    required ScanData scanData,
  }) = _Loaded;
}
