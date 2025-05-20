import 'package:doc_o_doctor/constants/commonwidget.dart';
import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/constants/text_style_decoration.dart';
import 'package:doc_o_doctor/controller/help_and_support_controller.dart';
import 'package:doc_o_doctor/widgets/app_bar_widget.dart';
import 'package:doc_o_doctor/widgets/common_button.dart';
import 'package:doc_o_doctor/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HelpAndSupportController controller = HelpAndSupportController();

    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  appBarWidget(title: AppString.helpAndSupport),
                  SizedBox(height: 30.h),
                  CustomTextField(
                    controller: controller.nameController,
                    label: AppString.name,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Name is required";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 10.h),
                  FormField<String>(
                    validator: (value) {
                      if (controller.phoneController.text.trim().isEmpty) {
                        return "Mobile number is required";
                      }
                      if (controller.phoneController.text.length < 10) {
                        return "Enter a valid mobile number";
                      }
                      return null;
                    },
                    builder: (FormFieldState<String> field) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IntlPhoneField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            controller: controller.phoneController,
                            showDropdownIcon: true,
                            flagsButtonMargin: EdgeInsets.only(left: 10.w),
                            dropdownIconPosition: IconPosition.trailing,
                            dropdownIcon: Icon(Icons.keyboard_arrow_down),
                            showCountryFlag: false,
                            invalidNumberMessage: "",

                            cursorColor: AppColor.primaryColor,
                            decoration: InputDecoration(
                              hintText: AppString.enterMobileNo,
                              hintStyle: TextStyleDecoration.labelSmall
                                  .copyWith(
                                    color: Colors.grey,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                              contentPadding: EdgeInsets.only(left: 10),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide(
                                  color: AppColor.textFieldBorderColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide(
                                  color: AppColor.textFieldBorderColor,
                                ),
                              ),

                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide(
                                  color: AppColor.textFieldBorderColor,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide(
                                  color: AppColor.textFieldBorderColor,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                            ),
                            initialCountryCode: 'IN',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                            dropdownTextStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            onChanged: (phone) {
                              controller.countryCode.value = phone.countryCode;
                              field.didChange(phone.completeNumber);
                            },
                          ),
                          if (field.hasError)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                              ),
                              child: Text(
                                field.errorText ?? '',
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 177, 48, 39),
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  /* CustomTextField(
                    controller: controller.phoneController,
                    label: AppString.enterMobileNo,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    prefixIcon: Container(
                      width: 50.w,
                      margin: EdgeInsets.only(left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "+91",
                            style: TextStyleDecoration.labelMedium.copyWith(
                              color: AppColor.black,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Icon(Icons.keyboard_arrow_down_outlined),
                        ],
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty)
                        return "Phone is required";
                      if (!RegExp(r'^[0-9]{10}$').hasMatch(value))
                        return "Enter a valid 10-digit phone number";
                      return null;
                    },
                  ), */
                  /*  SizedBox(height: 10.h),
                  CustomTextField(
                    label: AppString.gender,
                    isDropdown: true,
                    dropdownItems: controller.genderOptions,
                    selectedDropdown: controller.selectedGender,
                    onDropdownChanged: (String? value) {
                      controller.selectedGender.value = value!;
                    },
                    validator: (value) =>
                        value == null ? "Select a Gender" : null,
                  ), */
                  SizedBox(height: 10.h),
                  CustomTextField(
                    label: AppString.selectWhichTypeOfProblem,
                    isDropdown: true,
                    dropdownItems: controller.problemOptions,
                    selectedDropdown: controller.selectedProblem,
                    onDropdownChanged: (String? value) {
                      controller.selectedProblem.value = value!;
                    },
                    validator:
                        (value) =>
                            value == null
                                ? AppString.selectWhichTypeOfProblem
                                : null,
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    controller: controller.problemController,
                    label: AppString.writeYourProblemHere,
                    maxLine: 10,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "This field is required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return Center(child: Commonwidget.commonLoader());
                    }

                    return commonButton(
                      text: AppString.submit,
                      onPressed: () {
                        controller.submitForm();
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
