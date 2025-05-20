import 'package:doc_o_doctor/constants/commonwidget.dart';
import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/screens/booking_screen/bookingController.dart';
import 'package:doc_o_doctor/widgets/app_bar_widget.dart';
import 'package:doc_o_doctor/widgets/common_button.dart';
import 'package:doc_o_doctor/widgets/custom_text.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DetailsScreen extends StatelessWidget {
  final int doctorId;
  const DetailsScreen({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    final Bookingcontroller controller = Get.put(Bookingcontroller());

    controller.getBookingDetail(id: doctorId);
    return Scaffold(
      backgroundColor: AppColor.white,
      bottomNavigationBar: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: Commonwidget.commonLoader());
        }
        return Container(
          margin: EdgeInsets.all(10),
          height: Get.height * 0.07,
          child: commonButton(
            bgColor: Colors.red.shade100,
            text: "Cancel Appointment",
            textColor: Colors.red,

            onPressed: () {
              DialogHelper.showCustomDialog(
                context: context,
                title: "Cancel Appointment",
                message: "Are you sure you want to delete this appointment?",
                yesText: "Yes",
                noText: "No",
                onTapYes: () {
                  Get.back();
                  controller.cancelAppoinment(id: doctorId);
                },
                onTapNo: () {
                  Get.back();
                },
              );
            },
          ),
        );
      }),
      body: Obx(() {
        if (controller.isbookingDatail.value) {
          return Center(child: Commonwidget.commonLoader());
        }

        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  appBarWidget(title: AppString.details),
                  SizedBox(height: 30),

                  // Container(
                  //   height: 90,
                  //   width: 90,
                  //   decoration: BoxDecoration(
                  //     color: AppColor.primaryColor,
                  //     borderRadius: BorderRadius.circular(26),
                  //   ),
                  // ),
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
                        image: controller.bookingDatail.value?.image ?? "",
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
                    text: controller.bookingDatail.value?.name ?? 'User Name',
                    textColor: AppColor.textGrey,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                  ),
                  SizedBox(height: 20),

                  /// **Dropdown using GetX**
                  // Obx(
                  //   () => PopupMenuButton<String>(
                  //     onSelected: (String value) {
                  //       controller.updateSelection(value);
                  //     },
                  //     itemBuilder:
                  //         (BuildContext context) => [
                  //           PopupMenuItem(
                  //             value: "For Self",
                  //             child: Text("For Self"),
                  //           ),
                  //           PopupMenuItem(
                  //             value: "For Family Member",
                  //             child: Text("For Family Member"),
                  //           ),
                  //           PopupMenuItem(
                  //             value: "For Other Person",
                  //             child: Text("For Other Person"),
                  //           ),
                  //         ],
                  //     child: Row(
                  //       children: [
                  //         CustomText(
                  //           text:
                  //               controller.selectedValue.value, // GetX Reactive
                  //           fontSize: 16.sp,
                  //           fontWeight: FontWeight.w500,
                  //           height: 1.2,
                  //         ),
                  //         SizedBox(width: 5),
                  //         Icon(Icons.keyboard_arrow_down_sharp, size: 18),
                  //       ],
                  //     ),
                  //   ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: controller.selectedValue.value, // GetX Reactive
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                    ),
                  ),
                  // ),
                  SizedBox(height: 20),

                  /// **Show DetailsWidget only when "For Self" is selected**
                  Obx(
                    () =>
                    // controller.selectedValue.value == "For Self"
                    //     ?
                    DetailsWidget(
                      dateAndTime:
                          "${controller.bookingDatail.value?.availableTime}  ${controller.bookingDatail.value?.date}" ??
                          '',
                      age: controller.bookingDatail.value?.age ?? '',
                      mobileNumber:
                          controller.bookingDatail.value?.number ?? '',
                      gender: controller.bookingDatail.value?.gender ?? '',
                      patientProblem:
                          controller.bookingDatail.value?.problem ?? '',
                    ),

                    // : SizedBox(),
                  ), // Hide if not "For Self"
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class DetailsWidget extends StatelessWidget {
  final String dateAndTime;
  final String age;
  final String mobileNumber;
  final String gender;
  final String patientProblem;

  const DetailsWidget({
    super.key,
    required this.dateAndTime,
    required this.age,
    required this.mobileNumber,
    required this.gender,
    required this.patientProblem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "Date & Time",
            fontSize: 10,
            fontWeight: FontWeight.w400,
            textAlignment: TextAlign.left,
          ),
          CustomText(
            text: dateAndTime,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            textAlignment: TextAlign.left,
          ),
          SizedBox(height: 10),
          DottedLine(
            direction: Axis.horizontal,
            lineLength: double.infinity,
            lineThickness: 2,
            dashLength: 6.0,
            dashColor: AppColor.lightGrey,
          ),
          SizedBox(height: 10),
          CustomText(
            text: AppString.age,
            fontSize: 10,
            fontWeight: FontWeight.w400,
            textAlignment: TextAlign.left,
          ),
          CustomText(
            text: age,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            textAlignment: TextAlign.left,
          ),
          SizedBox(height: 10),
          DottedLine(
            direction: Axis.horizontal,
            lineLength: double.infinity,
            lineThickness: 2,
            dashLength: 6.0,
            dashColor: AppColor.lightGrey,
          ),
          SizedBox(height: 10),
          CustomText(
            text: AppString.mobileNumber,
            fontSize: 10,
            fontWeight: FontWeight.w400,
            textAlignment: TextAlign.left,
          ),
          CustomText(
            text: mobileNumber,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            textAlignment: TextAlign.left,
          ),
          SizedBox(height: 10),
          DottedLine(
            direction: Axis.horizontal,
            lineLength: double.infinity,
            lineThickness: 2,
            dashLength: 6.0,
            dashColor: AppColor.lightGrey,
          ),
          SizedBox(height: 10),
          CustomText(
            text: AppString.gender,
            fontSize: 10,
            fontWeight: FontWeight.w400,
            textAlignment: TextAlign.left,
          ),
          CustomText(
            text: gender,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            textAlignment: TextAlign.left,
          ),
          SizedBox(height: 10),
          DottedLine(
            direction: Axis.horizontal,
            lineLength: double.infinity,
            lineThickness: 2,
            dashLength: 6.0,
            dashColor: AppColor.lightGrey,
          ),
          SizedBox(height: 10),
          CustomText(
            text: AppString.patientProblem,
            fontSize: 10,
            fontWeight: FontWeight.w400,
            textAlignment: TextAlign.left,
          ),
          CustomText(
            text: patientProblem,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            maxLine: 10,
            height: 1.4,
            textAlignment: TextAlign.left,
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
