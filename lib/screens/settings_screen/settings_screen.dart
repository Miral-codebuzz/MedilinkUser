import 'package:doc_o_doctor/constants/commonwidget.dart';
import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/constants/settings.dart';
import 'package:doc_o_doctor/controller/bottom_bar_controller.dart';
import 'package:doc_o_doctor/screens/EditDocumentsScreen/editDocumentsScreen.dart';
import 'package:doc_o_doctor/screens/add_family_member_screen/familyMember.dart';
import 'package:doc_o_doctor/screens/booking_screen/booking_screen.dart';
import 'package:doc_o_doctor/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:doc_o_doctor/screens/familyDoctor/family_Doctor.dart';
import 'package:doc_o_doctor/screens/help_and_support_screen/help_and_support_screen.dart';
import 'package:doc_o_doctor/screens/history/history.dart';
import 'package:doc_o_doctor/screens/terms_and_condition_screen/terms_and_condition_screen.dart';
import 'package:doc_o_doctor/widgets/app_bar_widget.dart';
import 'package:doc_o_doctor/widgets/common_button.dart';
import 'package:doc_o_doctor/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavBarController bottomNavBarController = Get.put(
      BottomNavBarController(),
    );
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                appBarWidget(title: AppString.setting, showBackIcon: false),
                SizedBox(height: 30),
                Container(
                  height: 90.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                    color: AppColor.purpleColor,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: FadeInImage.assetNetwork(
                      placeholder: AppImage.logoWhite,
                      image:
                          bottomNavBarController.profileDetail.value?.image ??
                          "",
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          AppImage.profileIcon,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                CustomText(
                  text:
                      bottomNavBarController.profileDetail.value?.name ??
                      'Nora Osborn',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
                SizedBox(height: 5),
                CustomText(
                  text:
                      bottomNavBarController
                          .profileDetail
                          .value
                          ?.mobileNumber ??
                      '+91 9585638563',
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
                  title: "Edit Documents",
                  prefixIcon: AppImage.document,
                  onTap: () {
                    Get.to(() => EditDocumentsScreen());
                  },
                ),

                CustomListStileWidget(
                  title: AppString.addFamilyMembers,
                  prefixIcon: AppImage.patientsIcon,
                  onTap: () {
                    Get.to(() => FamilyMember());
                  },
                ),
                CustomListStileWidget(
                  title: AppString.myBookings,
                  prefixIcon: AppImage.bookingIcon,
                  onTap: () {
                    Get.to(() => BookingScreen(isShowBackIcon: true));
                  },
                ),
                CustomListStileWidget(
                  title: "History",
                  prefixIcon: AppImage.history,
                  onTap: () {
                    Get.to(() => HistoryScreen(isShowBackIcon: true));
                  },
                ),
                CustomListStileWidget(
                  title: "Family Doctor",
                  prefixIcon: AppImage.fDoctor,
                  onTap: () {
                    Get.to(() => FamilyDoctorScreen());
                  },
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
                  onTap: () {
                    Get.to(() => TermsAndConditionScreen());
                  },
                ),
                CustomListStileWidget(
                  title: AppString.logOut,
                  prefixIcon: AppImage.logOutIcon,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return logOutModelBottomSheet();
                      },
                    );
                  },
                  showSufixIcon: false,
                  iconAndTextColor: AppColor.primaryColor,
                ),
              ],
            ),
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
              fontSize: 13,
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

Widget logOutModelBottomSheet() {
  final BottomNavBarController bottomNavBarController = Get.put(
    BottomNavBarController(),
  );
  return Container(
    height: 258,
    margin: EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
    ),
    alignment: Alignment.center,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 5.h,
          width: 48.w,
          decoration: BoxDecoration(
            color: AppColor.grey,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        SizedBox(height: 15),
        Container(
          height: 58.h,
          width: 58.h,
          decoration: BoxDecoration(
            color: AppColor.primaryColorO,
            borderRadius: BorderRadius.circular(11),
            border: Border.all(color: AppColor.primaryColor),
          ),
          alignment: Alignment.center,
          child: Image.asset(
            AppImage.logOutIcon,
            color: AppColor.primaryColor,
            height: 44.h,
            width: 44.h,
          ),
        ),
        SizedBox(height: 10),
        CustomText(
          text: AppString.logOutAccount,
          textColor: AppColor.primaryColor,
          fontWeight: FontWeight.w600,
          fontSize: 22,
        ),
        SizedBox(height: 5),
        CustomText(
          text: AppString.areYouSureYouWantToLogoutThisAccount,
          maxLine: 2,
          textColor: AppColor.textGrey,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: 5),
        Obx(() {
          if (bottomNavBarController.isLogout.value) {
            return Center(child: Commonwidget.commonLoader());
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              commonButton(
                text: AppString.logOut,

                onPressed: () {
                  Settings.clear();
                  bottomNavBarController.logout();
                },
                width: 126.w,
              ),
              SizedBox(width: 15),
              commonButton(
                text: AppString.cancel,
                onPressed: () {
                  Get.back();
                },
                width: 126.w,
                bgColor: AppColor.lightGrey,
                textColor: AppColor.textGrey,
              ),
            ],
          );
        }),
        SizedBox(height: 10),
      ],
    ),
  );
}
