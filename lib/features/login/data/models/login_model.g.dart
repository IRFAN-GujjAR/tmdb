// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
  sessionId: json['session_id'] as String,
  accountDetails: AccountDetailsModel.fromJson(
    json['account_details'] as Map<String, dynamic>,
  ),
);
