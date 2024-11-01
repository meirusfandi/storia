part of 'config_bloc.dart';

abstract class ConfigEvent extends Equatable {
  const ConfigEvent();

  @override
  List<Object> get props => [];
}

class ChangeLanguageEvent extends ConfigEvent {
  final String newLocal;
  const ChangeLanguageEvent({required this.newLocal});
  @override
  List<Object> get props => [newLocal];
}

class UpdateLangToLocalEvent extends ConfigEvent {
  final String lang;
  const UpdateLangToLocalEvent({required this.lang});
  @override
  List<Object> get props => [lang];
}
