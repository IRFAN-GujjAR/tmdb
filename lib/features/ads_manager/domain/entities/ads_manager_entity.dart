import 'package:equatable/equatable.dart';

class AdsManagerEntity extends Equatable {
  final int functionCallCount;

  const AdsManagerEntity({required this.functionCallCount});

  @override
  List<Object?> get props => [functionCallCount];
}
