import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/constants/text_style_decoration.dart';
import 'package:doc_o_doctor/controller/help_and_support_controller.dart';
import 'package:doc_o_doctor/widgets/app_bar_widget.dart';
import 'package:doc_o_doctor/widgets/common_button.dart';
import 'package:doc_o_doctor/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                      if (value == null || value.trim().isEmpty)
                        return "Name is required";
                      return null;
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    controller: controller.ageController,
                    keyboardType: TextInputType.numberWithOptions(),
                    label: AppString.age,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty)
                        return "Age is required";
                      int? age = int.tryParse(value);
                      if (age == null || age < 1 || age > 120)
                        return "Enter a valid age (1-120)";
                      return null;
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
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
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    label: AppString.gender,
                    isDropdown: true,
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
                    controller: controller.problemController,
                    label: AppString.writeYourProblemHere,
                    maxLine: 10,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty)
                        return "This field is required";
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  commonButton(
                    text: AppString.submit,
                    onPressed: () {
                      controller.submitForm();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
