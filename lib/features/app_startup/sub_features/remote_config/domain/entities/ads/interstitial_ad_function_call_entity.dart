import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class InterstitialAdFunctionCallEntity extends Equatable {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'id_ios')
  final String idIOS;
  @JsonKey(name: 'call_wait_count')
  final int callWaitCount;

  const InterstitialAdFunctionCallEntity({
    required this.id,
    required this.idIOS,
    required this.callWaitCount,
  });

  @override
  List<Object?> get props => [id, idIOS, callWaitCount];
}
