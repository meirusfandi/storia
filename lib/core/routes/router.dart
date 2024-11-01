import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:storia/presentation/pages/detail_story_page.dart';
import 'package:storia/presentation/pages/login_page.dart';
import 'package:storia/presentation/pages/register_page.dart';
import 'package:storia/presentation/pages/splash_page.dart';
import 'package:storia/presentation/pages/story_form_page.dart';
import 'package:storia/presentation/pages/story_page.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, path: '/'),
        AutoRoute(page: LoginRoute.page, path: '/login-screen'),
        AutoRoute(page: RegisterRoute.page, path: '/register-screen'),
        AutoRoute(page: StoryRoute.page, path: '/story-screen'),
        AutoRoute(page: StoryFormRoute.page, path: '/story-form-screen'),
        AutoRoute(page: DetailStoryRoute.page, path: '/detail-story-screen'),
      ];
}

class $AppRouter {}
