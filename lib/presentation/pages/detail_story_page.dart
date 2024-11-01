import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storia/core/helper/date_helper.dart';
import 'package:storia/core/resources/injection_container.dart';
import 'package:storia/core/utils/color_widget.dart';
import 'package:storia/core/utils/container_widget.dart';
import 'package:storia/core/utils/text_widget.dart';
import 'package:storia/presentation/bloc/story_detail_bloc.dart';
import 'package:storia/presentation/widgets/empty_view_widget.dart';
import 'package:storia/presentation/widgets/page_template.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class DetailStoryPage extends StatefulWidget {
  final String storyId;
  const DetailStoryPage({super.key, required this.storyId});

  @override
  State<StatefulWidget> createState() => _DetailStoryPageState();
}

class _DetailStoryPageState extends State<DetailStoryPage> {
  @override
  void initState() {
    sl<StoryDetailBloc>().add(DetailEvent(storyId: widget.storyId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryDetailBloc, StoryDetailState>(
        builder: (context, state) {
      return PageTemplate(
          loading: state.isLoading,
          appBar: AppBar(
            title: TextWidget.manropeSemiBold(
                AppLocalizations.of(context)?.story_detail_title ?? '',
                size: 18,
                color: ColorWidget.iconPrimaryColor),
            backgroundColor: ColorWidget.primaryColor,
            elevation: 0.0,
          ),
          child: SafeArea(
              child: !(state.detailEntity?.error ?? false)
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                            width: double.infinity,
                            height: 320,
                            fit: BoxFit.fill,
                            imageUrl: state.detailEntity?.story.photoUrl ?? '',
                            placeholder: (context, url) => const SizedBox(
                                width: 48,
                                height: 48,
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          TextWidget.manropeBold(
                                  state.detailEntity?.story.name ?? '',
                                  size: 24)
                              .horizontalPadded()
                              .topPadded(),
                          TextWidget.manropeRegular(
                                  DateHelper.parseDate(
                                      state.detailEntity?.story.createdAt ??
                                          ''),
                                  size: 14)
                              .horizontalPadded(),
                          TextWidget.manropeSemiBold(
                                  AppLocalizations.of(context)
                                          ?.story_detail_description ??
                                      '',
                                  size: 16)
                              .horizontalPadded()
                              .topPadded(),
                          TextWidget.manropeRegular(
                                  state.detailEntity?.story.description ?? '',
                                  size: 14)
                              .horizontalPadded()
                        ],
                      ),
                    )
                  : EmptyViewWidget(
                      title: AppLocalizations.of(context)
                              ?.story_detail_empty_label ??
                          '',
                      description: AppLocalizations.of(context)
                              ?.story_detail_empty_desc ??
                          '')));
    });
  }
}
