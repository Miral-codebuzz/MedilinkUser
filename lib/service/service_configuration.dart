class ServiceConfiguration {
  // //  NOTE - Base Url Local
  static String baseUrl = "http://192.168.1.28:1400/user-api/";

  // NOTE - Api End Ponint
  static String email = "auth/sign-in";
  static String codeVerification = "auth/code-verification";
  static String userInformation = "auth/tell-about-self";
  static String medicalCondition = "auth/medical-condition";
  static String logout = "auth/logout";
  static String helpAndSupport = "list/help-n-support";
  static String doctorList = "list/doctor-list";
  static String doctorDetail = "list/doctor-detail/";

  //  NOTE - Common
  static get commonErrorMessage => "Something went wrong";
}
