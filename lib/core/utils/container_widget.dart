import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class BottomDrawer extends StatelessWidget {
  final Widget child;

  final bool withBack;

  const BottomDrawer({
    super.key,
    required this.child,
    this.withBack = false,
  });

  @override
  Widget build(context) => withBack
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: _backButton(context),
            ),
            _main(),
          ],
        )
      : _main();

  Widget _main() => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white,
        ),
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
        child: child,
      );

  Widget _backButton(BuildContext ctx) => ElevatedButton(
        onPressed: () {
          if (ctx.router.canPop()) {
            ctx.popRoute();
          }
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          shape: const CircleBorder(),
        ),
        child: const Icon(Icons.arrow_back_ios),
      );
}

Future<void> showSheet(BuildContext ctx, Widget sheet,
    {bool isControlled = true}) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isDismissible: isControlled,
    builder: (ctx) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
      child: sheet,
    ),
    context: ctx,
    isScrollControlled: isControlled,
    useSafeArea: true,
    enableDrag: isControlled,
  );
}

extension PaddedWidget on Widget {
  Widget topPadded([final value = 16]) => Padding(
        padding: EdgeInsets.only(top: value.toDouble()),
        child: this,
      );

  Widget bottomPadded([final value = 16]) => Padding(
        padding: EdgeInsets.only(bottom: value.toDouble()),
        child: this,
      );

  Widget rightPadded([final value = 16]) => Padding(
        padding: EdgeInsets.only(right: value.toDouble()),
        child: this,
      );

  Widget leftPadded([final value = 16]) => Padding(
        padding: EdgeInsets.only(left: value.toDouble()),
        child: this,
      );

  Widget horizontalPadded([final value = 16]) => Padding(
        padding: EdgeInsets.symmetric(horizontal: value.toDouble()),
        child: this,
      );

  Widget verticalPadded([final value = 16]) => Padding(
        padding: EdgeInsets.symmetric(vertical: value.toDouble()),
        child: this,
      );

  Widget padded([final value = 16]) => Padding(
        padding: EdgeInsets.all(value.toDouble()),
        child: this,
      );
}
