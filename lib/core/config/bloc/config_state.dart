part of 'config_bloc.dart';

class ConfigState extends Equatable {
  final String local;
  final bool onUpdateLang;
  final bool isLoading;
  const ConfigState(
      {this.onUpdateLang = false, this.isLoading = false, required this.local});

  @override
  List<Object?> get props => [local, onUpdateLang, isLoading];

  ConfigState copyWith({
    String? local,
    bool? onUpdateLang,
    bool? isLoading,
  }) {
    return ConfigState(
      local: local ?? this.local,
      onUpdateLang: onUpdateLang ?? this.onUpdateLang,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
