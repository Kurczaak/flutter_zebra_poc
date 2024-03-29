import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_param.freezed.dart';

@freezed
abstract class LoginParam with _$LoginParam {
  const factory LoginParam({
    required String email,
    required String password,
  }) = _LoginParam;
}
