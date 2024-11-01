import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
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
  String imagePath = "";

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
            bottomNavigationBar: SizedBox(
                width: double.infinity,
                child: GenericButton(
                  text: AppLocalizations.of(context)?.story_form_button ?? '',
                  onTap: () {
                    sl<FormStoryBloc>().add(FormEvent(
                      photo: imagePath,
                      description: _descriptionController.text.trim(),
                      lat: 0.0,
                      lon: 0.0,
                    ));
                  },
                  isDisable: true,
                ).padded()),
            child: SafeArea(
                child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width - 32,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: ColorWidget.accentPrimaryColor),
                      child: (imagePath.isNotEmpty)
                          ? Image.file(File(imagePath.toString()),
                              fit: BoxFit.fill)
                          : const Icon(Icons.image, size: 200),
                    ).padded(),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: GenericButton(
                                text: AppLocalizations.of(context)
                                        ?.story_form_camera ??
                                    '',
                                onTap: () => _onCameraView()),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: GenericButton(
                                text: AppLocalizations.of(context)
                                        ?.story_form_gallery ??
                                    '',
                                onTap: () => _onGalleryView()),
                          ),
                        ],
                      ),
                    ).padded(),
                    GenericTextField(
                      labelText:
                          AppLocalizations.of(context)?.story_form_input_desc ??
                              '',
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
                    ).horizontalPadded()
                  ],
                ),
              ),
            )));
      },
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
