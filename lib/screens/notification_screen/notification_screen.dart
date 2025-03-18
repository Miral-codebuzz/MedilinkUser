import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/widgets/app_bar_widget.dart';
import 'package:doc_o_doctor/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              appBarWidget(title: AppString.notification),
              Expanded(
                // child: Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Image.asset(
                //       AppImage.emptyNotification,
                //       height: 208.h,
                //       width: 237.w,
                //     ),
                //     SizedBox(height: 20),
                //     CustomText(
                //       text: AppString.noNotification,
                //       fontSize: 18,
                //       fontWeight: FontWeight.w600,
                //     ),
                //     SizedBox(height: 20),
                //     CustomText(
                //       text: AppString.wellLetYouThereBeSomthingUpdateYou,
                //       fontSize: 16,
                //       fontWeight: FontWeight.w400,
                //       maxLine: 2,
                //       textColor: AppColor.textGrey.withValues(alpha: 0.6),
                //     ),
                //   ],
                // ),
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 20),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Container(
                        height: 97,
                        padding: EdgeInsets.all(13),
                        decoration: BoxDecoration(
                          color: AppColor.lightPinkColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: AppColor.purpleColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: '22 Feb 2025 8:19pm',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    textColor: AppColor.textGrey.withValues(
                                      alpha: 0.6,
                                    ),
                                  ),

                                  CustomText(
                                    text: 'Appointment Confirmation',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  SizedBox(height: 5),
                                  CustomText(
                                    text:
                                        'Sent after booking an appointment to confirm details like date, time, and doctor',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    maxLine: 2,
                                    textAlignment: TextAlign.start,
                                    textColor: AppColor.textGrey.withValues(
                                      alpha: 0.6,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
