import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/constants/text_style_decoration.dart';
import 'package:doc_o_doctor/controller/about_yourself_controller.dart';
import 'package:doc_o_doctor/screens/medical_condition_screen/medical_condition_screen.dart';
import 'package:doc_o_doctor/widgets/common_button.dart';
import 'package:doc_o_doctor/widgets/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AboutYourselfScreen extends StatefulWidget {
  const AboutYourselfScreen({super.key});

  @override
  State<AboutYourselfScreen> createState() => _AboutYourselfScreenState();
}

class _AboutYourselfScreenState extends State<AboutYourselfScreen> {
  final AboutYourselfController controller = Get.put(AboutYourselfController());
  final TextEditingController dobController = TextEditingController();
  String? selectedGender;
  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Center(
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
              Obx(
                () => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      CommonTextfield(
                        hintText: AppString.name,
                        onChanged: (p0) {
                          controller.name.value = p0;
                        },
                        errorText:
                            controller.name.value.isEmpty
                                ? "Name is required"
                                : null,
                      ),
                      // _buildDropdownField(),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColor.lightGrey,
                          errorText:
                              controller.selectedGender.value == null
                                  ? "Gender is required"
                                  : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColor.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: AppColor.textFieldBorderColor,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: AppColor.textFieldBorderColor,
                              width: 1,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: AppColor.textFieldBorderColor,
                              width: 1,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: AppColor.textFieldBorderColor,
                              width: 1,
                            ),
                          ),
                        ),

                        hint: Text(
                          "Gender",
                          style: TextStyleDecoration.labelSmall.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColor.grey,
                          ),
                        ),
                        value: controller.selectedGender.value,
                        onChanged:
                            (value) => controller.selectedGender.value = value,
                        items:
                            genderOptions.map((gender) {
                              return DropdownMenuItem(
                                value: gender,
                                child: Text(
                                  gender,
                                  style: TextStyleDecoration.labelSmall
                                      .copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.black,
                                      ),
                                ),
                              );
                            }).toList(),
                      ),
                      SizedBox(height: 10.h),
                      CommonTextfield(
                        controller: dobController,
                        hintText: AppString.dateOfBirth,
                        isShowSuffixIcon: AppImage.calender,
                        readOnly: true,
                        suffixIconOnTap: () {
                          _selectDate(context);
                        },
                        onChanged: (p0) {
                          controller.dob.value = p0;
                        },
                        errorText:
                            controller.dob.value.isEmpty
                                ? "Date of Birth is required"
                                : null,
                      ),
                      CommonTextfield(
                        hintText: AppString.streetAddress,
                        onChanged: (p0) {
                          controller.streetAddress.value = p0;
                        },
                        errorText:
                            controller.streetAddress.value.isEmpty
                                ? "Street Address is required"
                                : null,
                      ),
                      CommonTextfield(
                        hintText: AppString.city,
                        onChanged: (p0) {
                          controller.city.value = p0;
                        },
                        errorText:
                            controller.city.value.isEmpty
                                ? "City is required"
                                : null,
                      ),
                      CommonTextfield(
                        hintText: AppString.country,
                        onChanged: (p0) {
                          controller.country.value = p0;
                        },
                        errorText:
                            controller.country.value.isEmpty
                                ? "Country is required"
                                : null,
                      ),
                    ],
                  ),
                ),
              ),
              commonButton(
                onPressed: () {
                  if (controller.validateForm()) {
                    Get.to(() => MedicalConditionScreen());
                    /*  Get.snackbar(
                      "Success",
                      "Form Submitted Successfully",
                      snackPosition: SnackPosition.BOTTOM,
                    ); */
                  } else {
                    /* Get.snackbar(
                      "Error",
                      "Please fill all fields",
                      snackPosition: SnackPosition.BOTTOM,
                    ); */
                  }
                },
                text: AppString.next,
                width: 325.w,
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  /* Widget _buildDropdownField() {
    return Obx(
      () => DropdownButtonFormField<String>(
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColor.lightGrey,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColor.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColor.textFieldBorderColor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColor.textFieldBorderColor,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColor.textFieldBorderColor,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColor.textFieldBorderColor,
              width: 1,
            ),
          ),
        ),

        hint: Text(
          "Gender",
          style: TextStyleDecoration.labelSmall.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.grey,
          ),
        ),
        value: controller.selectedGender.value,
        onChanged: (value) => controller.selectedGender.value = value,
        items:
            genderOptions.map((gender) {
              return DropdownMenuItem(
                value: gender,
                child: Text(
                  gender,
                  style: TextStyleDecoration.labelSmall.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColor.black,
                  ),
                ),
              );
            }).toList(),
      ),
    );
  } */

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dobController.text = DateFormat('dd/MM/yyyy').format(picked);
      controller.dob.value = dobController.text;
    }
  }
}
