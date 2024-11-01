import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:storia/core/failure/failure.dart';
import 'package:storia/core/resources/usecase.dart';
import 'package:storia/domain/entity/login_entity.dart';
import 'package:storia/domain/repository/storia_repository.dart';

class DoLogin extends UseCase<LoginEntity, LoginParams> {
  final StoriaRepository repository;

  DoLogin(this.repository);

  @override
  Future<Either<Failure, LoginEntity>> call(LoginParams params) async {
    final result = await repository.doLogin(params);
    return result.fold((l) => Left(l), (r) {
      return Right(LoginEntity(
          error: r.error ?? false,
          message: r.message ?? '',
          loginResult: ResultLoginEntity(
            name: r.loginResult?.name ?? '',
            userId: r.loginResult?.userId ?? '',
            token: r.loginResult?.token ?? '',
          )));
    });
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
