import 'package:get/get.dart';

class AboutYourselfController extends GetxController {
  var name = ''.obs;
  var dob = ''.obs;
  var streetAddress = ''.obs;
  var city = ''.obs;
  var country = ''.obs;
  var selectedGender = RxnString();

  bool validateForm() {
    return name.isNotEmpty &&
        dob.isNotEmpty &&
        streetAddress.isNotEmpty &&
        city.isNotEmpty &&
        country.isNotEmpty &&
        selectedGender.value != null;
  }
}
