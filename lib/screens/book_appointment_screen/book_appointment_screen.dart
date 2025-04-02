import 'dart:developer';

import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/constants/text_style_decoration.dart';
import 'package:doc_o_doctor/controller/book_appointment_controller.dart';
import 'package:doc_o_doctor/widgets/app_bar_widget.dart';
import 'package:doc_o_doctor/widgets/common_button.dart';
import 'package:doc_o_doctor/widgets/common_textfield.dart';
import 'package:doc_o_doctor/widgets/custom_text.dart';
import 'package:doc_o_doctor/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookAppointmentScreen extends StatelessWidget {
  BookAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BookAppointmentController controller = Get.put(
      BookAppointmentController(),
    );
    return Scaffold(
      backgroundColor: AppColor.white,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: commonButton(
          text: AppString.bookNow,
          onPressed: () {
            controller.submitForm();
          },
        ),
      ),
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //custom appbar widget[Book Appointment]
                Padding(
                  padding: EdgeInsets.all(20),
                  child: appBarWidget(title: AppString.bookAppointment),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: GestureDetector(
                    onTap: () {
                      controller.pickMonthYear(context);
                    },
                    child: Row(
                      children: [
                        Obx(
                          () => Text(
                            DateFormat.yMMMM().format(
                              controller.selectedDate.value,
                            ),

                            style: TextStyleDecoration.labelLarge.copyWith(
                              color: AppColor.black,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down_outlined),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 65.h,
                  child: Obx(() {
                    int daysInMonth =
                        DateTime(
                          controller.selectedDate.value.year,
                          controller.selectedDate.value.month + 1,
                          0,
                        ).day;

                    return ListView.builder(
                      controller: controller.scrollController,
                      itemCount: daysInMonth,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        int day = index + 1;
                        DateTime date = DateTime(
                          controller.selectedDate.value.year,
                          controller.selectedDate.value.month,
                          day,
                        );
                        bool isSelected = day == controller.selectedDay.value;
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                          child: GestureDetector(
                            onTap: () {
                              controller.selectedDay.value = day;
                              controller.selectedDay.refresh();
                              controller.selectedDate.refresh();
                              controller.scrollToSelectedDate();
                            },
                            child: Container(
                              width: 60,
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? AppColor.primaryColor
                                        : AppColor.white,
                                border: Border.all(
                                  color: AppColor.borderGrey.withValues(
                                    alpha: 0.1,
                                  ),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(9.26),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 12,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      DateFormat.d().format(date),
                                      style: TextStyleDecoration.labelLarge
                                          .copyWith(
                                            color:
                                                isSelected
                                                    ? AppColor.white
                                                    : AppColor.textGrey
                                                        .withOpacity(0.6),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    Text(
                                      DateFormat.E().format(date).toUpperCase(),
                                      style: TextStyleDecoration.labelLarge
                                          .copyWith(
                                            color:
                                                isSelected
                                                    ? AppColor.white
                                                    : AppColor.textGrey
                                                        .withOpacity(0.6),
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
                SizedBox(height: 20.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    AppString.avilableTime,
                    style: TextStyleDecoration.labelLarge.copyWith(
                      color: AppColor.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 8,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 72.19 / 28.88,
                    ),
                    itemBuilder: (context, index) {
                      return Obx(
                        () => GestureDetector(
                          onTap: () {
                            controller.selectedTime.value = index;
                            controller.selectedTime.refresh();
                          },
                          child: Container(
                            height: 28.88,
                            width: 72.19,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color:
                                  controller.selectedTime.value == index
                                      ? AppColor.primaryColor
                                      : null,
                              border: Border.all(
                                color: AppColor.borderGrey.withValues(
                                  alpha: 0.1,
                                ),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              avilableTime[index],
                              style: TextStyleDecoration.labelLarge.copyWith(
                                color:
                                    controller.selectedTime.value == index
                                        ? AppColor.white
                                        : AppColor.textGrey.withValues(
                                          alpha: 0.60,
                                        ),
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Obx(
                  () =>
                      controller.selectedTime.value == -1
                          ? Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 5.h,
                              horizontal: 20.w,
                            ),
                            child: CustomText(
                              text: controller.errorText.value,
                              textColor: AppColor.red,
                              fontSize: 10.sp,
                            ),
                          )
                          : SizedBox(),
                ),

                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: GestureDetector(
                    onTapDown: (TapDownDetails details) async {
                      final RenderBox overlay =
                          Overlay.of(context).context.findRenderObject()
                              as RenderBox;
                      final Offset position = details.globalPosition;

                      final result = await showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(
                          position.dx,
                          position.dy,
                          overlay.size.width - position.dx,
                          overlay.size.height - position.dy,
                        ),
                        items:
                            controller.options.map((String value) {
                              return PopupMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                      );

                      if (result != null) {
                        controller.updateSelectedValue(result);
                      }
                    },
                    child: Row(
                      children: [
                        Obx(
                          () => Text(
                            controller.selectedValue.value,
                            style: TextStyleDecoration.labelLarge.copyWith(
                              color: AppColor.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down_outlined),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20.h),
                Obx(() {
                  return controller.selectedValue.value == AppString.forSelf
                      ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: CustomTextField(
                          controller: controller.problemController,
                          label: AppString.writeYourProblemHere,
                          maxLine: 10,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty)
                              return "This field is required";
                            return null;
                          },
                        ),
                      )
                      : SizedBox();
                }),
                Obx(() {
                  return controller.selectedValue.value ==
                              AppString.forFamilyMember ||
                          controller.selectedValue.value ==
                              AppString.forOtherPerson
                      ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: controller.nameController,
                              label: AppString.name,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty)
                                  return "Name is required";
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            CustomTextField(
                              controller: controller.ageController,
                              keyboardType: TextInputType.numberWithOptions(),
                              label: AppString.age,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty)
                                  return "Age is required";
                                int? age = int.tryParse(value);
                                if (age == null || age < 1 || age > 120)
                                  return "Enter a valid age (1-120)";
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            commonPhoneField(
                              controller: controller.phoneController,
                              onChanged: (phone) {
                                log('Number: ${phone.countryCode}');
                              },
                              validator: (value) {
                                if (value == null) return "Phone is required";

                                return null;
                              },
                            ),
                            /* CustomTextField(
                                controller: controller.phoneController,
                                label: AppString.enterMobileNo,
                                keyboardType: TextInputType.phone,
                                maxLength: 10,
                                prefixIcon: Container(
                                  width: 50.w,
                                  margin: EdgeInsets.only(left: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "+91",
                                        style: TextStyleDecoration.labelMedium
                                            .copyWith(
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Icon(Icons.keyboard_arrow_down_outlined),
                                    ],
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty)
                                    return "Phone is required";
                                  if (!RegExp(r'^[0-9]{10}$').hasMatch(value))
                                    return "Enter a valid 10-digit phone number";
                                  return null;
                                },
                              ), */
                            SizedBox(height: 10),
                            CustomTextField(
                              label: AppString.gender,
                              isDropdown: true,
                              dropdownItems: controller.genderOptions,
                              selectedDropdown: controller.selectedGender,
                              onDropdownChanged: (String? value) {
                                controller.selectedGender.value = value!;
                              },
                              validator:
                                  (value) =>
                                      value == null ? "Select a Gender" : null,
                            ),
                            SizedBox(height: 10),
                            CustomTextField(
                              controller: controller.problemController,
                              label: AppString.writeYourProblemHere,
                              maxLine: 10,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty)
                                  return "This field is required";
                                return null;
                              },
                            ),
                          ],
                        ),
                      )
                      : SizedBox();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List avilableTime = [
    "09:00 AM",
    "10:00 AM",
    "11:00 AM",
    "12:00 PM",
    "02:00 PM",
    "03:00 PM",
    "04:00 PM",
    "05:00 PM",
  ];
}

class BookinDateWidget extends StatelessWidget {
  final String date;
  final String day;
  final Color bgColor;
  final Color fontColor;
  final void Function()? onTap;
  const BookinDateWidget({
    super.key,
    required this.date,
    required this.day,
    required this.bgColor,
    required this.fontColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 57,
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(
              color: AppColor.borderGrey.withValues(alpha: 0.1),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(9.26),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  date,
                  style: TextStyleDecoration.labelLarge.copyWith(
                    color: fontColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  day,
                  style: TextStyleDecoration.labelLarge.copyWith(
                    color: fontColor,
                    fontSize: 10,
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
