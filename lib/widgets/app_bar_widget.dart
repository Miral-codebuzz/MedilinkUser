import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/text_style_decoration.dart';
import 'package:doc_o_doctor/widgets/custom_text.dart';
import 'package:doc_o_doctor/widgets/image_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

Widget appBarWidget({required String title, void Function()? onTapBackIcon}) {
  return SizedBox(
    height: 25.h,
    child: Row(
      children: [
        imageIconButton(
          image: AppImage.backArrowIcon,
          onTap: onTapBackIcon ?? () => Get.back(),
        ),
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
