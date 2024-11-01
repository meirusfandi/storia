import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:storia/core/failure/failure.dart';
import 'package:storia/core/helper/pref_helpers.dart';
import 'package:storia/core/resources/rest_client.dart';
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

class StoriaDatasourceImpl implements StoriaDataSource {
  final RestClient restClient;

  StoriaDatasourceImpl(this.restClient);

  @override
  Future<Either<Failure, StoryDetailResponse>> doDetailStory(
      String storyId) async {
    final token = prefHelpers.getAccessToken ?? '';
    try {
      final response =
          await restClient.doGetDetailStories("Bearer $token", storyId);
      return Future.value(Right(response));
    } on DioException catch (e) {
      return Left(StoryFailure(exception: e));
    } catch (e) {
      return Left(StoryFailure(otherException: e.toString()));
    }
  }

  @override
  Future<Either<Failure, LoginResponse>> doLogin(LoginRequest request) async {
    try {
      final response = await restClient.doLogin(request);
      return Future.value(Right(response));
    } on DioException catch (e) {
      return Left(LoginFailure(exception: e));
    } catch (e) {
      return Left(LoginFailure(otherException: e.toString()));
    }
  }

  @override
  Future<Either<Failure, RegisterResponse>> doRegister(
      RegisterRequest request) async {
    try {
      final response = await restClient.doRegister(request);
      return Future.value(Right(response));
    } on DioException catch (e) {
      return Left(RegisterFailure(exception: e));
    } catch (e) {
      return Left(RegisterFailure(otherException: e.toString()));
    }
  }

  @override
  Future<Either<Failure, StoryListResponse>> doStories(
      StoryListRequest request) async {
    final token = prefHelpers.getAccessToken ?? '';
    try {
      final response = await restClient.doGetStories(
          "Bearer $token", request.page, request.size, request.location);
      return Future.value(Right(response));
    } on DioException catch (e) {
      return Left(StoryFailure(exception: e));
    } catch (e) {
      return Left(StoryFailure(otherException: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AddStoryResponse>> doSubmitStory(
      AddStoryRequest request) async {
    final token = prefHelpers.getAccessToken ?? '';
    try {
      final file = File(request.photo);
      final response = await restClient.doSubmitStory(
          "Bearer $token", file, request.description, request.lat, request.lon);
      return Future.value(Right(response));
    } on DioException catch (e) {
      return Left(FormStoryFailure(exception: e));
    } catch (e) {
      return Left(FormStoryFailure(otherException: e.toString()));
    }
  }
}
