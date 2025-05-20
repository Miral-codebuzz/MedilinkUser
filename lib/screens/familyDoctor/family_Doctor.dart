import 'package:doc_o_doctor/constants/commonwidget.dart';
import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/controller/add_family_member_controller.dart';
import 'package:doc_o_doctor/screens/add_family_member_screen/add_family_member_screen.dart';
import 'package:doc_o_doctor/screens/doc_details_screen/doc_details_screen.dart';
import 'package:doc_o_doctor/widgets/app_bar_widget.dart';
import 'package:doc_o_doctor/widgets/common_button.dart';
import 'package:doc_o_doctor/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FamilyDoctorScreen extends StatefulWidget {
  const FamilyDoctorScreen({super.key});

  @override
  State<FamilyDoctorScreen> createState() => _FamilyDoctorScreenState();
}

class _FamilyDoctorScreenState extends State<FamilyDoctorScreen> {
  final AddFamilyMemberController controller = Get.put(
    AddFamilyMemberController(),
  );

  @override
  void initState() {
    controller.getDoctorList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,

      body: SafeArea(
        child: Obx(() {
          if (controller.isfamilydoctor.value) {
            return Center(child: Commonwidget.commonLoader());
          }

          if (controller.familydoctorList.isEmpty) {
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
                    shrinkWrap: true,
                    itemCount: controller.familydoctorList.length,
                    padding: EdgeInsets.only(top: 10.h),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return DoctorsDetailsWidget(
                        image: controller.familydoctorList[index].image ?? "",
                        name: controller.familydoctorList[index].name ?? "",
                        reviews: '4.8 (2000 reviews)',
                        // details:
                        //     controller.familydoctorList[index].address ?? "",
                        // onTap:
                        //     () => Get.to(
                        //       () => DocDetailsScreen(
                        //         id: controller.familydoctorList[index].id,
                        //       ),
                        //     ),
                        // dateOfBirth: '',
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
  final String image;
  final String name;
  final String reviews;
  // final String details;
  // final void Function()? onTap;
  const DoctorsDetailsWidget({
    super.key,
    required this.image,
    required this.name,
    required this.reviews,
    // required this.details,
    // this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 94.h,

          decoration: BoxDecoration(
            border: Border.all(color: AppColor.borderColor, width: 1.8.w),
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
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: CustomText(
                      //         text: details,
                      //         textColor: AppColor.textGrey.withValues(
                      //           alpha: 0.6,
                      //         ),
                      //         fontWeight: FontWeight.w400,
                      //         fontSize: 10,
                      //         textAlignment: TextAlign.left,
                      //       ),
                      //     ),
                      //     SizedBox(width: 5),
                      //     Image.asset(
                      //       AppImage.rightArrowIcon,
                      //       height: 25,
                      //       width: 25,
                      //     ),
                      //   ],
                      // ),
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
