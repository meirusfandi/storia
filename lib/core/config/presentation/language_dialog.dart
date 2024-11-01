import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storia/core/config/bloc/config_bloc.dart';
import 'package:storia/core/config/bloc/lang_config.dart';
import 'package:storia/core/config/model/language_response.dart';
import 'package:storia/core/resources/injection_container.dart';
import 'package:storia/core/utils/color_widget.dart';
import 'package:storia/core/utils/container_widget.dart';
import 'package:storia/core/utils/text_widget.dart';
import 'package:storia/core/utils/toast.dart';

class LanguageDialog extends StatefulWidget {
  final String lang;
  final Function(DataLanguage?) callback;
  const LanguageDialog({
    super.key,
    required this.lang,
    required this.callback,
  });

  @override
  State<LanguageDialog> createState() => LanguageDialogState();
}

class LanguageDialogState extends State<LanguageDialog> {
  DataLanguage? _onDataCheck;
  List<DataLanguage> data = [
    const DataLanguage(code: 'id', name: 'Bahasa Indonesia', sort: 1),
    const DataLanguage(code: 'en', name: 'English', sort: 2),
  ];

  Future<void> setSelectedLang() async {
    try {
      _onDataCheck ??=
          data.singleWhere((element) => element.code == widget.lang);
    } catch (e) {
      _onDataCheck = DataLanguage(code: LangConfig.instance.langValue);
    }
  }

  @override
  void initState() {
    setSelectedLang();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConfigBloc, ConfigState>(listener: (context, state) {
      if (!state.isLoading && state.onUpdateLang) {
        context.router.maybePop().then((_) => widget.callback(_onDataCheck));
      } else if (!state.isLoading && !state.onUpdateLang) {
        showError(context, "Terjadi Kesalahan, Silahkan coba kembali");
      }
    }, builder: (context, state) {
      return BottomDrawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (BuildContext ctx, int idx) => InkWell(
                      onTap: () => setState(() => _onDataCheck = data[idx]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: TextWidget.manropeRegular(
                                    data[idx].name ?? '',
                                    color: Colors.black,
                                    size: 14),
                              ),
                              (data[idx].code ?? '') ==
                                      (_onDataCheck?.code ?? '')
                                  ? const Icon(Icons.check)
                                  : const SizedBox()
                            ],
                          ).verticalPadded(10).horizontalPadded(),
                          const Divider()
                        ],
                      ),
                    )),
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  sl<ConfigBloc>().add(ChangeLanguageEvent(
                      newLocal: _onDataCheck?.code ?? 'id'));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      color: ColorWidget.primaryColor),
                  child: state.isLoading
                      ? const SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : TextWidget.manropeSemiBold(
                          "Simpan",
                          color: Colors.white,
                          size: 16,
                          textAlign: TextAlign.center,
                        ).padded(),
                ),
              ).bottomPadded(8),
            ).topPadded(),
          ],
        ),
      );
    });
  }
}
