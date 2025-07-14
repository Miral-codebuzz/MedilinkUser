import 'package:doc_o_doctor/constants/commonwidget.dart';
import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/screens/Search/searchController.dart';
import 'package:doc_o_doctor/screens/doc_details_screen/doc_details_screen.dart';
import 'package:doc_o_doctor/widgets/app_bar_widget.dart';
import 'package:doc_o_doctor/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Search extends StatelessWidget {
  Search({super.key});
  final Searchcontroller controller = Get.put(Searchcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              appBarWidget(title: "Search"),
              SizedBox(height: 16),
              TextField(
                onTap: () {
                  controller.onhide.value = false;
                },
                controller: controller.search,
                onSubmitted: controller.performSearch,
                focusNode: FocusNode(),
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "Outfit",
                ),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: 'Search here..',
                  helperStyle: TextStyle(fontFamily: "Outfit", fontSize: 12),
                  filled: true,
                  fillColor: const Color(0xffF7F8F9),
                  suffixIcon: InkWell(
                    onTap: () {
                      controller.performSearch(controller.search.text.trim());
                      FocusScope.of(context).unfocus(); // Hide keyboard
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Image.asset(
                        AppImage.searchIcon,
                        height: 10,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Obx(() {
                if (controller.onhide.value) {
                  // return Expanded(
                  //   child: Center(
                  //     child: Text(
                  //       'No data Found',
                  //       style: TextStyle(color: Colors.black),
                  //     ),
                  //   ),
                  // );
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 10,
                      padding: EdgeInsets.only(bottom: 12.h),
                      itemBuilder: (context, index) {
                        return DoctorsDetailsWidget(
                          image: "dsfdsf",
                          name: "sdsf",
                          reviews: '4.8 (2000 reviews)',
                          details: "sadsadsd",
                          onTap: () => Get.to(() => DocDetailsScreen(id: 0)),
                        );
                      },
                    ),
                  );
                } else {
                  if (controller.showDropdown.value &&
                      controller.search.text.isNotEmpty) {
                    return _buildSearchResults();
                  } else if (controller.recentSearches.isNotEmpty) {
                    return _buildRecentSearches();
                  } else {
                    return const SizedBox.shrink();
                  }
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentSearches() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Commonwidget.commonText(
                text: "Recent",

                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
              GestureDetector(
                onTap: controller.clearRecentSearches,
                child: Commonwidget.commonText(
                  text: "Clear All",
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: controller.recentSearches.length,
              itemBuilder: (context, index) {
                final item = controller.recentSearches[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.search.text = item;
                        controller.performSearch(item);
                        FocusScope.of(context).unfocus();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9.0),
                        child: Commonwidget.commonText(
                          text: item,
                          fontSize: 18,
                          color: const Color.fromARGB(255, 98, 97, 97),
                        ),
                      ),
                    ),

                    Divider(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return Expanded(
      child: ListView.builder(
        itemCount: controller.searchResults.length,
        itemBuilder: (context, index) {
          final result = controller.searchResults[index];
          return ListTile(
            title: Commonwidget.commonText(text: result, color: Colors.grey),
            onTap: () {
              controller.search.text = result;
              controller.performSearch(result);
              FocusScope.of(context).unfocus();
            },
          );
        },
      ),
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
