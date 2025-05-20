import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/text_style_decoration.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool isDropdown;
  final List<String>? dropdownItems;
  final List<TextInputFormatter>? inputFormatters;
  final RxnString? selectedDropdown;
  final void Function(String?)? onDropdownChanged;
  final Widget? prefixIcon;
  final int? maxLine;
  final maxLength;
  final String? suffixIcon;
  final void Function()? suffixIconOnTap;
  final bool readOnly;
  final void Function(String)? onChanged;
  final void Function()? onTap;

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
    this.inputFormatters,
    this.onTap,
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
                value:
                    (dropdownItems != null &&
                            dropdownItems!.contains(selectedDropdown?.value))
                        ? selectedDropdown?.value
                        : null,
                style: TextStyleDecoration.labelMedium.copyWith(
                  color: AppColor.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                dropdownColor: Colors.white,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  label: Text(
                    label,
                    style: TextStyleDecoration.labelMedium.copyWith(
                      color: AppColor.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
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
                ),
                items:
                    dropdownItems?.toSet().map((String value) {
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
              inputFormatters: inputFormatters ?? [],
              readOnly: readOnly,
              maxLength: maxLength,
              onTap: onTap,
              onChanged: onChanged,
              style: TextStyleDecoration.labelMedium.copyWith(
                color: AppColor.black,
                fontWeight: FontWeight.w400,
              ),
              cursorColor: AppColor.primaryColor,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade100,
                //  fillColor: Color.fromRGBO(232, 236, 244, 1),
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
