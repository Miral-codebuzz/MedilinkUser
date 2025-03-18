import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget imageIconButton({
  required String image,
  void Function()? onTap,
  double? height,
  double? width,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Image.asset(image, height: height ?? 24.h, width: width ?? 24.w),
  );
}
