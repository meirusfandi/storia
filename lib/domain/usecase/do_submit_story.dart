import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:storia/core/failure/failure.dart';
import 'package:storia/core/resources/usecase.dart';
import 'package:storia/domain/entity/add_story_entity.dart';
import 'package:storia/domain/repository/storia_repository.dart';

class DoSubmitStory extends UseCase<AddStoryEntity, SubmitStoryParams> {
  final StoriaRepository repository;

  DoSubmitStory(this.repository);

  @override
  Future<Either<Failure, AddStoryEntity>> call(SubmitStoryParams params) async {
    final result = await repository.doSubmitStory(params);
    return result.fold((l) => Left(l), (r) {
      return Right(AddStoryEntity(
        error: r.error ?? false,
        message: r.message ?? '',
      ));
    });
  }
}

class SubmitStoryParams extends Equatable {
  final String description;
  final String photo;
  final double lat;
  final double lon;

  const SubmitStoryParams(
      {required this.description,
      required this.photo,
      required this.lat,
      required this.lon});

  @override
  List<Object?> get props => [description, photo, lat, lon];
}
