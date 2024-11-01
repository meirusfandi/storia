class LangConfig {
  final String langValue;

  static LangConfig? _instance;

  LangConfig({this.langValue = 'id'}) {
    _instance = this;
  }

  static LangConfig get instance => _instance ?? LangConfig();
}
