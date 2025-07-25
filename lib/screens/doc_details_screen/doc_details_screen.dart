import 'package:doc_o_doctor/constants/commonwidget.dart';
import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/constants/text_style_decoration.dart';
import 'package:doc_o_doctor/screens/book_appointment_screen/book_appointment_screen.dart';
import 'package:doc_o_doctor/screens/doc_details_screen/docDetailsController.dart';
import 'package:doc_o_doctor/widgets/app_bar_widget.dart';
import 'package:doc_o_doctor/widgets/common_button.dart';
import 'package:doc_o_doctor/widgets/custom_text.dart';
import 'package:doc_o_doctor/widgets/image_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DocDetailsScreen extends StatelessWidget {
  final int? id;
  DocDetailsScreen({super.key, this.id});

  final Docdetailscontroller controller = Get.put(Docdetailscontroller());
  @override
  Widget build(BuildContext context) {
    controller.doctorId.value = id ?? 0;
    controller.getDoctorList();
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return Scaffold(
      backgroundColor: AppColor.white,
      bottomNavigationBar: Obx(() {
        if (controller.isBookNow.value) {
          return Center(child: Commonwidget.commonLoader());
        }
        return Container(
          margin: EdgeInsets.all(10),
          height: Get.height * 0.15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Book now  button
              commonButton(
                text: AppString.bookNow,
                onPressed: () {
                  Get.to(() => BookAppointmentScreen(id: id ?? 0));
                },
              ),
              // add As Family Doctor button
              commonButton(
                text: AppString.addAsFamilyDoctor,
                bgColor: AppColor.lightGrey,
                textColor: AppColor.black,
                onPressed: () {
                  controller.addFamilyMemberdoctor(id ?? 0);
                },
              ),
            ],
          ),
        );
      }),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: Commonwidget.commonLoader());
        }

        if (controller.doctorDetail.value == null) {
          return Center(child: Text("No data found"));
        }

        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  //custom appbar widget [Details]
                  appBarWidget(title: AppString.details),
                  SizedBox(height: 30.h),
                  //doctor image
                  Container(
                    height: 92.h,
                    width: 87.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          controller.doctorDetail.value?.image ?? '',
                        ),
                        fit: BoxFit.cover,
                      ),
                      color: AppColor.lightPinkColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  //doctor name
                  Text(
                    controller.doctorDetail.value?.name ?? 'Dr. Maria Waston',
                    style: TextStyleDecoration.labelLarge.copyWith(
                      color: AppColor.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (controller.doctorDetail.value?.averageRating != null) ...[
                    SizedBox(height: 10.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImage.starIcon,
                          height: 14.36.h,
                          width: 15.26.w,
                        ),

                        SizedBox(width: 5.w),

                        Text(
                          controller.doctorDetail.value?.averageRating
                                  .toString() ??
                              '4.5',
                          style: TextStyleDecoration.labelSmall.copyWith(
                            color: AppColor.textGrey.withValues(alpha: 0.6),
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                  SizedBox(height: 10.h),
                  //specialist
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImage.cardioIcon,
                        height: 14.h,
                        width: 21.w,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        controller.doctorDetail.value?.jobTitle ??
                            'Cardio Specialist',
                        style: TextStyleDecoration.labelSmall.copyWith(
                          color: AppColor.textGrey.withValues(alpha: 0.6),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  //Experience, Location, Patients
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Experience
                      detailsContainer(
                        height: width * 0.27,
                        width: width * 0.27,
                        iconImage: AppImage.experienceIcon,
                        title: AppString.experience,
                        subTitle:
                            controller.doctorDetail.value?.experience ??
                            '10 Yrs',
                      ),
                      detailsContainer(
                        height: width * 0.27,
                        width: width * 0.27,
                        iconImage: AppImage.locationIcon,
                        title: AppString.location,
                        subTitle:
                            controller.doctorDetail.value?.city ?? 'California',
                      ),
                      detailsContainer(
                        height: width * 0.27,
                        width: width * 0.27,
                        iconImage: AppImage.patientsIcon,
                        title: AppString.patients,
                        subTitle:
                            controller.doctorDetail.value?.totalPatients ??
                            '1000 +',
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  if (controller.doctorDetail.value?.aboutDoctor != null) ...[
                    Row(
                      children: [
                        //About Doctor
                        Text(
                          AppString.aboutdoctor,
                          style: TextStyleDecoration.labelLarge.copyWith(
                            color: AppColor.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    //about doctor details
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        controller.doctorDetail.value?.aboutDoctor ?? "",
                        style: TextStyleDecoration.labelLarge.copyWith(
                          color: AppColor.grey,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

//Experience, Location, Patients custom Widget
Widget detailsContainer({
  double? height,
  double? width,
  required String iconImage,
  required String subTitle,
  required String title,
}) {
  return Container(
    height: height ?? 95.h,
    width: width ?? 95.h,
    decoration: BoxDecoration(
      border: Border.all(color: AppColor.textFieldBorderColor, width: 1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          imageIconButton(image: iconImage, height: 18.h, width: 22.w),
          SizedBox(height: 10.h),
          CustomText(
            text: subTitle,
            textColor: AppColor.black,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: 5.h),
          CustomText(
            text: title,
            fontSize: 10.83,
            fontWeight: FontWeight.w400,
            textColor: AppColor.textGrey.withValues(alpha: 0.5),
          ),
        ],
      ),
    ),
  );
}
