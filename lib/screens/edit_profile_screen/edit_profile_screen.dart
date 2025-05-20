import 'package:doc_o_doctor/constants/commonwidget.dart';
import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/constants/text_style_decoration.dart';
import 'package:doc_o_doctor/controller/edit_profile_controller.dart';
import 'package:doc_o_doctor/widgets/app_bar_widget.dart';
import 'package:doc_o_doctor/widgets/common_button.dart';
import 'package:doc_o_doctor/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EditProfileController controller = Get.put(EditProfileController());
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  appBarWidget(title: AppString.editProfile),
                  SizedBox(height: 30),
                  Obx(() {
                    final imageFile = controller.pickedImage.value;

                    return SizedBox(
                      height: 95.h,
                      width: 100.w,
                      child: Stack(
                        children: [
                          Container(
                            height: 90.h,
                            width: 90.w,
                            decoration: BoxDecoration(
                              color: AppColor.grey,
                              borderRadius: BorderRadius.circular(26),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(26),
                              child:
                                  imageFile != null
                                      ? Image.file(imageFile, fit: BoxFit.cover)
                                      : FadeInImage.assetNetwork(
                                        placeholder: AppImage.logoWhite,
                                        image: controller.image.value,
                                        fit: BoxFit.cover,
                                        imageErrorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return Image.asset(
                                            AppImage.profileIcon,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                            ),
                          ),

                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: 28.h,
                              width: 28.h,
                              decoration: BoxDecoration(
                                color: AppColor.purpleColor,
                                border: Border.all(
                                  color: AppColor.white,
                                  width: 4,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () {
                                  controller.pickImageFromGallery();
                                },
                                child: Image.asset(
                                  AppImage.editIcon,
                                  height: 18,
                                  width: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  SizedBox(height: 20),
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

                  SizedBox(height: 10.h),
                  CustomTextField(
                    controller: controller.streetAddress,
                    label: AppString.streetAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Street address is required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    controller: controller.cityController,
                    label: AppString.city,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "City is required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    controller: controller.countryController,
                    label: AppString.country,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Country is required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return Center(child: Commonwidget.commonLoader());
                    }

                    return Column(
                      children: [
                        commonButton(
                          text: AppString.saveMember,
                          onPressed: () {
                            controller.submitForm();
                          },
                        ),
                        SizedBox(height: 15),
                        commonButton(
                          text: AppString.cancel,
                          textColor: AppColor.black,
                          bgColor: AppColor.lightGrey,
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ],
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
