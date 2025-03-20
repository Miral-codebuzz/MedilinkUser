import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/constants/text_style_decoration.dart';
import 'package:doc_o_doctor/screens/add_family_member_screen/add_family_member_screen.dart';
import 'package:doc_o_doctor/screens/book_appointment_screen/book_appointment_screen.dart';
import 'package:doc_o_doctor/widgets/app_bar_widget.dart';
import 'package:doc_o_doctor/widgets/common_button.dart';
import 'package:doc_o_doctor/widgets/custom_text.dart';
import 'package:doc_o_doctor/widgets/image_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DocDetailsScreen extends StatelessWidget {
  const DocDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return Scaffold(
      backgroundColor: AppColor.white,

      bottomNavigationBar: Container(
        margin: EdgeInsets.all(20),
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Book now  button
            commonButton(
              text: AppString.bookNow,
              onPressed: () {
                Get.to(() => BookAppointmentScreen());
              },
            ),
            // add As Family Doctor button
            commonButton(
              text: AppString.addAsFamilyDoctor,
              bgColor: AppColor.lightGrey,
              textColor: AppColor.black,
              onPressed: () {
                Get.to(() => AddFamilyMemberScreen());
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
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
                      image: AssetImage(AppImage.picImage),
                      fit: BoxFit.cover,
                    ),
                    color: AppColor.lightPinkColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                SizedBox(height: 20.h),
                //doctor name
                Text(
                  'Dr. Maria Waston',
                  style: TextStyleDecoration.labelLarge.copyWith(
                    color: AppColor.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h),
                //reviews
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImage.starIcon,
                      height: 14.36.h,
                      width: 15.26.w,
                    ),
                    SizedBox(width: 5.w),
                    //reviews
                    Text(
                      '4.8 (2000 reviews)',
                      style: TextStyleDecoration.labelSmall.copyWith(
                        color: AppColor.textGrey.withValues(alpha: 0.6),
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                //specialist
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppImage.cardioIcon, height: 14.h, width: 21.w),
                    SizedBox(width: 5.w),
                    Text(
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
                      subTitle: '10 Yrs',
                    ),
                    detailsContainer(
                      height: width * 0.27,
                      width: width * 0.27,
                      iconImage: AppImage.locationIcon,
                      title: AppString.location,
                      subTitle: 'California',
                    ),
                    detailsContainer(
                      height: width * 0.27,
                      width: width * 0.27,
                      iconImage: AppImage.patientsIcon,
                      title: AppString.patients,
                      subTitle: '1000 +',
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
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
                Text(
                  'Dr. Maria Watson is the top most Cardiologist specialist in Nanyang Hospitalet London. She is available for private consultation. Whether it’s a routine check-up or urgent medical assistance, we are here to support your well-being.Dr. Maria Watson is the top most Cardiologist specialist in Nanyang Hospitalet London. She is available for private consultation. Whether it’s a routine check-up or urgent medical assistance, we are here to support your well-being. ',
                  style: TextStyleDecoration.labelLarge.copyWith(
                    color: AppColor.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
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
