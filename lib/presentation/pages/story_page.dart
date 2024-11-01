import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storia/core/config/presentation/language_dialog.dart';
import 'package:storia/core/helper/pref_helpers.dart';
import 'package:storia/core/helper/pref_key.dart';
import 'package:storia/core/resources/injection_container.dart';
import 'package:storia/core/routes/router.dart';
import 'package:storia/core/utils/color_widget.dart';
import 'package:storia/core/utils/container_widget.dart';
import 'package:storia/core/utils/text_widget.dart';
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
  int size = 10;
  int page = 1;
  String userName = "";

  @override
  void initState() {
    userName = prefHelpers.getUserName ?? "-";
    sl<StoryListBloc>().add(ListEvent(size: size, page: page, location: 0));
    super.initState();
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
              loading: state.isLoading,
              floatingActionButton: Container(
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
                      ? SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                                state.listEntity?.listStory.length ?? 0,
                                (int index) => ItemStoryWidget(
                                    id: state.listEntity?.listStory[index].id ??
                                        '',
                                    name: state.listEntity?.listStory[index]
                                            .name ??
                                        '',
                                    description: state.listEntity
                                            ?.listStory[index].description ??
                                        '',
                                    imageUrl: state.listEntity?.listStory[index]
                                            .photoUrl ??
                                        '',
                                    createdAt: state.listEntity
                                            ?.listStory[index].createdAt ??
                                        '')),
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
