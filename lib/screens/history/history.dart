import 'dart:isolate';

import 'package:doc_o_doctor/constants/commonwidget.dart';
import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/screens/EditDocumentsScreen/editcontroller.dart';
import 'package:doc_o_doctor/screens/booking_screen/bookingController.dart';
import 'package:doc_o_doctor/screens/booking_screen/details_screen.dart';
import 'package:doc_o_doctor/screens/doc_details_screen/doc_details_screen.dart';
import 'package:doc_o_doctor/screens/history/historyController.dart';
import 'package:doc_o_doctor/widgets/app_bar_widget.dart';
import 'package:doc_o_doctor/widgets/common_button.dart';
import 'package:doc_o_doctor/widgets/custom_text.dart';
import 'package:doc_o_doctor/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatelessWidget {
  final bool isShowBackIcon;
  const HistoryScreen({super.key, this.isShowBackIcon = false});

  @override
  Widget build(BuildContext context) {
    final Historycontroller controller = Get.put(Historycontroller());
    // controller.getBookingList();
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: Commonwidget.commonLoader());
        }

        // if (controller.bookingList.isEmpty) {
        //   return Center(child: CustomText(text: "No data found"));
        // }
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                appBarWidget(title: "History", showBackIcon: isShowBackIcon),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
                    // controller.bookingList.length,
                    itemBuilder: (context, index) {
                      // final doctor = controller.bookingList.value[index];
                      // return CustomAppoinmentContainer(
                      //   image: doctor.image ?? "",
                      //   name: doctor.name ?? 'Dr. Maria Watson',
                      //   expert: doctor.doctorJobTitle ?? 'Cardio Specialist',
                      //   date: doctor.date ?? 'Wednesday, 12 March 2025',
                      //   time: doctor.availableTime ?? '11:00 - AM',
                      //   onTap:
                      //       () => Get.to(
                      //         () => DetailsScreen(doctorId: doctor.id ?? 0),
                      //       ),

                      // );
                      return CustomAppoinmentContainer(
                        image: "",
                        name: 'Dr. Maria Watson',
                        expert: 'Cardio Specialist',
                        date: 'Wednesday, 12 March 2025',
                        time: '11:00 - AM',
                        status: "Reject",
                        statusColor: Colors.red,
                        onTap: () => showSortFilterBottomSheet(context),
                      );
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

  void showSortFilterBottomSheet(BuildContext context) {
    final Historycontroller controller = Get.put(Historycontroller());
    double _rating = 0.0;

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.4,
          builder: (context, scrollController) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  // Content Scrollable
                  Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 12.h),
                        Container(
                          width: 40,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Commonwidget.commonText(
                          text: "Leave a Review",
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(height: 10.h),
                        Divider(color: Colors.grey[300]),
                        SizedBox(height: 5.h),
                        DoctorsDetailsWidget(
                          image: "",
                          name: " sdfsdf ",
                          reviews: '4.8 (2000 reviews)',
                          details: " sdfsdf sdfsdf  ",
                        ),
                        SizedBox(height: 15.h),
                        Divider(color: Colors.grey[300]),
                        SizedBox(height: 10.h),
                        Commonwidget.commonText(
                          text: "How is your Doctor",
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(height: 5.h),
                        Commonwidget.commonText(
                          text: "Please give your rating & also your review...",
                          color: Colors.grey[700],
                        ),
                        SizedBox(height: 10.h),
                        RatingBar(
                          initialRating: _rating,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          glow: false,
                          itemSize: 40.0,
                          ratingWidget: RatingWidget(
                            full: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.asset(AppImage.fulls, height: 25),
                            ),
                            half: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.asset(AppImage.halfs, height: 25),
                            ),
                            empty: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.asset(AppImage.fullw, height: 25),
                            ),
                          ),
                          onRatingUpdate: (rating) {
                            _rating = rating;
                          },
                        ),
                        SizedBox(height: 10.h),

                        CustomTextField(
                          controller: controller.reviewController,
                          label: "Write Your Problem Here ...",
                          maxLine: 5,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please Describe Your Problem Here";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),

                  // Submit Button Fixed at Bottom
                  Obx(() {
                    if (controller.isLoading.value) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(child: Commonwidget.commonLoader()),
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 20),
                          height: Get.height * 0.06,
                          width: Get.width * 0.4,
                          child: commonButton(
                            bgColor: AppColor.borderColor,
                            text: AppString.cancel,
                            textColor: AppColor.primaryColor,
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 20),
                          height: Get.height * 0.06,
                          width: Get.width * 0.4,
                          child: commonButton(
                            bgColor: AppColor.primaryColor,
                            text: AppString.submit,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            );
          },
        );
      },
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
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 2,
                blurRadius: 6,
                offset: Offset(0, 4),
              ),
            ],
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
                    image: DecorationImage(image: NetworkImage(image)),
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
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 4.0,
                    ),
                    child: Commonwidget.commonText(
                      text: "Reject",
                      color: statusColor,
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
                        text: "Add a Review",
                        height: 1.1,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        textColor: AppColor.primaryColor,
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
