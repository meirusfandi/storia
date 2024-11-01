import 'package:flutter/material.dart';
import 'package:storia/core/utils/container_widget.dart';
import 'package:storia/core/utils/text_widget.dart';

Future<void> showError(BuildContext context, String message) async {
  await showGenericSnackBar(context, message, Icons.cancel, Colors.red);
}

Future<void> showSuccess(BuildContext context, String message) async {
  await showGenericSnackBar(context, message, Icons.check_circle, Colors.blue);
}

Future<void> showWarning(BuildContext context, String message) async {
  await showGenericSnackBar(context, message, Icons.error, Colors.yellow);
}

Future<void> showGenericSnackBar(BuildContext context, String message,
    IconData iconData, Color backgroundColor) async {
  OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (BuildContext context) => Positioned(
      top: kToolbarHeight,
      left: 24,
      right: 24,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                iconData,
                color: Colors.white,
              ).rightPadded(8),
              Flexible(
                child: TextWidget.manropeRegular(message,
                    size: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    ),
  );
  Overlay.of(context).insert(overlayEntry);

  await Future.delayed(const Duration(seconds: 2));

  overlayEntry.remove();
}
