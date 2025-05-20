// ignore_for_file: file_names

import 'package:doc_o_doctor/constants/commonwidget.dart';
import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/controller/add_family_member_controller.dart';
import 'package:doc_o_doctor/screens/add_family_member_screen/add_family_member_screen.dart';
import 'package:doc_o_doctor/widgets/app_bar_widget.dart';
import 'package:doc_o_doctor/widgets/common_button.dart';
import 'package:doc_o_doctor/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FamilyMember extends StatefulWidget {
  const FamilyMember({super.key});

  @override
  State<FamilyMember> createState() => _FamilyMemberState();
}

class _FamilyMemberState extends State<FamilyMember> {
  final AddFamilyMemberController controller = Get.put(
    AddFamilyMemberController(),
  );

  @override
  void initState() {
    controller.getMemberList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: commonButton(
          text: "Add Family Member",
          onPressed: () {
            Get.to(() => AddFamilyMemberScreen());
          },
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.addmemberLoder.value) {
            return Center(child: Commonwidget.commonLoader());
          }

          if (controller.familyList.isEmpty) {
            return Center(child: CustomText(text: "No Data Found"));
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                appBarWidget(title: AppString.setting, showBackIcon: true),

                Expanded(
                  child: ListView.builder(
                    itemCount: controller.familyList.length,
                    padding: EdgeInsets.only(top: 10.h),
                    itemBuilder: (context, index) {
                      final itme = controller.familyList[index];
                      return DoctorsDetailsWidget(
                        name: itme.name ?? "Mieal",
                        gender: itme.gender ?? "Male",
                        dateOfBirth: itme.dob ?? "28 May 1995",
                        mobileNo: itme.number ?? "+91 000000000",
                        relation: itme.relation ?? "Mother",
                        delete: () {
                          controller.deleteFamily(itme.id ?? 0);
                        },
                        edit: () {
                          Get.to(
                            () => AddFamilyMemberScreen(
                              name: itme.name ?? "",
                              gender: itme.gender ?? "",
                              dateOfBirth: itme.dob ?? "",
                              mobileNo: itme.number ?? "",
                              relation: itme.relation ?? "",
                              doctorId: itme.id,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class DoctorsDetailsWidget extends StatelessWidget {
  final String name;
  final String gender;
  final String dateOfBirth;
  final String mobileNo;
  final String relation;
  final void Function()? delete;
  final void Function()? edit;

  const DoctorsDetailsWidget({
    super.key,
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    this.delete,
    this.edit,
    required this.mobileNo,
    required this.relation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 15.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.borderColor, width: 1.8.w),
          borderRadius: BorderRadius.circular(14.87.w),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Name & Relation
                  Row(
                    children: [
                      Flexible(
                        child: CustomText(
                          text: name,
                          fontWeight: FontWeight.w500,
                          fontSize: 17.sp,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(50, 64, 90, 51),
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.h,
                        ),
                        child: CustomText(text: relation, fontSize: 13.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),

                  /// Details & Icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      /// Info column
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Gender : $gender",
                            textColor: AppColor.textGrey.withAlpha(150),
                            fontWeight: FontWeight.w400,
                            fontSize: 13.sp,
                            textAlignment: TextAlign.left,
                          ),
                          SizedBox(height: 5.h),
                          CustomText(
                            text: "Date of Birth : $dateOfBirth",
                            textColor: AppColor.textGrey.withAlpha(150),
                            fontWeight: FontWeight.w400,
                            fontSize: 13.sp,
                            textAlignment: TextAlign.left,
                          ),
                          SizedBox(height: 5.h),
                          CustomText(
                            text: "Mobile No : $mobileNo",
                            textColor: AppColor.textGrey.withAlpha(150),
                            fontWeight: FontWeight.w400,
                            fontSize: 13.sp,
                            textAlignment: TextAlign.left,
                          ),
                        ],
                      ),

                      /// Edit & Delete icons
                      Row(
                        children: [
                          InkWell(
                            onTap: edit,
                            child: Image.asset(AppImage.edit, height: 22.h),
                          ),
                          SizedBox(width: 10.w),
                          InkWell(
                            onTap: delete,
                            child: Image.asset(AppImage.delete, height: 22.h),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
