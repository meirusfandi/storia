import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:storia/core/failure/failure.dart';
import 'package:storia/core/resources/usecase.dart';
import 'package:storia/domain/entity/register_entity.dart';
import 'package:storia/domain/repository/storia_repository.dart';

class DoRegister extends UseCase<RegisterEntity, RegisterParams> {
  final StoriaRepository repository;

  DoRegister(this.repository);

  @override
  Future<Either<Failure, RegisterEntity>> call(RegisterParams params) async {
    final result = await repository.doRegister(params);
    return result.fold((l) => Left(l), (r) {
      return Right(RegisterEntity(
        error: r.error ?? false,
        message: r.message ?? '',
      ));
    });
  }
}

class RegisterParams extends Equatable {
  final String email;
  final String name;
  final String password;

  const RegisterParams(
      {required this.name, required this.email, required this.password});

  @override
  List<Object?> get props => [email, password, name];
}
