import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storia/core/config/bloc/lang_config.dart';
import 'package:storia/core/helper/pref_helpers.dart';
import 'package:storia/core/helper/pref_key.dart';

part 'config_event.dart';
part 'config_state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  ConfigBloc() : super(ConfigState(local: prefHelpers.getAppLang ?? '')) {
    on<ChangeLanguageEvent>(_onChangeLanguage);
  }

  Future<void> _onChangeLanguage(
      ChangeLanguageEvent event, Emitter<ConfigState> emit) async {
    emit(state.copyWith(isLoading: true, onUpdateLang: false));
    await prefInstance.setString(PrefKey.appLang.name, event.newLocal);
    LangConfig(langValue: prefInstance.getString(PrefKey.appLang.name) ?? 'id');
    emit(state.copyWith(
        local: event.newLocal, onUpdateLang: true, isLoading: false));
  }
}
