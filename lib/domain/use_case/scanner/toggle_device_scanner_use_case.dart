import 'package:base/domain/usecases/base_use_case.dart';
import 'package:chicken_barcode_scanner/barcode_scanner.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_zebra_poc/domain/model/failure/scanner_failure.dart';
import 'package:injectable/injectable.dart';

@injectable
class ToggleDeviceScannerUseCase extends UseCase<ScannerFailure, Unit, bool> {
  final ChickenBarcodeScanner _chickenBarcodeScanner;

  ToggleDeviceScannerUseCase(this._chickenBarcodeScanner);

  @override
  Future<Either<ScannerFailure, Unit>> execute(bool turnOn) async {
    try {
      turnOn
          ? await _chickenBarcodeScanner.startDeviceScan()
          : _chickenBarcodeScanner.stopDeviceScan();
      return const Right(unit);
    } catch (e) {
      return const Left(ScannerFailure.unexpected());
    }
  }
}
