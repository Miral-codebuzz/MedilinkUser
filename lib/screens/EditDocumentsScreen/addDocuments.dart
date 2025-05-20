import 'package:doc_o_doctor/constants/commonwidget.dart';
import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/constants/text_style_decoration.dart';
import 'package:doc_o_doctor/screens/EditDocumentsScreen/editcontroller.dart';
import 'package:doc_o_doctor/widgets/common_button.dart';
import 'package:doc_o_doctor/widgets/custom_text.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:widgets_easier/widgets_easier.dart';

class AdddocumentsScreen extends StatelessWidget {
  const AdddocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddDocController controller = Get.put(AddDocController());
    return Scaffold(
      bottomNavigationBar: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: Commonwidget.commonLoader());
        }
        return Container(
          margin: EdgeInsets.all(10),
          height: Get.height * 0.07,
          child: commonButton(
            bgColor:
                controller.medicalPdfs.isNotEmpty ||
                        controller.reportPdfs.isNotEmpty
                    ? AppColor.primaryColor
                    : AppColor.primaryColorO,
            text: AppString.next,
            onPressed: () {
              if (controller.medicalPdfs.isNotEmpty ||
                  controller.reportPdfs.isNotEmpty) {
                controller.uploadMedicalCondition(context);
              }
            },
          ),
        );
      }),
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Center(
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 70.h),
                  Image.asset(AppImage.logoBlue, height: 150.h, width: 150.w),
                  SizedBox(height: 30.h),
                  Text(
                    AppString.medicalCondition,
                    style: TextStyleDecoration.labelSmall.copyWith(
                      fontSize: 20.sp,
                      color: AppColor.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    AppString.tellUsAboutYourMedicalConditions,
                    textAlign: TextAlign.center,
                    style: TextStyleDecoration.labelSmall.copyWith(
                      fontSize: 14.sp,
                      color: AppColor.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  //Have You Any Medical Insurance ?   Add
                  Obx(
                    () => insuranceTitleRow(
                      title: AppString.haveYouAnyMedicalInsurance,
                      subTitle:
                          controller.isMedicalUploadVisible.value
                              ? AppString.cancel
                              : AppString.add,
                      onTap: controller.toggleMedicalUpload,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  DottedLine(
                    direction: Axis.horizontal,
                    lineLength: double.infinity,
                    lineThickness: 2,
                    dashLength: 6.0,
                    dashColor: AppColor.lightGrey,
                  ),
                  SizedBox(height: 10.h),
                  Obx(
                    () => Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children:
                          controller.medicalPdfs
                              .map(
                                (text) => customSelectedItem(
                                  text: text,
                                  onclose: () {
                                    controller.removeMedicalPdf(text);
                                  },
                                ),
                              )
                              .toList(),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Obx(
                    () =>
                        controller.isMedicalUploadVisible.value
                            ? uploadInsurance(
                              uploadOnTap: () {
                                controller.pickMedicalPdfs();
                              },
                            )
                            : SizedBox.shrink(),
                  ),
                  SizedBox(height: 10.h),

                  // Have You Any Past Medical Report ?   Add
                  Obx(
                    () => insuranceTitleRow(
                      title: AppString.haveYouAnyPastMedicalReport,
                      subTitle:
                          controller.isReportUploadVisible.value
                              ? AppString.cancel
                              : AppString.add,
                      onTap: controller.toggleReportUpload,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  DottedLine(
                    direction: Axis.horizontal,
                    lineLength: double.infinity,
                    lineThickness: 2,
                    dashLength: 6.0,
                    dashColor: AppColor.lightGrey,
                  ),
                  SizedBox(height: 10.h),
                  Obx(
                    () => Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children:
                          controller.reportPdfs
                              .map(
                                (text) => customSelectedItem(
                                  text: text,
                                  onclose: () {
                                    controller.removeReportPdf(text);
                                  },
                                ),
                              )
                              .toList(),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Obx(
                    () =>
                        controller.isReportUploadVisible.value
                            ? uploadInsurance(
                              uploadOnTap: () {
                                controller.pickReportPdfs();
                              },
                            )
                            : SizedBox.shrink(),
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  uploadInsurance({required void Function()? uploadOnTap}) {
    return Container(
      // height: 150,
      // width: 300,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: ShapeDecoration(
        shape: DashedBorder(
          borderRadius: BorderRadius.circular(8),
          color: AppColor.lightGrey,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: uploadOnTap,
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColor.lightGrey, width: 1.5),
                // color: Colors.grey.withOpacity(0.2),
              ),
              child: Image.asset(AppImage.upload, width: 18.w),
              /* child: Icon(
                Icons.cloud_upload_outlined,
                color: Colors.black54,
                size: 24.sp,
              ), */
            ),
          ),
          SizedBox(width: 10.w),
          GestureDetector(
            onTap: uploadOnTap,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: AppString.clickToUpload,
                    style: TextStyleDecoration.labelSmall.copyWith(
                      color: AppColor.primaryColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: AppString.insurance2,
                    style: TextStyleDecoration.labelSmall.copyWith(
                      color: AppColor.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  insuranceTitleRow({
    required String title,
    required String subTitle,
    required void Function()? onTap,
  }) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyleDecoration.labelSmall.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.black,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            subTitle,
            style: TextStyleDecoration.labelSmall.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColor.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

Widget customSelectedItem({
  required String text,
  required void Function()? onclose,
}) {
  String fileName = text.split('/').last;

  return IntrinsicWidth(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColor.uploadDocColor,
      ),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          children: [
            CustomText(
              text: fileName,
              textColor: AppColor.black,
              fontSize: 12.sp,
              maxLine: 1,
              height: 1.2,

              fontWeight: FontWeight.w400,
            ),
            SizedBox(width: 3),
            GestureDetector(
              onTap: onclose,
              child: Icon(Icons.close, size: 15.w),
            ),
          ],
        ),
      ),
    ),
  );
}
