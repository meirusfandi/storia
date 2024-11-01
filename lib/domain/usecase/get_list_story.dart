import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:storia/core/failure/failure.dart';
import 'package:storia/core/resources/usecase.dart';
import 'package:storia/domain/entity/story_list_entity.dart';
import 'package:storia/domain/repository/storia_repository.dart';

class GetListStory extends UseCase<StoryListEntity, StoryParams> {
  final StoriaRepository repository;

  GetListStory(this.repository);

  @override
  Future<Either<Failure, StoryListEntity>> call(StoryParams params) async {
    final result = await repository.doStories(params);
    return result.fold((l) => Left(l), (r) {
      return Right(StoryListEntity(
        error: r.error ?? false,
        message: r.message ?? '',
        listStory: r.listStory
                ?.map((e) => ResultStoryListEntity(
                    id: e.id ?? '',
                    name: e.name ?? '',
                    description: e.description ?? '',
                    photoUrl: e.photoUrl ?? '',
                    createdAt: e.createdAt ?? '',
                    lat: e.lat ?? 0.0,
                    lon: e.lon ?? 0.0))
                .toList() ??
            [],
      ));
    });
  }
}

class StoryParams extends Equatable {
  final int page;
  final int size;
  final int location;

  const StoryParams(
      {required this.page, required this.size, required this.location});

  @override
  List<Object?> get props => [page, size, location];
}
