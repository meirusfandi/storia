import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:storia/core/helper/pref_helpers.dart';
import 'package:storia/core/routes/router.dart';
import 'package:storia/core/utils/container_widget.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this)
      ..forward()
      ..addStatusListener((_) async {
        await initialProcess();
      });
  }

  Future<void> initialProcess() async {
    final token = prefHelpers.getAccessToken;

    if (token != null) {
      context.router.replaceAll([const StoryRoute()]);
    } else {
      context.router.replaceAll([const LoginRoute()]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                child: Image.asset('assets/img_logo.png',
                    height: 128, width: 128)),
            const CircularProgressIndicator().topPadded(24),
          ],
        ),
      )),
    );
  }
}
