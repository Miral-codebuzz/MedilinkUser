import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/constants/text_style_decoration.dart';
import 'package:doc_o_doctor/controller/book_appointment_controller.dart';
import 'package:doc_o_doctor/widgets/app_bar_widget.dart';
import 'package:doc_o_doctor/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BookAppointmentScreen extends StatelessWidget {
  const BookAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BookAppointmentController controller = Get.put(
      BookAppointmentController(),
    );
    return Scaffold(
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
                SizedBox(height: 30.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      //select date
                      Text(
                        'July, 2020',
                        style: TextStyleDecoration.labelLarge.copyWith(
                          color: AppColor.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down_outlined),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 65.h,
                  child: ListView.builder(
                    itemCount: 20,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Obx(
                        () => Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              controller.selectedDate.value = index;
                            },
                            child: Container(
                              width: 57,
                              decoration: BoxDecoration(
                                color:
                                    controller.selectedDate.value == index
                                        ? AppColor.primaryColor
                                        : null,
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
                                      '13',
                                      style: TextStyleDecoration.labelLarge
                                          .copyWith(
                                            color:
                                                controller.selectedDate.value ==
                                                        index
                                                    ? AppColor.white
                                                    : AppColor.textGrey
                                                        .withValues(
                                                          alpha: 0.60,
                                                        ),
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    Text(
                                      'MON',
                                      style: TextStyleDecoration.labelLarge
                                          .copyWith(
                                            color:
                                                controller.selectedDate.value ==
                                                        index
                                                    ? AppColor.white
                                                    : AppColor.textGrey
                                                        .withValues(
                                                          alpha: 0.60,
                                                        ),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.h),
                //available time
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
                              '09:00 AM',
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
                        //select Patient
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
                          label: "Write  Your Problem Here ...",
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
                            CustomTextField(
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
                            ),
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
}

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool isDropdown;
  final List<String>? dropdownItems;
  final RxnString? selectedDropdown;
  final void Function(String?)? onDropdownChanged;
  final Widget? prefixIcon;
  final int? maxLine;
  final maxLength;
  final String? suffixIcon;
  final void Function()? suffixIconOnTap;
  final bool readOnly;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.isDropdown = false,
    this.dropdownItems,
    this.selectedDropdown,
    this.onDropdownChanged,
    this.prefixIcon,
    this.maxLine,
    this.maxLength,
    this.suffixIcon,
    this.suffixIconOnTap,
    this.readOnly = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        isDropdown
            ? Obx(
              () => DropdownButtonFormField<String>(
                value: selectedDropdown?.value,
                style: TextStyleDecoration.labelMedium.copyWith(
                  color: AppColor.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),

                decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  hintText: label,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColor.textFieldBorderColor,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColor.textFieldBorderColor,
                      width: 1,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColor.textFieldBorderColor,
                      width: 1,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColor.textFieldBorderColor,
                      width: 1,
                    ),
                  ),
                  hintStyle: TextStyleDecoration.labelSmall.copyWith(
                    color: AppColor.grey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                items:
                    dropdownItems?.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                onChanged: onDropdownChanged,
                validator: validator,
              ),
            )
            : TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              maxLines: maxLine,
              validator: validator,
              readOnly: readOnly,
              maxLength: maxLength,
              onChanged: onChanged,
              style: TextStyleDecoration.labelMedium.copyWith(
                color: AppColor.black,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                fillColor: Colors.grey.shade100,
                hintText: label,
                prefixIcon: prefixIcon,
                suffixIcon:
                    // isDropdown
                    //     ? Icon(Icons.keyboard_arrow_down_outlined)
                    //     : null,
                    suffixIcon != null
                        ? GestureDetector(
                          onTap: suffixIconOnTap,
                          child: Container(
                            height: 12.h,
                            width: 12.w,
                            margin: EdgeInsets.all(15.w),
                            // color: Colors.red,
                            child: Image.asset(
                              suffixIcon!,
                              width: 12.w,
                              height: 12.h,
                            ),
                          ),
                        )
                        : SizedBox.shrink(),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColor.textFieldBorderColor,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColor.textFieldBorderColor,
                    width: 1,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColor.textFieldBorderColor,
                    width: 1,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColor.textFieldBorderColor,
                    width: 1,
                  ),
                ),
                hintStyle: TextStyleDecoration.labelSmall.copyWith(
                  color: AppColor.grey,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
      ],
    );
  }
}
