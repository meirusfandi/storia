import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  LatLng jakartaMaps = const LatLng(-6.1835423,106.8369984);
  late GoogleMapController mapController;
  final Set<Marker> markers = {};
  MapType selectedMapType = MapType.normal;
  String address = "";
  final DraggableScrollableController sheetController = DraggableScrollableController();

  @override
  void initState() {
    sl<StoryDetailBloc>().add(DetailEvent(storyId: widget.storyId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoryDetailBloc, StoryDetailState>(
      listener: (context, state) {
        if (!state.isLoading && state.detailEntity != null) {
          if (state.detailEntity?.story.lat != 0.0 && state.detailEntity?.story.lon != 0.0) {
            jakartaMaps = LatLng(state.detailEntity?.story.lat ?? 0.0 , state.detailEntity?.story.lon ?? 0.0);
            final marker = Marker(
              markerId: MarkerId(widget.storyId),
              position: LatLng(state.detailEntity?.story.lat ?? 0.0 , state.detailEntity?.story.lon ?? 0.0),
              onTap: () async {
                log('test click');
              },
            );
            markers.add(marker);
            mapController.animateCamera(
              CameraUpdate.newLatLng(jakartaMaps)
            );
          }
        }
      },
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
                  ? Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: GoogleMap(
                          myLocationButtonEnabled: false,
                          zoomControlsEnabled: false,
                          mapToolbarEnabled: false,
                          markers: markers,
                          initialCameraPosition: CameraPosition(
                            zoom: 12,
                            target: jakartaMaps,
                          ),
                          mapType: selectedMapType,
                          onMapCreated: (controller) {
                            mapController = controller;
                          },
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: 16,
                        child: Column(
                          children: [
                            FloatingActionButton.small(
                              onPressed: null,
                              child: PopupMenuButton<MapType>(
                                onSelected: (MapType item) {
                                  setState(() {
                                    selectedMapType = item;
                                  });
                                },
                                offset: const Offset(0, 54),
                                icon: const Icon(Icons.layers_outlined),
                                itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<MapType>>[
                                  const PopupMenuItem<MapType>(
                                    value: MapType.normal,
                                    child: Text('Normal'),
                                  ),
                                  const PopupMenuItem<MapType>(
                                    value: MapType.satellite,
                                    child: Text('Satellite'),
                                  ),
                                  const PopupMenuItem<MapType>(
                                    value: MapType.terrain,
                                    child: Text('Terrain'),
                                  ),
                                  const PopupMenuItem<MapType>(
                                    value: MapType.hybrid,
                                    child: Text('Hybrid'),
                                  ),
                                ],
                              ),
                            ),
                            FloatingActionButton.small(
                              heroTag: "zoom-in",
                              onPressed: () {
                                mapController.animateCamera(
                                  CameraUpdate.zoomIn(),
                                );
                              },
                              child: const Icon(Icons.add),
                            ),
                            FloatingActionButton.small(
                              heroTag: "zoom-out",
                              onPressed: () {
                                mapController.animateCamera(
                                  CameraUpdate.zoomOut(),
                                );
                              },
                              child: const Icon(Icons.remove),
                            ),
                          ],
                        ),
                      ),
                      if (state.detailEntity?.story.lat == 0.0 && state.detailEntity?.story.lon == 0.0) Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(32)),
                              color: ColorWidget.lightPrimaryColor
                            ),
                            child: TextWidget.manropeRegular(AppLocalizations.of(context)?.general_no_maps ?? '').padded(),
                          ).padded(),
                        )
                      ),
                      DraggableScrollableSheet(
                        controller: sheetController,
                        builder: (BuildContext context, scrollController) {
                          return Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: Theme.of(context).canvasColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                            ),
                            child: CustomScrollView(
                              controller: scrollController,
                              slivers: [
                                SliverToBoxAdapter(
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).hintColor,
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      ),
                                      height: 4,
                                      width: 40,
                                    ).padded(),
                                  ),
                                ),
                                SliverList.list(children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                                    child: CachedNetworkImage(
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.fill,
                                      imageUrl: state.detailEntity?.story.photoUrl ?? '',
                                      placeholder: (context, url) => const SizedBox(
                                          width: 48,
                                          height: 48,
                                          child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                    ).padded(),
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
                                  TextWidget.manropeRegular(
                                      address,
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
                                      .horizontalPadded(),
                                ])
                              ],
                            ),
                          );
                        },
                      ),
                    ],
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
