import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/constants/text_style_decoration.dart';
import 'package:doc_o_doctor/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:doc_o_doctor/widgets/common_button.dart';
import 'package:doc_o_doctor/widgets/common_textfield.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:widgets_easier/widgets_easier.dart';

import '../../controller/medical_condition_controller.dart';

class MedicalConditionScreen extends StatelessWidget {
  final MedicalConditionController controller = Get.put(
    MedicalConditionController(),
  );

  MedicalConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 70.h),
                Image.asset(AppImage.logoBlue, height: 150.h, width: 150.w),
                SizedBox(height: 30.h),
                Text(
                  AppString.medicalCondition,
                  style: TextStyleDecoration.labelSmall.copyWith(
                    fontSize: 20.sp,
                    color: AppColor.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  AppString.tellUsAboutYourMedicalConditions,
                  textAlign: TextAlign.center,
                  style: TextStyleDecoration.labelSmall.copyWith(
                    fontSize: 14.sp,
                    color: AppColor.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20.h),
                insuranceTitleRow(
                  title: "Have You Any Medical Insurance? ",
                  subTitle: "Add",
                  onTap: () {
                    // controller.showMadicalInstsurance();
                  },
                ),
                SizedBox(height: 5.h),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 2,
                  dashLength: 6.0,
                  dashColor: AppColor.lightGrey,
                ),
                SizedBox(height: 10.h),
                uploadInsurance(),
                SizedBox(height: 10.h),
                insuranceTitleRow(
                  title: "Have You Any Past Medical Report ? ",
                  subTitle: "Add",
                  onTap: () {},
                ),
                SizedBox(height: 5.h),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 2,
                  dashLength: 6.0,
                  dashColor: AppColor.lightGrey,
                ),
                SizedBox(height: 10.h),
                uploadInsurance(),
                SizedBox(height: 10.h),
                CommonTextfield(
                  hintText: 'Describe Your Medical Problem',
                  maxLines: 5,
                ),
                SizedBox(height: 10.h),
                commonButton(
                  text: AppString.next,
                  onPressed: () {
                    Get.to(() => BottomNavBar());
                  },
                ),
                SizedBox(height: 10.h),
                Text(
                  "Skip For Now ",
                  style: TextStyleDecoration.labelSmall.copyWith(
                    fontSize: 16.sp,
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  uploadInsurance() {
    return Container(
      // height: 150,
      // width: 300,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: ShapeDecoration(
        shape: DashedBorder(
          borderRadius: BorderRadius.circular(8),
          color: AppColor.lightGrey,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColor.lightGrey, width: 1.5),
              // color: Colors.grey.withOpacity(0.2),
            ),
            child: Image.asset(AppImage.upload, width: 18.w),
            /* child: Icon(
              Icons.cloud_upload_outlined,
              color: Colors.black54,
              size: 24.sp,
            ), */
          ),
          SizedBox(width: 10.w),
          GestureDetector(
            onTap: () {},
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Click to upload",
                    style: TextStyleDecoration.labelSmall.copyWith(
                      color: AppColor.primaryColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: " Insurance",
                    style: TextStyleDecoration.labelSmall.copyWith(
                      color: AppColor.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  insuranceTitleRow({
    required String title,
    required String subTitle,
    required void Function()? onTap,
  }) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyleDecoration.labelSmall.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.black,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            subTitle,
            style: TextStyleDecoration.labelSmall.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColor.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
