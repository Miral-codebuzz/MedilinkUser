import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/constants/text_style_decoration.dart';
import 'package:doc_o_doctor/screens/doc_details_screen/doc_details_screen.dart';
import 'package:doc_o_doctor/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:doc_o_doctor/screens/notification_screen/notification_screen.dart';
import 'package:doc_o_doctor/widgets/custom_text.dart';
import 'package:doc_o_doctor/widgets/custom_textfield.dart';
import 'package:doc_o_doctor/widgets/image_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController search = TextEditingController();

    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //keny Meria,
                        Text(
                          AppString.kenyMeria,
                          style: TextStyleDecoration.labelLarge.copyWith(
                            color: AppColor.black,
                          ),
                        ),
                        //Smile, stay positive, and today amazing
                        Text(
                          AppString.smileStayPositiveAndTodayAmazing,
                          style: TextStyleDecoration.labelSmall.copyWith(
                            color: AppColor.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),

                    //notification icon
                    imageIconButton(
                      image: AppImage.notificationIcon,
                      onTap: () => Get.to(NotificationScreen()),
                    ),

                    SizedBox(width: 8.w),
                    //profile icon
                    imageIconButton(
                      image: AppImage.profileIcon,
                      onTap: () => Get.to(EditProfileScreen()),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                //search Text Filed
                // CommonTextfield(
                //   controller: search,
                //   hintText: AppString.search,
                //   isShowSuffixIcon: AppImage.searchIcon,
                // ),
                CustomTextField(
                  label: AppString.search,
                  suffixIcon: AppImage.searchIcon,
                  controller: search,
                ),
                SizedBox(height: 20.h),

                //scheduler Poster
                Container(
                  height: 164.h,
                  width: 325.w,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImage.schedulePoster),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                //our Doctors
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppString.ourDoctors,
                      style: TextStyleDecoration.labelMedium.copyWith(
                        color: AppColor.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    imageIconButton(
                      image: AppImage.detailsIcon,

                      height: 15.h,
                      width: 15.h,
                    ),
                  ],
                ),
                // List of Doctors
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 20,
                  padding: EdgeInsets.only(top: 10.h),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return DoctorsDetailsWidget(
                      image: AppImage.picImage,
                      name: 'Dr. Maria Waston',
                      reviews: '4.8 (2000 reviews)',
                      details: 'Heart Surgeon, London, England',
                      onTap: () => Get.to(() => DocDetailsScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DoctorsDetailsWidget extends StatelessWidget {
  final String image;
  final String name;
  final String reviews;
  final String details;
  final void Function()? onTap;
  const DoctorsDetailsWidget({
    super.key,
    required this.image,
    required this.name,
    required this.reviews,
    required this.details,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 94.h,

          decoration: BoxDecoration(
            border: Border.all(color: AppColor.borderColor, width: 1.8.w),
            borderRadius: BorderRadius.circular(14.87.w),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 15.h),
            child: Row(
              children: [
                // doctor Image
                Container(
                  width: 54.w,
                  height: 54.w,
                  decoration: BoxDecoration(
                    color: AppColor.lightPinkColor,
                    image: DecorationImage(image: AssetImage(image)),
                    borderRadius: BorderRadius.circular(17.96),
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //doctor name
                      CustomText(
                        text: name,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        height: 1.2,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            AppImage.starIcon,
                            height: 12.95.h,
                            width: 13.64.w,
                          ),
                          SizedBox(width: 5.w),

                          //reviews
                          Expanded(
                            child: CustomText(
                              text: reviews,
                              textColor: AppColor.textGrey.withValues(
                                alpha: 0.6,
                              ),
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              height: 1.1,
                              textAlignment: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                      //Location
                      Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              text: details,
                              textColor: AppColor.textGrey.withValues(
                                alpha: 0.6,
                              ),
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              textAlignment: TextAlign.left,
                            ),
                          ),
                          SizedBox(width: 5),
                          Image.asset(
                            AppImage.rightArrowIcon,
                            height: 25,
                            width: 25,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
