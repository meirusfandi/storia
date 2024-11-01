import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storia/core/utils/color_widget.dart';
import 'package:storia/core/utils/container_widget.dart';
import 'package:storia/core/utils/text_widget.dart';

class GenericTextField extends StatefulWidget {
  final String labelText;
  final bool useLabelBold;
  final String hintText;
  final String? descriptionLabel;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Function(String?) onChanged;
  final void Function()? tapAction;
  final bool disableLabel;
  final TextInputType? keyboardType;
  final bool isDisableForm;
  final bool obSecureText;
  final String unitMeasurement;
  final Widget? suffixIcon;
  final double radiusCircular;
  final TextStyle? hintStyle;
  final int? maxLine;
  final bool? isUseCounterText;

  const GenericTextField(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.controller,
      required this.onChanged,
      this.inputFormatters,
      this.validator,
      this.descriptionLabel,
      this.tapAction,
      this.useLabelBold = false,
      this.disableLabel = false,
      this.obSecureText = false,
      this.radiusCircular = 8.0,
      this.hintStyle,
      this.maxLine,
      this.keyboardType,
      this.isDisableForm = false,
      this.unitMeasurement = '',
      this.suffixIcon,
      this.isUseCounterText = true});

  @override
  State<GenericTextField> createState() => _GenericTextFieldState();
}

class _GenericTextFieldState extends State<GenericTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.disableLabel)
          widget.useLabelBold
              ? TextWidget.manropeBold(widget.labelText,
                      size: 18, textAlign: TextAlign.start)
                  .bottomPadded(6)
              : TextWidget.manropeRegular(widget.labelText,
                      size: 18, textAlign: TextAlign.start)
                  .bottomPadded(6),
        TextFormField(
          obscureText: widget.obSecureText,
          readOnly: widget.isDisableForm ? true : false,
          onTap: widget.tapAction,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.words,
          onChanged: widget.onChanged,
          controller: widget.controller,
          maxLength: widget.maxLine,
          validator: widget.validator,
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            counterText: (widget.isUseCounterText ?? false) ? null : '',
            contentPadding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
            focusColor: ColorWidget.textSecondaryColor,
            isDense: true,
            border: _border(),
            focusedBorder: _border(),
            disabledBorder: _border(),
            enabledBorder: _border(),
            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
            errorStyle: GoogleFonts.manrope(
                fontSize: 12,
                color: ColorWidget.textSecondaryColor,
                fontWeight: FontWeight.w400),
            suffixIcon: widget.suffixIcon ?? const Icon(Icons.search),
          ),
        ),
      ],
    );
  }

  InputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: ColorWidget.accentPrimaryColor),
    );
  }
}
