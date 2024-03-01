import 'package:json_annotation/json_annotation.dart';

part 'device_scan_result_dto.g.dart';

@JsonSerializable()
class DeviceScanResultDTO {
  DeviceScanResultDTO({
    required this.scanData,
    required this.symbology,
    required this.dateTime,
  });

  final String scanData;
  final String symbology;
  final DateTime dateTime;

  factory DeviceScanResultDTO.fromJson(Map<String, dynamic> json) =>
      _$DeviceScanResultDTOFromJson(json);
}
