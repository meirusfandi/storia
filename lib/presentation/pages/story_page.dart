import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storia/core/config/flavor/flavor_config.dart';
import 'package:storia/core/config/presentation/language_dialog.dart';
import 'package:storia/core/helper/pref_helpers.dart';
import 'package:storia/core/helper/pref_key.dart';
import 'package:storia/core/resources/injection_container.dart';
import 'package:storia/core/routes/router.dart';
import 'package:storia/core/utils/color_widget.dart';
import 'package:storia/core/utils/container_widget.dart';
import 'package:storia/core/utils/text_widget.dart';
import 'package:storia/core/utils/toast.dart';
import 'package:storia/domain/entity/story_list_entity.dart';
import 'package:storia/presentation/bloc/login_bloc.dart';
import 'package:storia/presentation/bloc/story_list_bloc.dart';
import 'package:storia/presentation/widgets/empty_view_widget.dart';
import 'package:storia/presentation/widgets/item_story_widget.dart';
import 'package:storia/presentation/widgets/page_template.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StatefulWidget> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  final ScrollController scrollController = ScrollController();
  int size = 10;
  int page = 1;
  int storyCount = 0;
  String userName = "";
  List<ResultStoryListEntity> listStory = [];

  @override
  void initState() {
    userName = prefHelpers.getUserName ?? "-";
    sl<StoryListBloc>().add(ListEvent(size: size, page: page, location: 0));
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String lang = prefInstance.getString(PrefKey.appLang.name) ?? 'id';

    return MultiBlocListener(
        listeners: [
          BlocListener<LoginBloc, LoginState>(listener: (context, state) {
            if (!state.isLoading && state.isLogout == true) {
              context.router.replaceAll([const LoginRoute()]);
            }
          }),
          BlocListener<StoryListBloc, StoryListState>(listener: (context, state) {
            log('state on page $page: $state');
            if (!state.isLoading && state.listEntity != null) {
              storyCount = state.listEntity?.listStory.length ?? 0;
              listStory.addAll(state.listEntity?.listStory ?? []);
            }
          })
        ],
        child: BlocBuilder<StoryListBloc, StoryListState>(
            builder: (context, state) {
          return PageTemplate(
              appBar: AppBar(
                title: TextWidget.manropeSemiBold(
                    AppLocalizations.of(context)?.story_welcome(userName) ?? '',
                    size: 18,
                    color: ColorWidget.iconPrimaryColor),
                backgroundColor: ColorWidget.primaryColor,
                actions: [
                  IconButton(
                      onPressed: () => showSheet(
                            context,
                            LanguageDialog(
                                lang: lang,
                                callback: (item) async {
                                  setState(() {
                                    lang = item?.code ?? 'id';
                                  });
                                }),
                          ),
                      icon: Icon(Icons.translate,
                          color: ColorWidget.iconPrimaryColor)),
                  IconButton(
                      onPressed: () =>
                          sl<LoginBloc>().add(const DoLogoutEvent()),
                      icon: Icon(Icons.logout,
                          color: ColorWidget.iconPrimaryColor)),
                ],
              ),
              loading: state.isLoading && page == 1,
              floatingActionButton: (FlavorConfig.instance.flavor == FlavorType.dev) ? const SizedBox() : Container(
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: FloatingActionButton(
                  backgroundColor: ColorWidget.primaryColor,
                  onPressed: () => context.pushRoute(const StoryFormRoute()),
                  isExtended: true,
                  elevation: 0.0,
                  child: Icon(Icons.add, color: ColorWidget.iconPrimaryColor),
                ),
              ),
              child: SafeArea(
                  child: (state.listEntity?.listStory.isNotEmpty ?? false)
                      ? NotificationListener<ScrollNotification>(
                        onNotification: (scrollNotification) {
                          if (scrollNotification is ScrollUpdateNotification) {
                            if (scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent) {
                              if (storyCount < size) {
                                showSuccess(context, AppLocalizations.of(context)?.story_max_refresh ?? '');
                              } else {
                                page++;
                                sl<StoryListBloc>().add(ListMoreEvent(page: page, size: size, location: 0));
                              }
                            }
                          }
                          return false;
                        },
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: ((state.listEntity?.listStory.isEmpty ?? false) || state.isLoading)
                            ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator())
                            : Column(
                              children: [
                                ListView.builder(
                                  controller: scrollController,
                                  shrinkWrap: true,
                                  itemCount: listStory.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return ItemStoryWidget(
                                        id: listStory[index].id,
                                        name: listStory[index]
                                            .name,
                                        description: listStory[index].description,
                                        imageUrl: listStory[index]
                                            .photoUrl,
                                        createdAt: listStory[index].createdAt);
                                  }
                                ),
                                if (state.isLoadingMore)
                                  const SizedBox(height: 24, width: 24, child: CircularProgressIndicator())
                              ],
                            )
                          ),
                      )
                      : EmptyViewWidget(
                          title:
                              AppLocalizations.of(context)?.story_empty_title ??
                                  '',
                          description:
                              AppLocalizations.of(context)?.story_empty_desc ??
                                  '')));
        }));
  }
}
