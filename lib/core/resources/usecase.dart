import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:storia/core/failure/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCaseNoParam<Type> {
  Future<Either<Failure, Type>> call();
}

abstract class UseCaseNoReturn<Params> {
  call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
