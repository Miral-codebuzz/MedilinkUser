// ignore_for_file: file_names

import 'package:doc_o_doctor/Model/documentModel.dart';
import 'package:doc_o_doctor/constants/commonwidget.dart';
import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/constants/text_style_decoration.dart';
import 'package:doc_o_doctor/screens/EditDocumentsScreen/documentsController.dart';
import 'package:doc_o_doctor/screens/EditDocumentsScreen/editcontroller.dart';
import 'package:doc_o_doctor/widgets/app_bar_widget.dart';
import 'package:doc_o_doctor/widgets/common_button.dart';
import 'package:doc_o_doctor/widgets/custom_text.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:widgets_easier/widgets_easier.dart';

class EditDocumentsScreen extends StatelessWidget {
  const EditDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Documentscontroller documentscontroller = Get.put(
      Documentscontroller(),
    );
    Get.put(AddDocController());
    documentscontroller.getDocument();

    return Scaffold(
      backgroundColor: Colors.white,

      body: Obx(() {
        if (documentscontroller.isLoading.value) {
          return Center(child: Commonwidget.commonLoader());
        }

        if (documentscontroller.listOdDocumnets.isEmpty) {
          return const Center(child: CustomText(text: "No data found"));
        }

        final insuranceDocs =
            documentscontroller.listOdDocumnets
                .where((doc) => doc.documentType == DocumentType.INSURANCE)
                .toList();

        final reportDocs =
            documentscontroller.listOdDocumnets
                .where((doc) => doc.documentType == DocumentType.REPORT)
                .toList();

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                appBarWidget(title: "Edit Documents"),
                SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DocumentSection(
                          title: "Reports",
                          documents: reportDocs,
                        ),
                        const SizedBox(height: 20),
                        DocumentSection(
                          title: "Medical Insurance",
                          documents: insuranceDocs,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      floatingActionButton: InkWell(
        onTap: () {
          showSortFilterBottomSheet(context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.primaryColor,

            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.add, color: Colors.white, size: 30),
          ),
        ),
      ),
    );
  }

  void showSortFilterBottomSheet(BuildContext context) {
    final AddDocController controller = Get.put(AddDocController());

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
          initialChildSize: 0.4,
          maxChildSize: 0.9,
          minChildSize: 0.4,
          builder: (context, scrollController) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  // Content Scrollable
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Form(
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
                              text: "Upload Documents",
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(height: 10.h),
                            Divider(color: Colors.grey[300]),
                            SizedBox(height: 10.h),

                            /// Medical Insurance Section
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
                            SizedBox(height: 20.h),

                            /// Medical Report Section
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

                  // Submit Button Fixed at Bottom
                  Obx(() {
                    if (controller.isLoading.value) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(child: Commonwidget.commonLoader()),
                      );
                    }
                    return Container(
                      margin: EdgeInsets.only(top: 10, bottom: 20),
                      height: Get.height * 0.07,
                      width: double.infinity,
                      child: commonButton(
                        bgColor:
                            controller.medicalPdfs.isNotEmpty ||
                                    controller.reportPdfs.isNotEmpty
                                ? AppColor.primaryColor
                                : AppColor.primaryColorO,
                        text: AppString.submit,
                        onPressed: () {
                          if (controller.medicalPdfs.isNotEmpty ||
                              controller.reportPdfs.isNotEmpty) {
                            controller.uploadMedicalCondition(context);
                          }
                        },
                      ),
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
            Expanded(
              child: Commonwidget.commonText(
                text: fileName,
                fontSize: 12.sp,
                maxLines: 1,
                fontWeight: FontWeight.w400,
              ),
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

class DocumentSection extends StatelessWidget {
  final String title;
  final List<DocumentsList> documents;

  const DocumentSection({
    super.key,
    required this.title,
    required this.documents,
  });

  @override
  Widget build(BuildContext context) {
    final Documentscontroller documentscontroller = Get.put(
      Documentscontroller(),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: title, fontSize: 20, fontWeight: FontWeight.bold),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children:
              documents.map((doc) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => PDFViewerScreen(pdfPath: doc.document ?? ""),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2 - 26,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.primaryColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: Image.asset(
                                'assets/images/pdf.png',
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white60,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(
                                    Icons.remove_red_eye_sharp,
                                    color: AppColor.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  doc.document ?? "Untitled",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.primaryColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  documentscontroller.deleteDocument(
                                    id: doc.id ?? 0,
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      "assets/images/deleteDOC.png",
                                      height: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

class PDFViewerScreen extends StatelessWidget {
  final String pdfPath;

  const PDFViewerScreen({super.key, required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("View PDF"),
        backgroundColor: Colors.white,
      ),
      body: SfPdfViewer.network(pdfPath),
    );
  }
}
