import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/text_style_decoration.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final String? fontFamilty;
  final int? maxLine;
  final TextAlign? textAlignment;
  const CustomText({
    super.key,
    required this.text,
    this.textColor,
    this.fontWeight,
    this.fontSize,
    this.fontFamilty,
    this.maxLine,
    this.textAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlignment ?? TextAlign.center,
      maxLines: maxLine ?? 1,

      style: TextStyleDecoration.labelLarge.copyWith(
        color: textColor ?? AppColor.textGrey,
        fontSize: fontSize ?? 24,
        fontWeight: fontWeight ?? FontWeight.w500,
        fontFamily: fontFamilty ?? '',
      ),
    );
  }
}
