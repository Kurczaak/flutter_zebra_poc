import 'package:json_annotation/json_annotation.dart';

part 'data_wedge_command.g.dart';

@JsonSerializable()
class DataWedgeCommand {
  DataWedgeCommand({required this.command, required this.parameter});
  final String command;
  final String parameter;

  Map<String, dynamic> toJson() => _$DataWedgeCommandToJson(this);
}
