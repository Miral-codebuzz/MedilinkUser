import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:doc_o_doctor/widgets/app_bar_widget.dart';
import 'package:doc_o_doctor/widgets/common_button.dart';
import 'package:doc_o_doctor/widgets/custom_text.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,

      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: commonButton(
          text: AppString.returnHome,
          onPressed: () {
            Get.to(() => BottomNavBar());
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                appBarWidget(title: AppString.bookAppointment),
                SizedBox(height: 60.h),
                Container(
                  height: 180.h,
                  width: 185.w,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImage.successIcon),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                CustomText(text: AppString.thankYou),
                SizedBox(height: 10),
                CustomText(
                  text: AppString.yourBookinRequestHasBeenReceived,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  textColor: AppColor.textGrey.withValues(alpha: 0.5),
                  maxLine: 2,
                ),
                SizedBox(height: 20),
                Container(
                  height: 100,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CustomText(
                            text: 'Booking ID : ',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          Expanded(
                            child: CustomText(
                              text: '1726502631',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              textAlignment: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      DottedLine(
                        direction: Axis.horizontal,
                        lineLength: double.infinity,
                        lineThickness: 2,
                        dashLength: 6.0,
                        dashColor: AppColor.lightGrey,
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: '7:50 AM  ',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: CustomText(
                              text: '28 Feb 2025',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              textAlignment: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      DottedLine(
                        direction: Axis.horizontal,
                        lineLength: double.infinity,
                        lineThickness: 2,
                        dashLength: 6.0,
                        dashColor: AppColor.lightGrey,
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
