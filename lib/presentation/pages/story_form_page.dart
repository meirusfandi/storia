import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:storia/core/resources/injection_container.dart';
import 'package:storia/core/routes/router.dart';
import 'package:storia/core/utils/color_widget.dart';
import 'package:storia/core/utils/container_widget.dart';
import 'package:storia/core/utils/generic_text_field.dart';
import 'package:storia/core/utils/text_widget.dart';
import 'package:storia/presentation/bloc/form_story_bloc.dart';
import 'package:storia/presentation/bloc/story_list_bloc.dart';
import 'package:storia/presentation/widgets/generic_button.dart';
import 'package:storia/presentation/widgets/page_template.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class StoryFormPage extends StatefulWidget {
  const StoryFormPage({super.key});

  @override
  State<StatefulWidget> createState() => _StoryFormPageState();
}

class _StoryFormPageState extends State<StoryFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  String imagePath = "";
  LatLng jakartaMaps = const LatLng(-6.1835423, 106.8369984);
  late GoogleMapController mapController;
  final Set<Marker> markers = {};
  MapType selectedMapType = MapType.normal;
  final DraggableScrollableController sheetController =
      DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormStoryBloc, FormStoryState>(
      listener: (context, state) {
        if (!state.isLoading && state.addStoryEntity?.error == false) {
          sl<StoryListBloc>()
              .add(const ListEvent(page: 1, size: 10, location: 0));
          context.router.popAndPush(const StoryRoute());
        }
      },
      builder: (context, state) {
        return PageTemplate(
            appBar: AppBar(
              title: TextWidget.manropeSemiBold(
                  AppLocalizations.of(context)?.story_form_title ?? '',
                  size: 18,
                  color: ColorWidget.iconPrimaryColor),
              backgroundColor: ColorWidget.primaryColor,
            ),
            loading: state.isLoading,
            child: SafeArea(
                child: Stack(
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
                    onTap: (position) {
                      defineMarker(position);

                      mapController.animateCamera(
                        CameraUpdate.newLatLng(position),
                      );
                    },
                    mapType: selectedMapType,
                    onMapCreated: (controller) {
                      final marker = Marker(
                        markerId: const MarkerId("form"),
                        position: jakartaMaps,
                        onTap: () async {},
                      );
                      setState(() {
                        mapController = controller;
                        mapController
                            .animateCamera(CameraUpdate.newLatLng(jakartaMaps));
                        markers.add(marker);
                      });
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
                      FloatingActionButton(
                          child: const Icon(Icons.my_location),
                          onPressed: () => onMyLocationButtonPress()),
                    ],
                  ),
                ),
                DraggableScrollableSheet(
                  controller: sheetController,
                  maxChildSize: 0.8,
                  initialChildSize: 0.1,
                  minChildSize: 0.1,
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                height: 4,
                                width: 40,
                              ).padded(),
                            ),
                          ),
                          SliverAppBar(
                            title: TextWidget.manropeSemiBold(
                                "Form Tambah Cerita"),
                          ),
                          SliverList.list(children: [_formData()])
                        ],
                      ),
                    );
                  },
                ),
              ],
            )));
      },
    );
  }

  void onMyLocationButtonPress() async {
    final Location location = Location();
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;
    late LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        if (kDebugMode) {
          print("Location services is not available");
        }
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        if (kDebugMode) {
          print("Location permission is denied");
        }
        return;
      }
    }

    locationData = await location.getLocation();
    final latLng = LatLng(locationData.latitude!, locationData.longitude!);

    defineMarker(latLng);

    mapController.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }

  void defineMarker(LatLng latLng) {
    final marker = Marker(
      markerId: const MarkerId("myLocation"),
      position: latLng,
    );
    setState(() {
      markers.clear();
      markers.add(marker);
      _latitudeController.text = latLng.latitude.toString();
      _longitudeController.text = latLng.longitude.toString();
    });
  }

  Widget _formData() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.width / 3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: ColorWidget.accentPrimaryColor),
            child: (imagePath.isNotEmpty)
                ? Image.file(File(imagePath.toString()), fit: BoxFit.fill)
                : const Icon(Icons.image, size: 100),
          ).padded(),
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: GenericButton(
                      text:
                          AppLocalizations.of(context)?.story_form_camera ?? '',
                      onTap: () => _onCameraView()),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GenericButton(
                      text: AppLocalizations.of(context)?.story_form_gallery ??
                          '',
                      onTap: () => _onGalleryView()),
                ),
              ],
            ),
          ).padded(),
          GenericTextField(
            labelText:
                AppLocalizations.of(context)?.story_form_input_desc ?? '',
            hintText: AppLocalizations.of(context)
                    ?.story_form_input_desc_placeholder ??
                '',
            controller: _descriptionController,
            onChanged: (_) {
              setState(() {});
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)
                        ?.story_form_input_desc_error ??
                    '';
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.multiline,
            suffixIcon: const SizedBox(),
          ).horizontalPadded(),
          Row(
            children: [
              Expanded(
                child: GenericTextField(
                  labelText:
                      AppLocalizations.of(context)?.general_latitude ?? '',
                  hintText:
                      AppLocalizations.of(context)?.general_latitude ?? '',
                  controller: _latitudeController,
                  onChanged: (_) {
                    setState(() {});
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)
                              ?.story_form_input_desc_error ??
                          '';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.multiline,
                  suffixIcon: const SizedBox(),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GenericTextField(
                  labelText:
                      AppLocalizations.of(context)?.general_longitude ?? '',
                  hintText:
                      AppLocalizations.of(context)?.general_longitude ?? '',
                  controller: _longitudeController,
                  onChanged: (_) {
                    setState(() {});
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)
                              ?.story_form_input_desc_error ??
                          '';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.multiline,
                  suffixIcon: const SizedBox(),
                ),
              )
            ],
          ).padded(),
          SizedBox(
              width: double.infinity,
              child: GenericButton(
                text: AppLocalizations.of(context)?.story_form_button ?? '',
                onTap: () {
                  sl<FormStoryBloc>().add(FormEvent(
                    photo: imagePath,
                    description: _descriptionController.text.trim(),
                    lat: double.tryParse(_latitudeController.text) ?? 0.0,
                    lon: double.tryParse(_longitudeController.text) ?? 0.0,
                  ));
                },
                isDisable: true,
              ).padded()),
        ],
      ),
    );
  }

  _onCameraView() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  _onGalleryView() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }
}
