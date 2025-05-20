class ServiceConfiguration {
  // //  NOTE - Base Url Local
  static String baseUrl = "http://192.168.1.56:1500/user-api/";

  // NOTE - Api End Ponint
  static String email = "auth/email";
  static String deviceToken = "auth/device-token";
  static String profile = "auth/profile";
  static String codeVerification = "auth/code-verification";
  static String userInformation = "auth/tell-about-self";
  static String medicalCondition = "auth/medical-condition";
  static String logout = "auth/logout";
  static String helpAndSupport = "list/help-n-support";
  static String doctorList = "list/doctor-list";
  static String familyDoctors = "booking/family-doctors";
  static String doctorDetail = "list/doctor-detail/";
  static String availableSlot = "booking/available-slot";
  static String bookAppoinment = "booking/book-appoinment";
  static String skipForNow = "auth/skip-for-now";
  static String addAsfamilydoctor = "booking/add-as-familydoctor/";
  static String listfamilymember = "booking/list-family-member";
  static String addFamilyMember = "booking/add-family-member";
  static String deleteFamilyMember = "booking/delete-family-member/";
  static String deletedocument = "auth/delete-document/";
  static String getDocument = "auth/document";
  static String getFamilyDoctor = "booking/family-doctors";
  static String editFamilyMember = "booking/edit-family-member/";
  static String getBokingAppoinments = "booking/my-appoinments";
  static String getappoinmentDetails = "booking/appoinment-details/";
  static String cancelAppoinment = "booking/cancel-appoinment/";

  //  NOTE - Common
  static get commonErrorMessage => "Something went wrong";
}
