import 'package:json_annotation/json_annotation.dart';

part 'device_scan_result_dto.g.dart';

@JsonSerializable()
class DeviceScanResultDTO {
  DeviceScanResultDTO({
    required this.scanData,
    required this.symbology,
  });

  final String scanData;
  final String symbology;

  factory DeviceScanResultDTO.fromJson(Map<String, dynamic> json) =>
      _$DeviceScanResultDTOFromJson(json);
}
