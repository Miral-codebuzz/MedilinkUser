import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:doc_o_doctor/screens/help_and_support_screen/help_and_support_screen.dart';
import 'package:doc_o_doctor/widgets/app_bar_widget.dart';
import 'package:doc_o_doctor/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              appBarWidget(title: AppString.setting),
              SizedBox(height: 30),
              Container(
                height: 90.h,
                width: 90.w,
                decoration: BoxDecoration(
                  color: AppColor.purpleColor,
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
              SizedBox(height: 10),
              CustomText(
                text: 'Nora Osborn',
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
              SizedBox(height: 5),
              CustomText(
                text: '+91 9585638563',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                textColor: AppColor.textGrey.withValues(alpha: 0.8),
              ),
              SizedBox(height: 20),
              CustomListStileWidget(
                title: AppString.editProfile,
                prefixIcon: AppImage.profileIcon,
                onTap: () {
                  Get.to(() => EditProfileScreen());
                },
              ),
              CustomListStileWidget(
                title: AppString.addFamilyMembers,
                prefixIcon: AppImage.patientsIcon,
                onTap: () {},
              ),
              CustomListStileWidget(
                title: AppString.myBookings,
                prefixIcon: AppImage.bookingIcon,
                onTap: () {},
              ),
              CustomListStileWidget(
                title: AppString.helpAndSupport,
                prefixIcon: AppImage.helpAndSupportIcon,
                onTap: () {
                  Get.to(() => HelpAndSupportScreen());
                },
              ),
              CustomListStileWidget(
                title: AppString.termsAndCondition,
                prefixIcon: AppImage.termsAndConditionIcon,
                onTap: () {},
              ),
              CustomListStileWidget(
                title: AppString.logOut,
                prefixIcon: AppImage.logOutIcon,
                onTap: () {},
                showSufixIcon: false,
                iconAndTextColor: AppColor.purpleColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListStileWidget extends StatelessWidget {
  final double? height;
  final String prefixIcon;
  final String title;
  final bool? showSufixIcon;
  final Color? iconAndTextColor;
  final void Function()? onTap;
  const CustomListStileWidget({
    super.key,
    this.height,
    required this.prefixIcon,
    required this.title,
    this.iconAndTextColor,
    this.showSufixIcon = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44.h,
        padding: EdgeInsets.symmetric(horizontal: 16),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: AppColor.listTileColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image.asset(
              prefixIcon,
              height: 24.h,
              width: 24.w,
              color: iconAndTextColor ?? AppColor.textGrey,
            ),
            SizedBox(width: 10),
            CustomText(
              text: title,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              textColor: iconAndTextColor ?? AppColor.textGrey,
            ),
            Spacer(),
            if (showSufixIcon == true)
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: AppColor.textGrey,
                weight: 4,
                size: 14,
              ),
          ],
        ),
      ),
    );
  }
}
