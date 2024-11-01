import 'package:flutter/material.dart';
import 'package:storia/core/utils/color_widget.dart';
import 'package:storia/core/utils/container_widget.dart';
import 'package:storia/core/utils/text_widget.dart';

class EmptyViewWidget extends StatelessWidget {
  final String title;
  final String description;

  const EmptyViewWidget(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/empty_data.png',
            width: 100,
            height: 100,
          ),
          TextWidget.manropeSemiBold(title,
                  textAlign: TextAlign.center,
                  size: 18,
                  color: ColorWidget.textPrimaryColor)
              .horizontalPadded(),
          TextWidget.manropeLight(description,
                  textAlign: TextAlign.center,
                  size: 14,
                  color: ColorWidget.textSecondaryColor)
              .horizontalPadded()
              .topPadded(8),
        ],
      ),
    );
  }
}
