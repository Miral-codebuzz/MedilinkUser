import 'package:doc_o_doctor/constants/commonwidget.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/constants/text_style_decoration.dart';
import 'package:doc_o_doctor/controller/bottom_bar_controller.dart';
import 'package:doc_o_doctor/screens/Search/search.dart';
import 'package:doc_o_doctor/screens/doc_details_screen/doc_details_screen.dart';
import 'package:doc_o_doctor/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:doc_o_doctor/screens/home_screen/homeController.dart';
import 'package:doc_o_doctor/screens/notification_screen/notification_screen.dart';
import 'package:doc_o_doctor/widgets/custom_text.dart';
import 'package:doc_o_doctor/widgets/custom_textfield.dart';
import 'package:doc_o_doctor/widgets/image_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController search = TextEditingController();

    final Homecontroller controller = Get.put(Homecontroller());
    final BottomNavBarController bottomNavBarController = Get.put(
      BottomNavBarController(),
    );
    controller.getDoctorList();

    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: Commonwidget.commonLoader());
          }
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //keny Meria,
                          Text(
                            bottomNavBarController.profileDetail.value?.name ??
                                AppString.kenyMeria,
                            style: TextStyleDecoration.labelLarge.copyWith(
                              color: AppColor.black,
                            ),
                          ),
                          //Smile, stay positive, and today amazing
                          Text(
                            AppString.smileStayPositiveAndTodayAmazing,
                            style: TextStyleDecoration.labelSmall.copyWith(
                              color: AppColor.grey,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),

                      //notification icon
                      imageIconButton(
                        image: AppImage.notificationIcon,
                        onTap: () => Get.to(NotificationScreen()),
                      ),

                      SizedBox(width: 8.w),
                      //profile icon
                      imageIconButton(
                        image: AppImage.profileIcon,
                        onTap: () => Get.to(EditProfileScreen()),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  //search Text Filed
                  // CommonTextfield(
                  //   controller: search,
                  //   hintText: AppString.search,
                  //   isShowSuffixIcon: AppImage.searchIcon,
                  // ),
                  CustomTextField(
                    onTap: () => Get.to(() => Search()),
                    label: AppString.search,
                    suffixIcon: AppImage.searchIcon,
                    controller: search,
                    readOnly: true,
                  ),
                  SizedBox(height: 20.h),

                  //scheduler Poster
                  Container(
                    height: 140.h,
                    width: 325.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImage.schedulePoster),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  //our Doctors
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppString.ourDoctors,
                        style: TextStyleDecoration.labelMedium.copyWith(
                          color: AppColor.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showSortFilterBottomSheet(context);
                        },
                        child: imageIconButton(
                          image: AppImage.detailsIcon,

                          height: 15.h,
                          width: 15.h,
                        ),
                      ),
                    ],
                  ),
                  if (controller.doctorList.isEmpty) ...[
                    SizedBox(height: 20.h),
                    Center(
                      child: CustomText(
                        text: "No Doctors Found",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ] else ...[
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.doctorList.length,
                      padding: EdgeInsets.only(top: 10.h),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return DoctorsDetailsWidget(
                          image: controller.doctorList[index].image ?? "",
                          name: controller.doctorList[index].name ?? "",
                          reviews:
                              controller.doctorList[index].averageRating ?? "",
                          details: controller.doctorList[index].address ?? "",
                          onTap:
                              () => Get.to(
                                () => DocDetailsScreen(
                                  id: controller.doctorList[index].id,
                                ),
                              ),
                        );
                      },
                    ),
                  ],

                  // List of Doctors
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void showSortFilterBottomSheet(BuildContext context) {
    final categoryList = ["All", "Clothes", "Electronics", "Shoes"];
    final ratingList = ["All", "5", "4", "3", "2"];
    final Homecontroller controller = Get.put(Homecontroller());

    int selectedCategoryIndex = 0;
    int selectedRatingIndex = 0;

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () => Get.back(),
                          child: Container(
                            width: 40,
                            height: 4,
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        CustomText(
                          text: "Sort & Filter",
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                        const SizedBox(height: 10),
                        Divider(),
                        const SizedBox(height: 10),
                        // Categories
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(text: "Categories", fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: ChoiceChip(
                            checkmarkColor: Colors.white,
                            showCheckmark: false,
                            label: Text(categoryList[index]),
                            selected: selectedCategoryIndex == index,
                            shape: StadiumBorder(
                              side: BorderSide(
                                color: AppColor.primaryColor,
                                width: 1.5,
                              ),
                            ),
                            selectedColor: AppColor.primaryColor,
                            backgroundColor: Colors.white,
                            labelStyle: TextStyle(
                              color:
                                  selectedCategoryIndex == index
                                      ? Colors.white
                                      : AppColor.primaryColor,
                            ),
                            onSelected: (_) {
                              setState(() {
                                selectedCategoryIndex = index;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Ratings
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(text: "Rating", fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: ratingList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: ChoiceChip(
                            showCheckmark: false,
                            checkmarkColor: Colors.white,
                            avatar: Icon(
                              Icons.star,
                              size: 16,
                              color:
                                  selectedRatingIndex == index
                                      ? Colors.white
                                      : AppColor.primaryColor,
                            ),
                            label: Text(ratingList[index]),
                            selected: selectedRatingIndex == index,
                            shape: StadiumBorder(
                              side: BorderSide(
                                color: AppColor.primaryColor,
                                width: 1.5,
                              ),
                            ),
                            selectedColor: AppColor.primaryColor,
                            backgroundColor: Colors.white,
                            labelStyle: TextStyle(
                              color:
                                  selectedRatingIndex == index
                                      ? Colors.white
                                      : AppColor.primaryColor,
                            ),
                            onSelected: (_) {
                              setState(() {
                                selectedRatingIndex = index;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        Divider(),
                        const SizedBox(height: 20),
                        // Buttons
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: AppColor.borderColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "Reset",

                                  style: TextStyle(
                                    color: AppColor.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  // height: 15,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  controller.getDoctorList(
                                    serviceId: null,
                                    reating:
                                        ratingList[selectedRatingIndex]
                                                .toString()
                                                .toLowerCase()
                                                .contains("all")
                                            ? null
                                            : int.parse(
                                              ratingList[selectedRatingIndex],
                                            ),
                                  );
                                  Get.back();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: AppColor.primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    "Apply",

                                    style: TextStyle(
                                      color: AppColor.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
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
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
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
                      if (reviews.isNotEmpty) ...[
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
                      ],
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
                          SizedBox(width: 5),
                          Image.asset(
                            AppImage.rightArrowIcon,
                            height: 25,
                            width: 25,
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
