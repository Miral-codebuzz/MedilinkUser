import 'dart:async';
import 'dart:developer';

import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_string.dart';

import 'package:doc_o_doctor/constants/text_style_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class CommonTextfield extends StatelessWidget {
  final String hintText;
  final String? isShowSuffixIcon;
  final void Function()? suffixIconOnTap;
  final bool readOnly;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? errorText;
  final int? maxLines;
  const CommonTextfield({
    super.key,
    required this.hintText,
    this.isShowSuffixIcon,
    this.suffixIconOnTap,
    this.readOnly = false,
    this.controller,
    this.onChanged,
    this.errorText,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.w),
      child: TextField(
        controller: controller,
        cursorColor: AppColor.grey,
        keyboardType: TextInputType.text,
        style: TextStyle(color: AppColor.black),
        onChanged: onChanged,
        readOnly: readOnly,
        maxLines: maxLines,
        decoration: InputDecoration(
          suffixIcon: (isShowSuffixIcon != null)
              ? GestureDetector(
                  onTap: suffixIconOnTap,
                  child: Container(
                    height: 12.h,
                    width: 12.w,
                    margin: EdgeInsets.all(15.w),
                    // color: Colors.red,
                    child: Image.asset(
                      isShowSuffixIcon!,
                      width: 12.w,
                      height: 12.h,
                    ),
                  ),
                )
              : SizedBox.shrink(),
          filled: true,
          fillColor: Colors.grey.shade100,
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
          errorText: errorText,
          hintText: hintText,
          hintStyle: TextStyleDecoration.labelSmall.copyWith(
            color: AppColor.grey,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

Widget commonPhoneField({
  required TextEditingController controller,
  void Function(PhoneNumber)? onChanged,
  FutureOr<String?> Function(PhoneNumber?)? validator,
}) {
  return IntlPhoneField(
    controller: controller,
    showDropdownIcon: true,
    flagsButtonMargin: EdgeInsets.only(left: 10.w),
    dropdownIconPosition: IconPosition.trailing,
    dropdownIcon: Icon(Icons.keyboard_arrow_down),
    showCountryFlag: false,
    // invalidNumberMessage: "",
    autovalidateMode: AutovalidateMode.onUserInteraction,
    decoration: InputDecoration(
      /* prefix: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(AppImage.keyboardDownArrow, width: 10.w),
          SizedBox(width: 10.w),
          Text(
            '|',
            style: TextStyleDecoration.labelSmall.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              // color: AppColor.black,
              color: Colors.black54,
            ),
          ),
          SizedBox(width: 5),
        ],
      ),
      prefixIconColor: Colors.black54,
      prefixIcon: Text(
        '|',
        style: TextStyleDecoration.labelSmall.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          // color: AppColor.black,
          color: Colors.black54,
        ),
      ), */
      hintText: AppString.enterMobileNo,
      hintStyle: TextStyleDecoration.labelSmall.copyWith(
        color: Colors.grey,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
      contentPadding: EdgeInsets.only(left: 10),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(color: AppColor.textFieldBorderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(color: AppColor.textFieldBorderColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(color: AppColor.textFieldBorderColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(color: AppColor.textFieldBorderColor),
      ),
      filled: true,
      fillColor: Colors.grey.shade100,
    ),
    validator: validator,
    initialCountryCode: 'IN',
    style: TextStyle(fontSize: 16, color: Colors.black),
    dropdownTextStyle: TextStyle(fontSize: 16, color: Colors.black),
    onChanged: (phone) {
      log('Number: ${phone.countryCode}');
    },
  );
}




/* TextField(
                cursorColor: AppColor.grey,
                keyboardType: TextInputType.text,
                style: TextStyle(color: AppColor.black),
                onChanged: (value) {},
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade100,
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
                  errorText: null,
                  hintText: "Name",
                  hintStyle: TextStyleDecoration.labelSmall.copyWith(
                    color: AppColor.grey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ), */