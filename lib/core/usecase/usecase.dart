import 'package:equatable/equatable.dart';

// Parameters have to be put into a container object so that they can be
// included in this abstract base class method definition.
abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

abstract class UseCaseWithoutParams<Type> {
  Future<Type> get call;
}

abstract class UseCaseWithoutReturnType<Params> {
  Future<void> call(Params params);
}

abstract class UseCaseWithoutParamsAndReturnType {
  Future<void> get call;
}

abstract class UseCaseWithoutAsync<Type, Params> {
  Type call(Params params);
}

abstract class UseCaseWithoutAsyncAndParams<Type> {
  Type get call;
}

// This will be used by the code calling the use case whenever the use case
// doesn't accept any parameters.
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
