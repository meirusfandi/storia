import 'package:shared_preferences/shared_preferences.dart';
import 'package:storia/core/helper/pref_key.dart';

late final SharedPreferences prefInstance;

class PrefHelpers {
  String? get getAppLang => prefInstance.getString(PrefKey.appLang.name);
  bool? get getFirstAccess => prefInstance.getBool(PrefKey.isFirstAccess.name);
  String? get getAccessToken => prefInstance.getString(PrefKey.token.name);
  String? get getUserId => prefInstance.getString(PrefKey.userId.name);
  String? get getUserName => prefInstance.getString(PrefKey.userName.name);

  void get clearData {
    prefInstance.remove(PrefKey.appLang.name);
    prefInstance.remove(PrefKey.isFirstAccess.name);
    prefInstance.remove(PrefKey.token.name);
    prefInstance.remove(PrefKey.userName.name);
    prefInstance.remove(PrefKey.userId.name);
  }
}

final prefHelpers = PrefHelpers();
