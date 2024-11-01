import 'package:flutter/material.dart';
import 'package:storia/core/utils/color_widget.dart';
import 'package:storia/core/utils/container_widget.dart';
import 'package:storia/core/utils/text_widget.dart';

class GenericButton extends StatelessWidget {
  final String text;
  final bool isDisable;
  final Function()? onTap;

  const GenericButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.isDisable = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              color: !isDisable
                  ? ColorWidget.lightPrimaryColor
                  : ColorWidget.primaryColor),
          child: TextWidget.manropeSemiBold(text,
                  textAlign: TextAlign.center,
                  size: 24,
                  color: !isDisable
                      ? ColorWidget.darkPrimaryColor
                      : ColorWidget.iconPrimaryColor)
              .padded(),
        ),
      ),
    );
  }
}
