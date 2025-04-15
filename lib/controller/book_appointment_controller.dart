import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/screens/thank_you_screen/thank_you_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookAppointmentController extends GetxController {
  // var selectedDate = (-1).obs;
  var selectedTime = (-1).obs;
  RxString selectedValue = AppString.selectpatient.obs;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();
  final problemController = TextEditingController();
  final RxnString selectedGender = RxnString();
  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxInt selectedDay = DateTime.now().day.obs;
  ScrollController scrollController = ScrollController();
  RxString errorText = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
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
  }

  void pickMonthYear(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.purple,
            colorScheme: ColorScheme.light(primary: Colors.purple),
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
    } else if (formKey.currentState!.validate()) {
      Get.to(() => ThankYouScreen());
      nameController.clear();
      ageController.clear();
      phoneController.clear();
      problemController.clear();
      selectedDate.value = DateTime.now();
      selectedTime.value = -1;
    }
  }
}
