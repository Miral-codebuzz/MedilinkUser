class ProfileResponseModel {
  bool? status;
  String? message;
  ProfileResponse? data;

  ProfileResponseModel({this.status, this.message, this.data});

  factory ProfileResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => ProfileResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : ProfileResponse.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class ProfileResponse {
  int? id;
  String? email;
  String? mobileNumber;
  String? name;
  String? gender;
  String? city;
  String? dateOfBirth;
  String? image;
  String? status;
  String? address;
  String? country;
  String? step;
  DateTime? createdAt;

  ProfileResponse({
    this.id,
    this.email,
    this.mobileNumber,
    this.name,
    this.gender,
    this.city,
    this.dateOfBirth,
    this.image,
    this.status,
    this.address,
    this.country,
    this.step,
    this.createdAt,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        id: json["id"],
        email: json["email"],
        mobileNumber: json["mobileNumber"],
        name: json["name"],
        gender: json["gender"],
        dateOfBirth: json["dateOfBirth"],
        image: json["image"],
        status: json["status"],
        city: json["city"],
        address: json["address"],
        country: json["country"],
        step: json["step"],
        createdAt:
            json["createdAt"] == null
                ? null
                : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "mobileNumber": mobileNumber,
    "name": name,
    "gender": gender,
    "dateOfBirth": dateOfBirth,
    "image": image,
    "city": city,
    "status": status,
    "address": address,
    "country": country,
    "step": step,
    "createdAt": createdAt?.toIso8601String(),
  };
}

class DeviceTokenRequestModel {
  String? deviceId;
  String? deviceType;
  String? token;

  DeviceTokenRequestModel({this.deviceId, this.deviceType, this.token});

  factory DeviceTokenRequestModel.fromJson(Map<String, dynamic> json) =>
      DeviceTokenRequestModel(
        deviceId: json["deviceId"],
        deviceType: json["deviceType"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
    "deviceId": deviceId,
    "deviceType": deviceType,
    "token": token,
  };
}
