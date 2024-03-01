import 'package:base/domain/usecases/base_use_case.dart';
import 'package:chicken_barcode_scanner/barcode_scanner.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_zebra_poc/domain/model/failure/scanner_failure.dart';
import 'package:flutter_zebra_poc/domain/model/scanner/scan_data.dart';
import 'package:flutter_zebra_poc/domain/model/scanner/scanner_mappers.dart';
import 'package:injectable/injectable.dart';

@injectable
class ScanCodeByCameraUseCase extends UseCaseNoParam<ScannerFailure, ScanData> {
  ScanCodeByCameraUseCase(this._chickenBarcodeScanner);

  final ChickenBarcodeScanner _chickenBarcodeScanner;

  @override
  Future<Either<ScannerFailure, ScanData>> execute(void param) async {
    try {
      return _chickenBarcodeScanner
          .cameraScan()
          .then((value) => Right(value.toDomain()));
    } catch (e) {
      return const Left(ScannerFailure.unexpected());
    }
  }
}
