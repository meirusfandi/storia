import 'package:alice/alice.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:storia/core/config/bloc/config_bloc.dart';
import 'package:storia/core/resources/data_interceptor.dart';
import 'package:storia/core/resources/rest_client.dart';
import 'package:storia/core/utils/constants.dart';
import 'package:storia/data/datasource/storia_datasource.dart';
import 'package:storia/data/datasource/storia_datasource_impl.dart';
import 'package:storia/data/repository/storia_repository_impl.dart';
import 'package:storia/domain/repository/storia_repository.dart';
import 'package:storia/domain/usecase/do_login.dart';
import 'package:storia/domain/usecase/do_register.dart';
import 'package:storia/domain/usecase/do_submit_story.dart';
import 'package:storia/domain/usecase/get_detail_story.dart';
import 'package:storia/domain/usecase/get_list_story.dart';
import 'package:storia/presentation/bloc/form_story_bloc.dart';
import 'package:storia/presentation/bloc/login_bloc.dart';
import 'package:storia/presentation/bloc/register_bloc.dart';
import 'package:storia/presentation/bloc/story_detail_bloc.dart';
import 'package:storia/presentation/bloc/story_list_bloc.dart';

final sl = GetIt.instance;
const platform = MethodChannel("channel");

Future<void> init() async {
  Dio createDio() {
    var dio = Dio(
      BaseOptions(
        headers: {"content-type": "application/json"},
      ),
    );
    return dio;
  }

  final Dio dio = createDio();
  Alice alice = Alice(showNotification: true);
  dio.interceptors.add(alice.getDioInterceptor());
  sl.registerSingleton<Alice>(alice);

  dio.interceptors.add(DataInterceptor());
  sl.registerSingleton<RestClient>(RestClient(dio, baseUrl: Constants.baseUrl));
  sl.registerLazySingleton(() => ConfigBloc());

  // datasource
  sl.registerLazySingleton<StoriaDataSource>(() => StoriaDatasourceImpl(sl()));

  // repository
  sl.registerLazySingleton<StoriaRepository>(() => StoriaRepositoryImpl(sl()));

  // usecase
  sl.registerLazySingleton(() => DoLogin(sl()));
  sl.registerLazySingleton(() => DoRegister(sl()));
  sl.registerLazySingleton(() => DoSubmitStory(sl()));
  sl.registerLazySingleton(() => GetDetailStory(sl()));
  sl.registerLazySingleton(() => GetListStory(sl()));

  // bloc
  sl.registerLazySingleton(() => LoginBloc(doLogin: sl()));
  sl.registerLazySingleton(() => RegisterBloc(doRegister: sl()));
  sl.registerLazySingleton(() => FormStoryBloc(doSubmitStory: sl()));
  sl.registerLazySingleton(() => StoryListBloc(getListStory: sl()));
  sl.registerLazySingleton(() => StoryDetailBloc(getDetailStory: sl()));
}
