import 'package:dartz/dartz.dart';
import 'package:storia/core/failure/failure.dart';
import 'package:storia/data/datasource/storia_datasource.dart';
import 'package:storia/data/model/request/add_story_request.dart';
import 'package:storia/data/model/request/login_request.dart';
import 'package:storia/data/model/request/register_request.dart';
import 'package:storia/data/model/request/story_list_request.dart';
import 'package:storia/data/model/response/add_story_response.dart';
import 'package:storia/data/model/response/login_response.dart';
import 'package:storia/data/model/response/register_response.dart';
import 'package:storia/data/model/response/story_detail_response.dart';
import 'package:storia/data/model/response/story_list_response.dart';
import 'package:storia/domain/repository/storia_repository.dart';
import 'package:storia/domain/usecase/do_login.dart';
import 'package:storia/domain/usecase/do_register.dart';
import 'package:storia/domain/usecase/do_submit_story.dart';
import 'package:storia/domain/usecase/get_detail_story.dart';
import 'package:storia/domain/usecase/get_list_story.dart';

class StoriaRepositoryImpl implements StoriaRepository {
  final StoriaDataSource dataSource;

  StoriaRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, StoryDetailResponse>> doDetailStory(
      DetailStoryParams params) async {
    final result = await dataSource.doDetailStory(params.storyId);
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, LoginResponse>> doLogin(LoginParams params) async {
    final result = await dataSource
        .doLogin(LoginRequest(email: params.email, password: params.password));
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, RegisterResponse>> doRegister(
      RegisterParams params) async {
    final result = await dataSource.doRegister(RegisterRequest(
        name: params.name, email: params.email, password: params.password));
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, StoryListResponse>> doStories(
      StoryParams params) async {
    final result = await dataSource.doStories(StoryListRequest(
        page: params.page, size: params.size, location: params.location));
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, AddStoryResponse>> doSubmitStory(
      SubmitStoryParams params) async {
    final result = await dataSource.doSubmitStory(AddStoryRequest(
        description: params.description,
        photo: params.photo,
        lat: params.lat,
        lon: params.lon));
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}
