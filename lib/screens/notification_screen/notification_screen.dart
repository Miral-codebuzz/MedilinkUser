// ignore_for_file: deprecated_member_use

import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/controller/notification_controller.dart';
import 'package:doc_o_doctor/widgets/app_bar_widget.dart';
import 'package:doc_o_doctor/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/instance_manager.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationController controller = Get.put(NotificationController());
    return Scaffold(
      backgroundColor: AppColor.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              appBarWidget(title: AppString.notification),
              Expanded(
                child:
                    controller.notiifcationData.isEmpty
                        ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImage.emptyNotification,
                              height: 208.h,
                              width: 237.w,
                            ),
                            SizedBox(height: 20),
                            CustomText(
                              text: AppString.noNotification,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(height: 20),
                            CustomText(
                              text:
                                  AppString.wellLetYouThereBeSomthingUpdateYou,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              maxLine: 2,
                              textColor: AppColor.textGrey.withValues(
                                alpha: 0.6,
                              ),
                            ),
                          ],
                        )
                        : ListView.builder(
                          itemCount: controller.notiifcationData.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.only(top: 20),
                          itemBuilder: (context, index) {
                            final notificationData =
                                controller.notiifcationData[index];
                            return NotificationContainerWidget(
                              notificationModel: NotificationModel(
                                dateAndTime: notificationData.dateAndTime,
                                time: notificationData.time,
                                title: notificationData.title,
                                subTitle: notificationData.subTitle,
                                imageIcon: notificationData.imageIcon,
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

class NotificationContainerWidget extends StatelessWidget {
  final NotificationModel notificationModel;
  const NotificationContainerWidget({
    super.key,
    required this.notificationModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: notificationModel.onTap,
        child: Container(
          height: 97,
          padding: EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: AppColor.primaryColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                alignment: Alignment.center,
                child: Icon(Icons.notifications, color: Colors.white),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: notificationModel.dateAndTime,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      textColor: AppColor.textGrey.withValues(alpha: 0.6),
                    ),

                    CustomText(
                      text: notificationModel.title,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 4),
                    CustomText(
                      text: notificationModel.subTitle,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      maxLine: 2,
                      textAlignment: TextAlign.start,
                      textColor: AppColor.textGrey.withValues(alpha: 0.6),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
