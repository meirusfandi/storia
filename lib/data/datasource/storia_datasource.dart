import 'package:dartz/dartz.dart';
import 'package:storia/core/failure/failure.dart';
import 'package:storia/data/model/request/add_story_request.dart';
import 'package:storia/data/model/request/login_request.dart';
import 'package:storia/data/model/request/register_request.dart';
import 'package:storia/data/model/request/story_list_request.dart';
import 'package:storia/data/model/response/add_story_response.dart';
import 'package:storia/data/model/response/login_response.dart';
import 'package:storia/data/model/response/register_response.dart';
import 'package:storia/data/model/response/story_detail_response.dart';
import 'package:storia/data/model/response/story_list_response.dart';

abstract class StoriaDataSource {
  Future<Either<Failure, LoginResponse>> doLogin(LoginRequest request);
  Future<Either<Failure, RegisterResponse>> doRegister(RegisterRequest request);
  Future<Either<Failure, AddStoryResponse>> doSubmitStory(
      AddStoryRequest request);
  Future<Either<Failure, StoryListResponse>> doStories(
      StoryListRequest request);
  Future<Either<Failure, StoryDetailResponse>> doDetailStory(String storyId);
}
