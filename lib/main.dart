import 'package:alice/alice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storia/core/config/bloc/config_bloc.dart';
import 'package:storia/core/config/flavor/flavor_config.dart';
import 'package:storia/core/helper/pref_helpers.dart';
import 'package:storia/core/helper/pref_key.dart';
import 'package:storia/core/resources/injection_container.dart';
import 'package:storia/core/routes/router.dart';
import 'package:storia/core/resources/injection_container.dart' as injector;
import 'package:storia/presentation/bloc/form_story_bloc.dart';
import 'package:storia/presentation/bloc/login_bloc.dart';
import 'package:storia/presentation/bloc/register_bloc.dart';
import 'package:storia/presentation/bloc/story_detail_bloc.dart';
import 'package:storia/presentation/bloc/story_list_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefInstance = await SharedPreferences.getInstance();
  await injector.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();

  @override
  void initState() {
    if (prefHelpers.getAppLang == null) {
      prefInstance.setString(PrefKey.appLang.name, "id");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sl<ConfigBloc>()
        .add(ChangeLanguageEvent(newLocal: prefHelpers.getAppLang ?? 'id'));
    return BlocProvider<ConfigBloc>(
      create: (ctx) => injector.sl<ConfigBloc>(),
      child: KeyboardDismisser(
        child: BlocBuilder<ConfigBloc, ConfigState>(builder: (ctx, state) {
          return _main(ctx, Locale(state.local == '' ? 'id' : state.local));
        }),
      ),
    );
  }

  Widget _main(BuildContext ctx, Locale locale) {
    var app = AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark),
      child: ScreenUtilInit(
        useInheritedMediaQuery: true,
        builder: (context, child) => MaterialApp.router(
            debugShowCheckedModeBanner: FlavorConfig.instance.flavor == FlavorType.dev,
            locale: locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            routerConfig: _appRouter.config(),
            theme: ThemeData(fontFamily: GoogleFonts.manrope().fontFamily),
            supportedLocales: const [
              Locale('en'), // English
              Locale('id'), // Indonesia
            ]),
      ),
    );
    var alice = injector.sl<Alice>();
    alice.setNavigatorKey(_appRouter.navigatorKey);
    return MultiBlocProvider(providers: [
      BlocProvider<LoginBloc>(
          create: (BuildContext context) => sl<LoginBloc>()),
      BlocProvider<RegisterBloc>(
          create: (BuildContext context) => sl<RegisterBloc>()),
      BlocProvider<FormStoryBloc>(
          create: (BuildContext context) => sl<FormStoryBloc>()),
      BlocProvider<StoryListBloc>(
          create: (BuildContext context) => sl<StoryListBloc>()),
      BlocProvider<StoryDetailBloc>(
          create: (BuildContext context) => sl<StoryDetailBloc>()),
    ], child: app);
  }
}
