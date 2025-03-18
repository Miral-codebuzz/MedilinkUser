import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/text_style_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget commonButton({
  required String text,
  required Function() onPressed,
  Color? bgColor,
  Color? textColor,
  double? width,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: bgColor ?? AppColor.primaryColor,
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      minimumSize: Size(width ?? double.infinity, 45.h),
    ),
    child: Text(
      text,
      style: TextStyleDecoration.labelSmall.copyWith(
        fontSize: 16,
        color: textColor ?? AppColor.white,
      ),
    ),
  );
}

Widget socialLoginButton({
  required String btnText,
  required String image,
  required Function() onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 45.h,
      width: 267.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, width: 20.w),
          SizedBox(width: 20.w),
          Text(
            btnText,
            style: TextStyleDecoration.labelSmall.copyWith(
              color: AppColor.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}
