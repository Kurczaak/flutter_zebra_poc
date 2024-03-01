import 'package:base/domain/usecases/base_use_case.dart';
import 'package:chicken_barcode_scanner/barcode_scanner.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_zebra_poc/domain/model/failure/scanner_failure.dart';
import 'package:flutter_zebra_poc/domain/model/scanner/scan_data.dart';
import 'package:flutter_zebra_poc/domain/model/scanner/scanner_mappers.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDeviceScannerChannelUseCase
    extends UseCaseNoParam<ScannerFailure, Stream<ScanData>> {
  final ChickenBarcodeScanner _chickenBarcodeScanner;

  GetDeviceScannerChannelUseCase(this._chickenBarcodeScanner);

  @override
  Future<Either<ScannerFailure, Stream<ScanData>>> execute(void param) async {
    final stream = _chickenBarcodeScanner.openDeviceScanChannel();
    return stream == null
        ? const Left(ScannerFailure.unexpected())
        : Right(stream.map((event) => event.toDomain()));
  }
}
