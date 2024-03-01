import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_zebra_poc/domain/model/scanner/scan_data.dart';
import 'package:flutter_zebra_poc/domain/use_case/scanner/get_device_scanner_channel_use_case.dart';
import 'package:flutter_zebra_poc/domain/use_case/scanner/scan_code_by_camera_use_case.dart';
import 'package:flutter_zebra_poc/domain/use_case/scanner/toggle_device_scanner_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'scanner_bloc.freezed.dart';
part 'scanner_event.dart';
part 'scanner_state.dart';

@injectable
class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  ScannerBloc(this._getDeviceScannerChannelUseCase,
      this._scanCodeByCameraUseCase, this._toggleDeviceScannerUseCase)
      : super(const _Initial()) {
    on<ScannerEvent>((event, emit) async {
      await event.map(
          init: (e) async => await _onInit(emit),
          scanWithCamera: (e) async => await _onScanWithCamera(emit),
          toggleDeviceScanner: (e) async =>
              await _onToggleDeviceScanner(e, emit),
          receivedScanData: (e) async => _onReceivedScanData(e, emit));
    });
  }

  final GetDeviceScannerChannelUseCase _getDeviceScannerChannelUseCase;
  final ScanCodeByCameraUseCase _scanCodeByCameraUseCase;
  final ToggleDeviceScannerUseCase _toggleDeviceScannerUseCase;

  StreamSubscription<ScanData>? _deviceScannerStreamSubscription;

  Future<void> _onInit(Emitter<ScannerState> emit) async {
    final result = await _getDeviceScannerChannelUseCase();
    result.fold(
      (l) => null,
      (r) {
        _deviceScannerStreamSubscription = r.listen(
          (scanData) {
            add(ScannerEvent.receivedScanData(scanData: scanData));
          },
        );
      },
    );
  }

  Future<void> _onScanWithCamera(Emitter<ScannerState> emit) async {
    final result = await _scanCodeByCameraUseCase();
    result.fold(
      (l) => null,
      (r) => add(ScannerEvent.receivedScanData(scanData: r)),
    );
  }

  Future<void> _onToggleDeviceScanner(
      _ToggleDeviceScanner e, Emitter<ScannerState> emit) async {
    await _toggleDeviceScannerUseCase(e.turnOn);
  }

  void _onReceivedScanData(_ReceivedScanData e, Emitter<ScannerState> emit) =>
      emit(ScannerState.loaded(scanData: e.scanData));

  @override
  Future<void> close() {
    _deviceScannerStreamSubscription?.cancel();
    return super.close();
  }
}
