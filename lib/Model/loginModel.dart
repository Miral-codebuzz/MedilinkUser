class MessageAndStatus {
  bool? status;
  String? message;

  MessageAndStatus({this.status, this.message});

  factory MessageAndStatus.fromJson(Map<String, dynamic> json) =>
      MessageAndStatus(status: json["status"], message: json["message"]);

  Map<String, dynamic> toJson() => {"status": status, "message": message};
}

class RegisterRequest {
  String? mobileNumber;

  RegisterRequest({this.mobileNumber});

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      RegisterRequest(mobileNumber: json["mobileNumber"]);

  Map<String, dynamic> toJson() => {"mobileNumber": mobileNumber};
}

class OtpVerifierRequestModel {
  String? mobileNumber;
  String? otp;

  OtpVerifierRequestModel({this.mobileNumber, this.otp});

  factory OtpVerifierRequestModel.fromJson(Map<String, dynamic> json) =>
      OtpVerifierRequestModel(
        mobileNumber: json["mobileNumber"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {"mobileNumber": mobileNumber, "otp": otp};
}

class OtpVerifierResponseModel {
  bool? status;
  String? message;
  Data? data;

  OtpVerifierResponseModel({this.status, this.message, this.data});

  factory OtpVerifierResponseModel.fromJson(Map<String, dynamic> json) =>
      OtpVerifierResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  String? mobileNumber;
  String? name;
  String? gender;
  String? dateOfBirth;
  dynamic image;
  String? status;
  String? address;
  String? country;
  String? step;
  DateTime? createdAt;
  Authentication? authentication;

  Data({
    this.id,
    this.mobileNumber,
    this.name,
    this.gender,
    this.dateOfBirth,
    this.image,
    this.status,
    this.address,
    this.country,
    this.step,
    this.createdAt,
    this.authentication,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    mobileNumber: json["mobileNumber"],
    name: json["name"],
    gender: json["gender"],
    dateOfBirth: json["dateOfBirth"],
    image: json["image"],
    status: json["status"],
    address: json["address"],
    country: json["country"],
    step: json["step"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    authentication:
        json["authentication"] == null
            ? null
            : Authentication.fromJson(json["authentication"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mobileNumber": mobileNumber,
    "name": name,
    "gender": gender,
    "dateOfBirth": dateOfBirth,
    "image": image,
    "status": status,
    "address": address,
    "country": country,
    "step": step,
    "createdAt": createdAt?.toIso8601String(),
    "authentication": authentication?.toJson(),
  };
}

class Authentication {
  String? accessToken;
  String? refreshToken;
  int? expireAt;

  Authentication({this.accessToken, this.refreshToken, this.expireAt});

  factory Authentication.fromJson(Map<String, dynamic> json) => Authentication(
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"],
    expireAt: json["expireAt"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "refreshToken": refreshToken,
    "expireAt": expireAt,
  };
}

class TellAboutSelfRequest {
  String? name;
  String? gender;
  String? dateOfBirth;
  String? address;
  String? city;
  String? country;

  TellAboutSelfRequest({
    this.name,
    this.gender,
    this.dateOfBirth,
    this.address,
    this.city,
    this.country,
  });

  factory TellAboutSelfRequest.fromJson(Map<String, dynamic> json) =>
      TellAboutSelfRequest(
        name: json["name"],
        gender: json["gender"],
        dateOfBirth: json["dateOfBirth"],
        address: json["address"],
        city: json["city"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
    "name": name,
    "gender": gender,
    "dateOfBirth": dateOfBirth,
    "address": address,
    "city": city,
    "country": country,
  };
}
