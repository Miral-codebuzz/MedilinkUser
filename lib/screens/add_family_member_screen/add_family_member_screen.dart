import 'package:doc_o_doctor/constants/commonwidget.dart';
import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/constants/text_style_decoration.dart';
import 'package:doc_o_doctor/controller/add_family_member_controller.dart';
import 'package:doc_o_doctor/widgets/app_bar_widget.dart';
import 'package:doc_o_doctor/widgets/common_button.dart';
import 'package:doc_o_doctor/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class AddFamilyMemberScreen extends StatelessWidget {
  final String? name;
  final String? gender;
  final String? dateOfBirth;
  final String? mobileNo;
  final String? relation;
  final int? doctorId;

  const AddFamilyMemberScreen({
    super.key,
    this.name,
    this.gender,
    this.dateOfBirth,
    this.mobileNo,
    this.relation,
    this.doctorId,
  });

  @override
  Widget build(BuildContext context) {
    final AddFamilyMemberController controller = Get.put(
      AddFamilyMemberController(),
    );

    controller.nameController.text = name ?? "";
    controller.selectedGender.value = gender ?? "";
    controller.dobController.text = dateOfBirth ?? "";
    if (mobileNo != null && mobileNo!.contains(' ')) {
      final parts = mobileNo!.split(' ');
      controller.countryCode.value = parts[0];
      controller.phoneController.text = parts[1];
    }
    controller.relationController.text = relation ?? "";

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
                            controller: controller.phoneController,
                            showDropdownIcon: true,
                            flagsButtonMargin: EdgeInsets.only(left: 10.w),
                            dropdownIconPosition: IconPosition.trailing,
                            dropdownIcon: Icon(Icons.keyboard_arrow_down),
                            showCountryFlag: false,
                            invalidNumberMessage: "",
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
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
                        // ignore: curly_braces_in_flow_control_structures
                        return "Relation is required";
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return Center(child: Commonwidget.commonLoader());
                    }

                    return commonButton(
                      text: AppString.saveMember,
                      onPressed: () {
                        controller.submitForm(id: doctorId);
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
