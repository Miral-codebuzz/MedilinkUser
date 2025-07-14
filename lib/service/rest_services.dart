import 'dart:convert';
import 'dart:io';
import 'package:doc_o_doctor/Model/addFamilyMemberModel.dart';
import 'package:doc_o_doctor/Model/bookNowModel.dart';
import 'package:doc_o_doctor/Model/documentModel.dart';
import 'package:doc_o_doctor/Model/helpAndSupport.dart';
import 'package:doc_o_doctor/Model/homeModel.dart';
import 'package:doc_o_doctor/Model/loginModel.dart';
import 'package:doc_o_doctor/Model/profileModel.dart';
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

  Future<MessageAndStatus> fcmRequest(DeviceTokenRequestModel value) async {
    MessageAndStatus result = MessageAndStatus();
    try {
      var response = await getResponse(
        path: ServiceConfiguration.deviceToken,
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

  Future<MessageAndStatus> addFamilyMember(
    AddFamilyMemberRequestModel value, {
    int? id,
  }) async {
    MessageAndStatus result = MessageAndStatus();
    try {
      String url = "";

      if (id == 0 || id == null) {
        url = ServiceConfiguration.addFamilyMember;
      } else {
        url = "${ServiceConfiguration.editFamilyMember}$id";
      }

      var response = await getResponse(
        path: url,
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

  Future<MessageAndStatus> deleteFamilyMember(int id) async {
    MessageAndStatus result = MessageAndStatus();
    try {
      var response = await getResponse(
        path: "${ServiceConfiguration.deleteFamilyMember}$id",
        method: Method.delete,
        body: json.encode(""),
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

  Future<MessageAndStatus> deleteDocument(int id) async {
    MessageAndStatus result = MessageAndStatus();
    try {
      var response = await getResponse(
        path: "${ServiceConfiguration.deletedocument}$id",
        method: Method.delete,
        body: json.encode(""),
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

  Future<DocumentsResponseModel> getDocuments() async {
    DocumentsResponseModel result = DocumentsResponseModel();
    try {
      var response = await getResponse(
        path: ServiceConfiguration.getDocument,
        method: Method.get,
        body: json.encode(""),
      );
      if (response.statusCode == HttpStatus.ok) {
        result = DocumentsResponseModel.fromJson(json.decode(response.body));
      } else {
        result.message ?? ServiceConfiguration.commonErrorMessage;
      }
      return result;
    } catch (e) {
      result.message = e.toString();
      return result;
    }
  }

  Future<FamilyMemberResponsModel> getFamilyMember() async {
    FamilyMemberResponsModel result = FamilyMemberResponsModel();
    try {
      var response = await getResponse(
        path: ServiceConfiguration.listfamilymember,
        method: Method.get,
        body: json.encode(""),
      );
      if (response.statusCode == HttpStatus.ok) {
        result = FamilyMemberResponsModel.fromJson(json.decode(response.body));
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

  Future<BookAppoinmentReponerseedModel> bookAppoinment(
    BookAppoinmentRequestdModel value,
  ) async {
    BookAppoinmentReponerseedModel result = BookAppoinmentReponerseedModel();
    try {
      var response = await getResponse(
        path: ServiceConfiguration.bookAppoinment,
        method: Method.post,
        body: json.encode(value),
      );
      if (response.statusCode == HttpStatus.ok) {
        result = BookAppoinmentReponerseedModel.fromJson(
          json.decode(response.body),
        );
      } else {
        result.message ??= ServiceConfiguration.commonErrorMessage;
      }
      return result;
    } catch (e) {
      result.message = e.toString();
      return result;
    }
  }

  Future<AvailableSlotResponseModel> availableSlot(
    AvailableSlotRequestModel value,
  ) async {
    AvailableSlotResponseModel result = AvailableSlotResponseModel();
    try {
      var response = await getResponse(
        path: ServiceConfiguration.availableSlot,
        method: Method.post,
        body: json.encode(value),
      );
      if (response.statusCode == HttpStatus.ok) {
        result = AvailableSlotResponseModel.fromJson(
          json.decode(response.body),
        );
      } else {
        result.message ??= ServiceConfiguration.commonErrorMessage;
      }
      return result;
    } catch (e) {
      result.message = e.toString();
      return result;
    }
  }

  Future<ProfileResponseModel> getProfile() async {
    ProfileResponseModel result = ProfileResponseModel();
    try {
      var response = await getResponse(
        path: ServiceConfiguration.profile,
        method: Method.get,
        body: json.encode(""),
      );
      if (response.statusCode == HttpStatus.ok) {
        result = ProfileResponseModel.fromJson(json.decode(response.body));
      } else {
        result.message ?? ServiceConfiguration.commonErrorMessage;
      }
      return result;
    } catch (e) {
      result.message = e.toString();
      return result;
    }
  }

  Future<DoctorListResponseModel> getDoctorList({
    int? serviceId,
    int? rating,
  }) async {
    DoctorListResponseModel result = DoctorListResponseModel();
    String path = "";

    if (serviceId == null && rating == null) {
      path = ServiceConfiguration.doctorList;
    } else if (serviceId != null && rating == null) {
      path = "${ServiceConfiguration.doctorList}?serviceId=$serviceId";
    } else if (serviceId == null && rating != null) {
      path = "${ServiceConfiguration.doctorList}?rate=$rating";
    } else {
      path =
          "${ServiceConfiguration.doctorList}?serviceId=$serviceId&rate=$rating";
    }
    debugPrint("Doctor List URL: $path");
    try {
      var response = await getResponse(
        path: path,
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

  Future<FamilyDoctorResponseModel> getFamilyDoctorList() async {
    FamilyDoctorResponseModel result = FamilyDoctorResponseModel();
    try {
      var response = await getResponse(
        path: ServiceConfiguration.getFamilyDoctor,
        method: Method.get,
        body: json.encode(""),
      );
      if (response.statusCode == HttpStatus.ok) {
        result = FamilyDoctorResponseModel.fromJson(json.decode(response.body));
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

  Future<MessageAndStatus> skipForNow(SkipForNowModel value) async {
    MessageAndStatus result = MessageAndStatus();

    try {
      var response = await getResponse(
        path: ServiceConfiguration.skipForNow,
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

  Future<MessageAndStatus> addFamilyMemberdoctor(int id) async {
    MessageAndStatus result = MessageAndStatus();

    try {
      var response = await getResponse(
        path: "${ServiceConfiguration.addAsfamilydoctor}$id",
        method: Method.get,
        body: json.encode(""),
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

  Future<BookingListResponseModel> getBookingList() async {
    BookingListResponseModel result = BookingListResponseModel();

    try {
      var response = await getResponse(
        path: ServiceConfiguration.getBokingAppoinments,
        method: Method.get,
        body: json.encode(""),
      );
      if (response.statusCode == HttpStatus.ok) {
        result = BookingListResponseModel.fromJson(json.decode(response.body));
      } else {
        result.message ??= ServiceConfiguration.commonErrorMessage;
      }
      return result;
    } catch (e) {
      result.message = e.toString();
      return result;
    }
  }

  Future<BookingDetailsResponseModel> getBookingDetail({
    required int id,
  }) async {
    BookingDetailsResponseModel result = BookingDetailsResponseModel();

    try {
      var response = await getResponse(
        path: "${ServiceConfiguration.getappoinmentDetails}$id",
        method: Method.get,
        body: json.encode(""),
      );
      if (response.statusCode == HttpStatus.ok) {
        result = BookingDetailsResponseModel.fromJson(
          json.decode(response.body),
        );
      } else {
        result.message ??= ServiceConfiguration.commonErrorMessage;
      }
      return result;
    } catch (e) {
      result.message = e.toString();
      return result;
    }
  }

  Future<MessageAndStatus> cancelAppoinment({required int id}) async {
    MessageAndStatus result = MessageAndStatus();

    try {
      var response = await getResponse(
        path: "${ServiceConfiguration.cancelAppoinment}$id",
        method: Method.get,
        body: json.encode(""),
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
}
