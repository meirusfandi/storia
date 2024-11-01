import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storia/core/config/flavor/flavor_config.dart';
import 'package:storia/core/helper/pref_helpers.dart';
import 'package:storia/main.dart';
import 'package:storia/core/resources/injection_container.dart' as injector;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefInstance = await SharedPreferences.getInstance();
  await injector.init();

  FlavorConfig(
    flavor: FlavorType.prod,
    color: Colors.blue,
    values: const FlavorValues(
      titleApp: "Storia Prod",
    ),
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}