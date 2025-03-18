import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/constants/text_style_decoration.dart';
import 'package:doc_o_doctor/controller/add_family_member_controller.dart';
import 'package:doc_o_doctor/screens/book_appointment_screen/book_appointment_screen.dart';
import 'package:doc_o_doctor/widgets/app_bar_widget.dart';
import 'package:doc_o_doctor/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddFamilyMemberScreen extends StatelessWidget {
  const AddFamilyMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddFamilyMemberController controller = Get.put(
      AddFamilyMemberController(),
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  appBarWidget(title: AppString.addFamilyMembers),
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

                  SizedBox(height: 10),
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
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: controller.relationController,
                    label: AppString.relation,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty)
                        return "Relation is required";
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
