import 'package:doc_o_doctor/constants/%20commonwidget.dart';
import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/constants/text_style_decoration.dart';
import 'package:doc_o_doctor/controller/about_yourself_controller.dart';
import 'package:doc_o_doctor/widgets/common_button.dart';
import 'package:doc_o_doctor/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AboutYourselfScreen extends StatelessWidget {
  const AboutYourselfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AboutYourselfController controller = Get.put(
      AboutYourselfController(),
    );
    return Scaffold(
      backgroundColor: AppColor.white,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: Commonwidget.commonLoader());
          }
          return commonButton(
            onPressed: () {
              controller.submitForm(context);
            },
            text: AppString.next,
            width: 325.w,
          );
        }),
      ),
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 70.h),
                  Image.asset(AppImage.logoBlue, height: 150.h, width: 150.w),
                  SizedBox(height: 30.h),
                  Text(
                    AppString.tellUsAboutYourself,
                    textAlign: TextAlign.center,
                    style: TextStyleDecoration.labelSmall.copyWith(
                      fontSize: 20.sp,
                      color: AppColor.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    AppString.aboutYourSelf,
                    textAlign: TextAlign.center,
                    style: TextStyleDecoration.labelSmall.copyWith(
                      fontSize: 14.sp,
                      color: AppColor.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  CustomTextField(
                    controller: controller.nameController,
                    label: AppString.name,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty)
                        return "Name is required";
                      return null;
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    label: AppString.gender,
                    isDropdown: true,
                    readOnly: true,
                    dropdownItems: controller.genderOptions,
                    selectedDropdown: controller.selectedGender,
                    onDropdownChanged: (String? value) {
                      controller.selectedGender.value = value!;
                    },
                    validator:
                        (value) => value == null ? "Select a Gender" : null,
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    controller: controller.dobController,
                    label: AppString.dateOfBirth,
                    suffixIcon: AppImage.calender,
                    readOnly: true,
                    onChanged: (p0) {
                      controller.dob.value = p0;
                    },
                    suffixIconOnTap: () {
                      controller.selectDate(context);
                    },
                    validator: (value) {
                      if (value == '') return "Date of Birth is required";
                      return null;
                    },
                  ),

                  SizedBox(height: 10.h),
                  CustomTextField(
                    controller: controller.streetAddress,
                    label: AppString.streetAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty)
                        return "Street Name is required";
                      return null;
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    controller: controller.cityController,
                    label: AppString.city,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty)
                        return "City is required";
                      return null;
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    controller: controller.countryController,
                    label: AppString.country,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty)
                        return "Country is required";
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
