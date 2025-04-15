import 'dart:convert';
import 'dart:io';
import 'package:doc_o_doctor/Model/helpAndSupport.dart';
import 'package:doc_o_doctor/Model/homeModel.dart';
import 'package:doc_o_doctor/Model/loginModel.dart';
import 'package:doc_o_doctor/constants/settings.dart';
import 'package:doc_o_doctor/screens/login_screen/login_screen.dart';
import 'package:doc_o_doctor/service/service_configuration.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

enum Method { post, get, put, delete }

class RestService {
  Future<http.Response> getData<T>(
    String path,
    Method method,
    String? body,
  ) async {
    if (method == Method.get) {
      return await http.get(
        Uri.parse(ServiceConfiguration.baseUrl + path),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Settings.accessToken}',
          'keep-alive': 'on',
        },
      );
    } else if (method == Method.delete) {
      return await http.delete(
        Uri.parse(ServiceConfiguration.baseUrl + path),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Settings.accessToken}',
          'keep-alive': 'on',
        },
      );
    } else {
      return await http.post(
        Uri.parse(ServiceConfiguration.baseUrl + path),
        body: body,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Settings.accessToken}',
          'keep-alive': 'on',
        },
      );
    }
  }

  Future<http.Response> getResponse({
    required String path,
    required Method method,
    String? body,
    Map<String, dynamic>? query,
  }) async {
    debugPrint(" Url -----:----- ${ServiceConfiguration.baseUrl + path}");
    debugPrint(" Toke -----:----- ${Settings.accessToken}");

    http.Response response = await getData(path, method, body);

    if (response.statusCode == HttpStatus.badRequest) {
      if (response.statusCode == HttpStatus.unauthorized) {
        // Commonwidget.commonText(text: "Login error Log out");
        Get.offAll(LoginScreen());
        Settings.clear();
      }
      return response;
    } else {
      json.decode(response.body).toString();
      return response;
    }
  }

  Future<http.StreamedResponse> postMultipart({
    required String method,
    required String path,
    required Map<String, dynamic> fields,
    List<http.MultipartFile>? files,
  }) async {
    var uri = Uri.parse(ServiceConfiguration.baseUrl + path);
    var request = http.MultipartRequest(method, uri);
    request.headers.addAll(_getHeaders());

    fields.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    if (files != null && files.isNotEmpty) {
      request.files.addAll(files);
    }

    return await request.send();
  }

  Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Settings.accessToken}',
      'keep-alive': 'on',
    };
  }

  Future<MessageAndStatus> registerMobileNumber(RegisterRequest value) async {
    MessageAndStatus result = MessageAndStatus();
    try {
      var response = await getResponse(
        path: ServiceConfiguration.email,
        method: Method.post,
        body: json.encode(value),
      );
      if (response.statusCode == HttpStatus.ok) {
        result = MessageAndStatus.fromJson(json.decode(response.body));
      } else {
        result.message ?? ServiceConfiguration.commonErrorMessage;
      }
      return result;
    } catch (e) {
      result.message = e.toString();
      return result;
    }
  }

  // Future<MessageAndStatus> fcmRequest(DeviceTokenRequestModel value) async {
  //   MessageAndStatus result = MessageAndStatus();
  //   try {
  //     var response = await getResponse(
  //       path: ServiceConfiguration.deviceToken,
  //       method: Method.post,
  //       body: json.encode(value),
  //     );
  //     if (response.statusCode == HttpStatus.ok) {
  //       result = MessageAndStatus.fromJson(json.decode(response.body));
  //     } else {
  //       result.message ?? ServiceConfiguration.commonErrorMessage;
  //     }
  //     return result;
  //   } catch (e) {
  //     result.message = e.toString();
  //     return result;
  //   }
  // }

  Future<OtpVerifierResponseModel> otpVerifier(
    OtpVerifierRequestModel value,
  ) async {
    OtpVerifierResponseModel result = OtpVerifierResponseModel();
    try {
      var response = await getResponse(
        path: ServiceConfiguration.codeVerification,
        method: Method.post,
        body: json.encode(value),
      );
      if (response.statusCode == HttpStatus.ok) {
        result = OtpVerifierResponseModel.fromJson(json.decode(response.body));
      } else {
        result.message ??= ServiceConfiguration.commonErrorMessage;
      }
      return result;
    } catch (e) {
      result.message = e.toString();
      return result;
    }
  }

  Future<MessageAndStatus> tellAboutSelf(TellAboutSelfRequest value) async {
    MessageAndStatus result = MessageAndStatus();
    try {
      var response = await getResponse(
        path: ServiceConfiguration.userInformation,
        method: Method.post,
        body: json.encode(value),
      );
      if (response.statusCode == HttpStatus.ok) {
        result = MessageAndStatus.fromJson(json.decode(response.body));
      } else {
        result.message ??= ServiceConfiguration.commonErrorMessage;
      }
      return result;
    } catch (e) {
      result.message = e.toString();
      return result;
    }
  }

  Future<MessageAndStatus> logOut() async {
    MessageAndStatus result = MessageAndStatus();
    try {
      var response = await getResponse(
        path: ServiceConfiguration.logout,
        method: Method.get,
        body: json.encode(""),
      );
      if (response.statusCode == HttpStatus.ok) {
        Get.offAll(() => LoginScreen());
        Settings.clear();
        result = MessageAndStatus.fromJson(json.decode(response.body));
      } else {
        result.message ?? ServiceConfiguration.commonErrorMessage;
      }
      return result;
    } catch (e) {
      result.message = e.toString();
      return result;
    }
  }

  Future<MessageAndStatus> helpAndSupport(HelpAndSupportModel value) async {
    MessageAndStatus result = MessageAndStatus();
    try {
      var response = await getResponse(
        path: ServiceConfiguration.helpAndSupport,
        method: Method.post,
        body: json.encode(value),
      );
      if (response.statusCode == HttpStatus.ok) {
        result = MessageAndStatus.fromJson(json.decode(response.body));
      } else {
        result.message ??= ServiceConfiguration.commonErrorMessage;
      }
      return result;
    } catch (e) {
      result.message = e.toString();
      return result;
    }
  }

  // Future<ProfileResponseModel> getProfile() async {
  //   ProfileResponseModel result = ProfileResponseModel();
  //   try {
  //     var response = await getResponse(
  //       path: ServiceConfiguration.profile,
  //       method: Method.get,
  //       body: json.encode(""),
  //     );
  //     if (response.statusCode == HttpStatus.ok) {
  //       result = ProfileResponseModel.fromJson(json.decode(response.body));
  //     } else {
  //       result.message ?? ServiceConfiguration.commonErrorMessage;
  //     }
  //     return result;
  //   } catch (e) {
  //     result.message = e.toString();
  //     return result;
  //   }
  // }

  Future<DoctorListResponseModel> getDoctorList() async {
    DoctorListResponseModel result = DoctorListResponseModel();
    try {
      var response = await getResponse(
        path: ServiceConfiguration.doctorList,
        method: Method.get,
        body: json.encode(""),
      );
      if (response.statusCode == HttpStatus.ok) {
        result = DoctorListResponseModel.fromJson(json.decode(response.body));
      } else {
        result.message ??= ServiceConfiguration.commonErrorMessage;
      }
      return result;
    } catch (e) {
      result.message = e.toString();
      return result;
    }
  }

  Future<DoctorDetailResponseModel> getDoctorDetail({
    required int doctorId,
  }) async {
    DoctorDetailResponseModel result = DoctorDetailResponseModel();
    try {
      var response = await getResponse(
        path: '${ServiceConfiguration.doctorDetail}$doctorId',
        method: Method.get,
        body: json.encode(""),
      );
      if (response.statusCode == HttpStatus.ok) {
        result = DoctorDetailResponseModel.fromJson(json.decode(response.body));
      } else {
        result.message ??= ServiceConfiguration.commonErrorMessage;
      }
      return result;
    } catch (e) {
      result.message = e.toString();
      return result;
    }
  }
}
