import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/widgets/custom_text.dart';
import 'package:doc_o_doctor/widgets/image_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget appBarWidget({
  required String title,
  void Function()? onTapBackIcon,
  bool? showBackIcon = true,
}) {
  return SizedBox(
    height: 25.h,
    child: Row(
      children: [
        showBackIcon == true
            ? imageIconButton(
              image: AppImage.backArrowIcon,
              onTap: onTapBackIcon ?? () => Get.back(),
            )
            : SizedBox(height: 24, width: 24),
        Spacer(),
        CustomText(
          text: title,
          textColor: AppColor.black,
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
        Spacer(),
        SizedBox(height: 24.h, width: 24.w),
      ],
    ),
  );
}
