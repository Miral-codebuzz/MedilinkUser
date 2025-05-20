import 'dart:isolate';

import 'package:doc_o_doctor/constants/commonwidget.dart';
import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/screens/booking_screen/bookingController.dart';
import 'package:doc_o_doctor/screens/booking_screen/details_screen.dart';
import 'package:doc_o_doctor/widgets/app_bar_widget.dart';
import 'package:doc_o_doctor/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingScreen extends StatelessWidget {
  final bool isShowBackIcon;
  const BookingScreen({super.key, this.isShowBackIcon = false});

  @override
  Widget build(BuildContext context) {
    final Bookingcontroller controller = Get.put(Bookingcontroller());
    controller.getBookingList();
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: Commonwidget.commonLoader());
        }

        if (controller.bookingList.isEmpty) {
          return Center(child: CustomText(text: "No data found"));
        }
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                appBarWidget(
                  title: AppString.appiontments,
                  showBackIcon: isShowBackIcon,
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.bookingList.length,
                    itemBuilder: (context, index) {
                      final doctor = controller.bookingList.value[index];
                      return CustomAppoinmentContainer(
                        image: doctor.image ?? "",
                        name: doctor.name ?? 'Dr. Maria Watson',
                        expert: doctor.doctorJobTitle ?? 'Cardio Specialist',
                        date: doctor.date ?? 'Wednesday, 12 March 2025',
                        time: doctor.availableTime ?? '11:00 - AM',
                        status: doctor.status ?? "Reject",
                        statusColor: Colors.red,
                        onTap:
                            () => Get.to(
                              () => DetailsScreen(doctorId: doctor.id ?? 0),
                            ),
                      );
                      // return CustomAppoinmentContainer(
                      //   image: "",
                      //   name: 'Dr. Maria Watson',
                      //   expert: 'Cardio Specialist',
                      //   date: 'Wednesday, 12 March 2025',
                      //   time: '11:00 - AM',
                      //   status: "Reject",
                      //   statusColor: Colors.red,
                      //   onTap: () => Get.to(() => DetailsScreen(doctorId: 0)),
                      // );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class CustomAppoinmentContainer extends StatelessWidget {
  final String image;
  final String name;
  final String expert;
  final String date;
  final String time;
  final String status;
  final Color statusColor;
  final void Function()? onTap;
  const CustomAppoinmentContainer({
    super.key,
    required this.image,
    required this.name,
    required this.expert,
    required this.date,
    required this.status,
    required this.statusColor,
    required this.time,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.lightGrey),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 19),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        status == "pending"
                            ? Colors.amber.withOpacity(0.1)
                            : status == "accepted"
                            ? Color(0xFF313131).withOpacity(0.1)
                            : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 4.0,
                    ),
                    child: Commonwidget.commonText(
                      text: status,
                      color:
                          status == "pending"
                              ? Colors.amber
                              : status == "accepted"
                              ? Color(0xFF313131)
                              : Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: AppColor.lightPinkColor,
                      image: DecorationImage(image: NetworkImage(image)),
                      borderRadius: BorderRadius.circular(17.96),
                    ),
                  ),
                  SizedBox(width: 9),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomText(
                          text: name,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 1.1,
                          textColor: AppColor.textGrey,
                        ),
                        SizedBox(height: 8),
                        CustomText(
                          text: expert,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 1,
                          textColor: AppColor.textGrey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(color: AppColor.lightGrey),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(AppImage.calender, height: 15, width: 15),
                  SizedBox(width: 5),
                  Expanded(
                    child: CustomText(
                      text: date,
                      textColor: AppColor.textGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      textAlignment: TextAlign.left,
                      height: 1,
                    ),
                  ),
                  SizedBox(width: 10),
                  Image.asset(AppImage.clockIcon, height: 15, width: 15),
                  SizedBox(width: 5),
                  CustomText(
                    text: time,
                    textColor: AppColor.textGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    textAlignment: TextAlign.left,
                    height: 1,
                  ),
                ],
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  height: 39,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(33, 18, 64, 90),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: AppString.details,
                        height: 1.1,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        textColor: AppColor.primaryColor,
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.arrow_forward,
                        color: AppColor.primaryColor,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
