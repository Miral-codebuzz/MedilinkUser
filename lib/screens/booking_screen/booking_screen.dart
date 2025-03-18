import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/widgets/app_bar_widget.dart';
import 'package:doc_o_doctor/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              appBarWidget(title: AppString.appiontments),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return CustomAppoinmentContainer(
                      image: AppImage.picImage,
                      name: 'Dr. Maria Watson',
                      expert: 'Cardio Specialist',
                      date: 'Wednesday, 12 March',
                      time: '11:00 - AM',
                      onTap: () {},
                    );
                  },
                ),
              ),
            ],
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
  final void Function()? onTap;
  const CustomAppoinmentContainer({
    super.key,
    required this.image,
    required this.name,
    required this.expert,
    required this.date,
    required this.time,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        height: 178,
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.lightGrey),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 19),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 54,
                    width: 53,
                    decoration: BoxDecoration(
                      color: AppColor.grey,
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(image: AssetImage(image)),
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
                  Row(
                    children: [
                      Image.asset(AppImage.calender, height: 15, width: 15),
                      SizedBox(width: 8),
                      CustomText(
                        text: date,
                        textColor: AppColor.textGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 1,
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Image.asset(AppImage.clockIcon, height: 15, width: 15),
                      SizedBox(width: 8),
                      CustomText(
                        text: time,
                        textColor: AppColor.textGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 1,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  height: 39,
                  decoration: BoxDecoration(
                    color: AppColor.lightPinkColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: AppString.details,
                        height: 1.1,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        textColor: AppColor.purpleColor,
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.arrow_forward,
                        color: AppColor.purpleColor,
                        size: 15,
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
