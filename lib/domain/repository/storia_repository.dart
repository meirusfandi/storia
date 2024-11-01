import 'package:dartz/dartz.dart';
import 'package:storia/core/failure/failure.dart';
import 'package:storia/data/model/response/add_story_response.dart';
import 'package:storia/data/model/response/login_response.dart';
import 'package:storia/data/model/response/register_response.dart';
import 'package:storia/data/model/response/story_detail_response.dart';
import 'package:storia/data/model/response/story_list_response.dart';
import 'package:storia/domain/usecase/do_login.dart';
import 'package:storia/domain/usecase/do_register.dart';
import 'package:storia/domain/usecase/do_submit_story.dart';
import 'package:storia/domain/usecase/get_detail_story.dart';
import 'package:storia/domain/usecase/get_list_story.dart';

abstract class StoriaRepository {
  Future<Either<Failure, LoginResponse>> doLogin(LoginParams params);
  Future<Either<Failure, RegisterResponse>> doRegister(RegisterParams params);
  Future<Either<Failure, AddStoryResponse>> doSubmitStory(
      SubmitStoryParams params);
  Future<Either<Failure, StoryListResponse>> doStories(StoryParams params);
  Future<Either<Failure, StoryDetailResponse>> doDetailStory(
      DetailStoryParams params);
}
