import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:storia/data/model/request/login_request.dart';
import 'package:storia/data/model/request/register_request.dart';
import 'package:storia/data/model/response/add_story_response.dart';
import 'package:storia/data/model/response/login_response.dart';
import 'package:storia/data/model/response/register_response.dart';
import 'package:storia/data/model/response/story_detail_response.dart';
import 'package:storia/data/model/response/story_list_response.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST('login')
  Future<LoginResponse> doLogin(@Body() LoginRequest request);

  @POST('register')
  Future<RegisterResponse> doRegister(@Body() RegisterRequest request);

  @GET('stories')
  Future<StoryListResponse> doGetStories(
      @Header("Authorization") String token,
      @Query('page') int page,
      @Query('size') int size,
      @Query('location') int location);

  @POST('stories')
  @MultiPart()
  Future<AddStoryResponse> doSubmitStory(
      @Header("Authorization") String token,
      @Part() File photo,
      @Part() description,
      @Part() double lat,
      @Part() double lon);

  @GET('stories/{id}')
  Future<StoryDetailResponse> doGetDetailStories(
      @Header("Authorization") String token, @Path('id') String id);
}
