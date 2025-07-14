// ignore_for_file: deprecated_member_use

import 'package:doc_o_doctor/constants/commonwidget.dart';
import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/constants/text_style_decoration.dart';
import 'package:doc_o_doctor/controller/add_family_member_controller.dart';
import 'package:doc_o_doctor/controller/book_appointment_controller.dart';
import 'package:doc_o_doctor/widgets/app_bar_widget.dart';
import 'package:doc_o_doctor/widgets/common_button.dart';
import 'package:doc_o_doctor/widgets/custom_text.dart';
import 'package:doc_o_doctor/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class BookAppointmentScreen extends StatelessWidget {
  final int id;
  const BookAppointmentScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final BookAppointmentController controller = Get.put(
      BookAppointmentController(),
    );

    final AddFamilyMemberController addFamilyMemberController = Get.put(
      AddFamilyMemberController(),
    );
    addFamilyMemberController.getMemberList();
    controller.doctorId.value = id;
    controller.userAbout();
    return Scaffold(
      backgroundColor: AppColor.white,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: Obx(() {
          if (controller.bookingLoader.value) {
            return Center(child: Commonwidget.commonLoader());
          }
          return commonButton(
            text: AppString.bookNow,
            onPressed: () {
              controller.submitForm();
            },
          );
        }),
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
                        bool isPastDate = date.isBefore(
                          DateTime.now().subtract(Duration(days: 1)),
                        );

                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                          child: GestureDetector(
                            onTap:
                                isPastDate
                                    ? null
                                    : () {
                                      controller.selectedTime.value = -1;
                                      controller.selectedDay.value = day;
                                      controller.selectedDay.refresh();
                                      controller.selectedDate.refresh();

                                      // print(controller.selectedDate.toString());
                                      controller.scrollToSelectedDate();

                                      // Update the full selected date
                                      controller
                                          .selectedFullDate
                                          .value = DateTime(
                                        controller.selectedDate.value.year,
                                        controller.selectedDate.value.month,
                                        day,
                                      );

                                      controller.userAbout();
                                    },
                            child: Container(
                              width: 60,
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? AppColor.primaryColor
                                        : isPastDate
                                        ? AppColor.grey.withOpacity(0.3)
                                        : AppColor.white,
                                border: Border.all(
                                  color: AppColor.borderGrey.withOpacity(0.1),
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
                                                    : isPastDate
                                                    ? AppColor.textGrey
                                                        .withOpacity(0.2)
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
                                                    : isPastDate
                                                    ? AppColor.textGrey
                                                        .withOpacity(0.2)
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

                Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: Commonwidget.commonLoader());
                  }
                  if (controller.slotList.isEmpty) {
                    return Center(
                      child: Text(
                        "No slot available",
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.slotList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 72.19 / 28.88,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            controller.selectedTime.value = index;
                            controller.selectTime.value =
                                controller.slotList[controller
                                    .selectedTime
                                    .value];
                            controller.selectedTime.refresh();
                          },
                          child: Obx(() {
                            return Container(
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
                                controller.slotList[index],
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
                            );
                          }),
                        );
                      },
                    ),
                  );
                }),

                Obx(
                  () =>
                      controller.selectedTime.value == -1
                          ? Padding(
                            padding: EdgeInsets.symmetric(
                              // vertical: 5.h,
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
                SizedBox(height: 10.h),
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
                        color: Colors.white,
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
                            if (value == null || value.trim().isEmpty) {
                              return "This field is required";
                            }
                            return null;
                          },
                        ),
                      )
                      : SizedBox();
                }),
                Obx(() {
                  if (controller.selectedValue.value ==
                          AppString.forFamilyMember ||
                      controller.selectedValue.value ==
                          AppString.forOtherPerson) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          controller.selectedValue.value ==
                                  AppString.forFamilyMember
                              ? CustomTextField(
                                label: "Select family member",
                                isDropdown: true,
                                readOnly: true,
                                dropdownItems:
                                    addFamilyMemberController.familyList
                                        .map((member) => member.name ?? '')
                                        .toList(),
                                selectedDropdown: controller.selectedfor,
                                onDropdownChanged: (String? value) {
                                  // Find the selected FamilyMember object
                                  final selectedMember =
                                      addFamilyMemberController.familyList
                                          .firstWhere(
                                            (member) => member.name == value,
                                          );
                                  if (selectedMember.number != null &&
                                      selectedMember.number!.contains(' ')) {
                                    final parts = selectedMember.number!.split(
                                      ' ',
                                    );
                                    controller.countryCode.value = parts[0];
                                    controller.phoneController.text = parts[1];
                                  }
                                  controller.nameController.text =
                                      selectedMember.name ?? "";
                                  controller.selectedGender.value =
                                      selectedMember.gender ?? '';
                                  controller.memberId.value =
                                      selectedMember.id ?? 0;
                                },
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Select a family member";
                                  }
                                  return null;
                                },
                              )
                              : SizedBox(),
                          SizedBox(height: 10),
                          controller.selectedValue.value ==
                                  AppString.forOtherPerson
                              ? CustomTextField(
                                controller: controller.nameController,
                                label: AppString.name,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Name is required";
                                  }
                                  return null;
                                },
                              )
                              : SizedBox(),
                          SizedBox(height: 10),
                          controller.selectedValue.value ==
                                  AppString.forOtherPerson
                              ? Column(
                                children: [
                                  CustomTextField(
                                    controller: controller.ageController,
                                    keyboardType:
                                        TextInputType.numberWithOptions(),
                                    label: AppString.age,
                                    maxLength: 3,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return "Age is required";
                                      }
                                      int? age = int.tryParse(value);
                                      if (age == null || age < 1 || age > 120) {
                                        return "Enter a valid age (1-120)";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 10),
                                ],
                              )
                              : SizedBox(),

                          FormField<String>(
                            validator: (value) {
                              if (controller.phoneController.text
                                  .trim()
                                  .isEmpty) {
                                return "Mobile number is required";
                              }
                              if (controller.phoneController.text.length < 10) {
                                return "Enter a valid mobile number";
                              }
                              return null;
                            },
                            builder: (FormFieldState<String> field) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IntlPhoneField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    controller: controller.phoneController,
                                    showDropdownIcon: true,
                                    flagsButtonMargin: EdgeInsets.only(
                                      left: 10.w,
                                    ),
                                    dropdownIconPosition: IconPosition.trailing,
                                    dropdownIcon: Icon(
                                      Icons.keyboard_arrow_down,
                                    ),
                                    showCountryFlag: false,
                                    invalidNumberMessage: "",

                                    cursorColor: AppColor.primaryColor,
                                    decoration: InputDecoration(
                                      hintText: AppString.enterMobileNo,
                                      hintStyle: TextStyleDecoration.labelSmall
                                          .copyWith(
                                            color: Colors.grey,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                      contentPadding: EdgeInsets.only(left: 10),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(7),
                                        borderSide: BorderSide(
                                          color: AppColor.textFieldBorderColor,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(7),
                                        borderSide: BorderSide(
                                          color: AppColor.textFieldBorderColor,
                                        ),
                                      ),

                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(7),
                                        borderSide: BorderSide(
                                          color: AppColor.textFieldBorderColor,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(7),
                                        borderSide: BorderSide(
                                          color: AppColor.textFieldBorderColor,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey.shade100,
                                    ),
                                    initialCountryCode: 'IN',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                    dropdownTextStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                    onChanged: (phone) {
                                      controller.countryCode.value =
                                          phone.countryCode;
                                      field.didChange(phone.completeNumber);
                                    },
                                  ),
                                  if (field.hasError)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                      ),
                                      child: Text(
                                        field.errorText ?? '',
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                            255,
                                            177,
                                            48,
                                            39,
                                          ),
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: 10),
                          CustomTextField(
                            label: AppString.gender,
                            isDropdown: true,
                            readOnly: true,
                            dropdownItems: controller.genderOptions,
                            selectedDropdown: controller.selectedGender,
                            onDropdownChanged: (String? value) {
                              controller.selectedGender.value = value!;
                            },
                            validator:
                                (value) =>
                                    value == null ? "Select a gender" : null,
                          ),
                          SizedBox(height: 10),
                          CustomTextField(
                            controller: controller.problemController,
                            label: AppString.writeYourProblemHere,
                            maxLine: 10,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "This field is required";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
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
