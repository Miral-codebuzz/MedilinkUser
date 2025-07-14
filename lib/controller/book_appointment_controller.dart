// ignore_for_file: invalid_use_of_protected_member, unused_import

import 'dart:convert';

import 'package:doc_o_doctor/Model/bookNowModel.dart';
import 'package:doc_o_doctor/constants/commonwidget.dart';
import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/screens/thank_you_screen/thank_you_screen.dart';
import 'package:doc_o_doctor/service/rest_services.dart';
import 'package:doc_o_doctor/service/service_configuration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookAppointmentController extends GetxController {
  // var selectedDate = (-1).obs;
  var selectedTime = (-1).obs;
  RxString selectedValue = AppString.selectpatient.obs;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();
  final problemController = TextEditingController();
  final List<String> selectedforOptions = [
    'Mother',
    'Brother', // fixed typo
    'Father',
    'Sister',
  ];

  final RxnString selectedGender = RxnString();
  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  final RxnString selectedfor = RxnString();

  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxInt selectedDay = DateTime.now().day.obs;
  ScrollController scrollController = ScrollController();
  RxString errorText = "".obs;

  Rx<DateTime> selectedFullDate = Rx<DateTime>(DateTime.now());

  @override
  void onInit() {
    scrollToSelectedDate();
    super.onInit();
  }

  @override
  void dispose() {
    nameController.clear();
    ageController.clear();
    phoneController.clear();
    problemController.clear();
    selectedDate.value = DateTime.now();
    selectedTime.value = -1;
    super.dispose();
  }

  ///patient selection
  final List<String> options = [
    AppString.forSelf,
    AppString.forFamilyMember,
    AppString.forOtherPerson,
  ];

  void updateSelectedValue(String value) {
    selectedValue.value = value;
    selectedfor.value = value;
    nameController.clear();
    ageController.clear();
    phoneController.clear();
    selectedGender.value = "";
    problemController.clear();
    countryCode.value = "+91";
  }

  void pickMonthYear(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColor.primaryColor,
            colorScheme: ColorScheme.light(primary: AppColor.primaryColor),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      selectedDate.value = picked;

      // Ensure the selected day is valid in the new month
      int daysInNewMonth = DateTime(picked.year, picked.month + 1, 0).day;
      if (selectedDay.value > daysInNewMonth) {
        selectedDay.value = 1;
      } else {
        selectedDay.value = picked.day;
      }

      selectedDate.refresh();
      selectedDay.refresh();
      scrollToSelectedDate();
    }
  }

  void scrollToSelectedDate() {
    Future.delayed(Duration(milliseconds: 300), () {
      if (scrollController.hasClients) {
        double position = (selectedDay.value - 1) * 67.0;
        scrollController.animateTo(
          position,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void submitForm() {
    if (selectedDate.value == DateTime(0)) {
      errorText.value = "Select a date";
    } else if (selectedTime.value == -1) {
      errorText.value = "Select a avilable time";
    } else if (selectedValue.value == "Select Patient") {
      Commonwidget.showErrorSnackbar(message: "Plese Select Patirnt type");
    } else if (formKey.currentState!.validate()) {
      bookAppoinmentRequest();
      // Get.to(() => ThankYouScreen());
      // nameController.clear();
      // ageController.clear();
      // phoneController.clear();
      // problemController.clear();
      // selectedDate.value = DateTime.now();
      // selectedTime.value = -1;
    }
  }

  var isLoading = false.obs;
  var doctorId = 0.obs;
  var service = Get.find<RestService>();

  var slotList = <String>[].obs;
  Future<void> userAbout() async {
    try {
      var connection = await Commonwidget.checkConnectivity();
      if (!connection) return;

      isLoading.value = true;

      AvailableSlotRequestModel availableSlotRequestModel =
          AvailableSlotRequestModel();

      String formattedDate = DateFormat(
        'dd/MM/yyyy',
      ).format(selectedFullDate.value);
      String formattedDay = DateFormat('EEEE').format(selectedFullDate.value);

      availableSlotRequestModel.date = formattedDate;
      availableSlotRequestModel.day = formattedDay;
      availableSlotRequestModel.doctorId = doctorId.value;

      var result = await service.availableSlot(availableSlotRequestModel);

      if (result.status ?? false) {
        slotList.value.clear();
        List fetchedSlots = result.data ?? [];

        final now = DateTime.now();
        final selectedDate = selectedFullDate.value;

        List<String> validSlots = [];

        if (selectedDate.year == now.year &&
            selectedDate.month == now.month &&
            selectedDate.day == now.day) {
          // Only filter slots for today
          validSlots =
              fetchedSlots
                  .where((timeString) {
                    try {
                      String cleanedTimeString = timeString.trim();

                      final regex = RegExp(r'(\d{1,2}):(\d{2})\s?(AM|PM)');
                      final match = regex.firstMatch(cleanedTimeString);

                      if (match == null) {
                        return false;
                      }

                      int hour = int.parse(match.group(1)!);
                      int minute = int.parse(match.group(2)!);
                      String period = match.group(3)!;

                      if (period == "PM" && hour < 12) hour += 12;
                      if (period == "AM" && hour == 12) hour = 0;

                      final slotDateTime = DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        hour,
                        minute,
                      );

                      return slotDateTime.isAfter(now);
                    } catch (e) {
                      return false;
                    }
                  })
                  .cast<String>()
                  .toList();
        } else {
          // For future dates, return all slots
          validSlots = fetchedSlots.cast<String>();
        }

        slotList.assignAll(validSlots);
      } else {
        slotList.value.clear();
        isLoading.value = false;
      }
    } catch (e) {
      slotList.value.clear();
      debugPrint("ERROR :- ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  var countryCode = "+91".obs;
  var bookingLoader = false.obs;
  var selectTime = "".obs;
  var memberId = 0.obs;

  Future<void> bookAppoinmentRequest() async {
    try {
      var connection = await Commonwidget.checkConnectivity();
      if (!connection) return;
      bookingLoader.value = true;
      String formattedDate = DateFormat(
        'dd/MM/yyyy',
      ).format(selectedFullDate.value);
      String formattedDay = DateFormat('EEEE').format(selectedFullDate.value);
      BookAppoinmentRequestdModel bookAppoinmentRequestdModel =
          BookAppoinmentRequestdModel();
      bookAppoinmentRequestdModel.name = nameController.text;
      bookAppoinmentRequestdModel.day = formattedDay;
      bookAppoinmentRequestdModel.date = formattedDate;
      bookAppoinmentRequestdModel.doctorId = doctorId.value;
      bookAppoinmentRequestdModel.gender = selectedGender.value;
      bookAppoinmentRequestdModel.problem = problemController.text;
      bookAppoinmentRequestdModel.forWhom =
          selectedValue.value == AppString.forSelf
              ? "self"
              : selectedValue.value == AppString.forFamilyMember
              ? "familyMember"
              : "other";
      bookAppoinmentRequestdModel.availableTime = selectTime.value;
      bookAppoinmentRequestdModel.age =
          // ignore: unnecessary_null_in_if_null_operators
          int.tryParse(ageController.text) ?? null;
      bookAppoinmentRequestdModel.memberId = memberId.value;
      bookAppoinmentRequestdModel.number =
          phoneController.text.isNotEmpty
              ? "${countryCode.value} ${phoneController.text}"
              : "";

      var result = await service.bookAppoinment(bookAppoinmentRequestdModel);

      if (result.status ?? false) {
        Get.back();

        Get.offAll(() => ThankYouScreen());
        Commonwidget.showSuccessSnackbar(
          message: result.message ?? ServiceConfiguration.commonErrorMessage,
        );

        bookingLoader.value = false;
      } else {
        bookingLoader.value = false;
        Commonwidget.showErrorSnackbar(
          message: result.message ?? ServiceConfiguration.commonErrorMessage,
        );
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint("ERROR :- ${e.toString()}");
    }
  }
}
