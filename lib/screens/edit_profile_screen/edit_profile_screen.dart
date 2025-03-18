import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/constants/text_style_decoration.dart';
import 'package:doc_o_doctor/controller/edit_profile_controller.dart';
import 'package:doc_o_doctor/screens/book_appointment_screen/book_appointment_screen.dart';
import 'package:doc_o_doctor/widgets/app_bar_widget.dart';
import 'package:doc_o_doctor/widgets/common_button.dart';
import 'package:doc_o_doctor/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final EditProfileController controller = EditProfileController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  SizedBox(
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
                            image: DecorationImage(
                              image: AssetImage(AppImage.picImage),
                              fit: BoxFit.fill,
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
                            child: Image.asset(
                              AppImage.editIcon,
                              height: 18,
                              width: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
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
                  CustomTextField(
                    controller: controller.cityController,
                    label: AppString.city,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty)
                        return "City is required";
                      return null;
                    },
                  ),
                  CustomTextField(
                    controller: controller.countryController,
                    label: AppString.country,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty)
                        return "Country is required";
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  commonButton(
                    text: AppString.saveChange,
                    onPressed: () {
                      controller.submitForm();
                    },
                  ),
                  SizedBox(height: 15),
                  commonButton(
                    text: AppString.cancel,
                    textColor: AppColor.black,
                    bgColor: AppColor.lightGrey,
                    onPressed: () {},
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
