import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:storia/core/failure/failure.dart';
import 'package:storia/core/resources/usecase.dart';
import 'package:storia/domain/entity/story_detail_entity.dart';
import 'package:storia/domain/entity/story_list_entity.dart';
import 'package:storia/domain/repository/storia_repository.dart';

class GetDetailStory extends UseCase<StoryDetailEntity, DetailStoryParams> {
  final StoriaRepository repository;

  GetDetailStory(this.repository);

  @override
  Future<Either<Failure, StoryDetailEntity>> call(
      DetailStoryParams params) async {
    final result = await repository.doDetailStory(params);
    return result.fold((l) => Left(l), (r) {
      return Right(StoryDetailEntity(
        error: r.error ?? false,
        message: r.message ?? '',
        story: ResultStoryListEntity(
            id: r.story?.id ?? '',
            name: r.story?.name ?? '',
            description: r.story?.description ?? '',
            photoUrl: r.story?.photoUrl ?? '',
            createdAt: r.story?.createdAt ?? '',
            lat: r.story?.lat ?? 0.0,
            lon: r.story?.lon ?? 0.0),
      ));
    });
  }
}

class DetailStoryParams extends Equatable {
  final String storyId;

  const DetailStoryParams({required this.storyId});

  @override
  List<Object?> get props => [storyId];
}
