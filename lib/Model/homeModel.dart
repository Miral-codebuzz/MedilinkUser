class DoctorListResponseModel {
  bool? status;
  String? message;
  List<DoctorList>? data;

  DoctorListResponseModel({this.status, this.message, this.data});

  factory DoctorListResponseModel.fromJson(Map<String, dynamic> json) =>
      DoctorListResponseModel(
        status: json["status"],
        message: json["message"],
        data:
            json["data"] == null
                ? []
                : List<DoctorList>.from(
                  json["data"]!.map((x) => DoctorList.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data":
        data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DoctorList {
  int? id;
  String? mobileNumber;
  String? name;
  String? gender;
  String? address;
  String? city;
  String? country;
  String? jobTitle;
  String? experience;
  String? services;
  String? dateOfBirth;
  String? image;
  String? accountType;
  String? status;
  String? step;
  DateTime? createdAt;
  DateTime? updatedAt;

  DoctorList({
    this.id,
    this.mobileNumber,
    this.name,

    this.gender,
    this.address,
    this.city,
    this.country,
    this.jobTitle,
    this.experience,
    this.services,
    this.dateOfBirth,
    this.image,
    this.accountType,
    this.status,
    this.step,
    this.createdAt,
    this.updatedAt,
  });

  factory DoctorList.fromJson(Map<String, dynamic> json) => DoctorList(
    id: json["id"],
    mobileNumber: json["mobileNumber"],
    name: json["name"],
    gender: json["gender"],
    address: json["address"],
    city: json["city"],
    country: json["country"],
    jobTitle: json["jobTitle"],
    experience: json["experience"],
    services: json["services"],
    dateOfBirth: json["dateOfBirth"],
    image: json["image"],
    accountType: json["accountType"],
    status: json["status"],
    step: json["step"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mobileNumber": mobileNumber,
    "name": name,
    "gender": gender,
    "address": address,
    "city": city,
    "country": country,
    "jobTitle": jobTitle,
    "experience": experience,
    "services": services,
    "dateOfBirth": dateOfBirth,
    "image": image,
    "accountType": accountType,
    "status": status,
    "step": step,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class DoctorDetailResponseModel {
  bool? status;
  String? message;
  DoctorDetail? data;

  DoctorDetailResponseModel({this.status, this.message, this.data});

  factory DoctorDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      DoctorDetailResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : DoctorDetail.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class DoctorDetail {
  int? id;
  String? mobileNumber;
  String? name;
  String? gender;
  String? address;
  String? city;
  String? country;
  String? jobTitle;
  String? experience;
  String? services;
  String? dateOfBirth;
  String? image;
  String? accountType;
  String? status;
  String? step;
  DateTime? createdAt;
  DateTime? updatedAt;

  DoctorDetail({
    this.id,
    this.mobileNumber,
    this.name,
    this.gender,
    this.address,
    this.city,
    this.country,
    this.jobTitle,
    this.experience,
    this.services,
    this.dateOfBirth,
    this.image,
    this.accountType,
    this.status,
    this.step,
    this.createdAt,
    this.updatedAt,
  });

  factory DoctorDetail.fromJson(Map<String, dynamic> json) => DoctorDetail(
    id: json["id"],
    mobileNumber: json["mobileNumber"],
    name: json["name"],
    gender: json["gender"],
    address: json["address"],
    city: json["city"],
    country: json["country"],
    jobTitle: json["jobTitle"],
    experience: json["experience"],
    services: json["services"],
    dateOfBirth: json["dateOfBirth"],
    image: json["image"],
    accountType: json["accountType"],
    status: json["status"],
    step: json["step"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mobileNumber": mobileNumber,
    "name": name,
    "gender": gender,
    "address": address,
    "city": city,
    "country": country,
    "jobTitle": jobTitle,
    "experience": experience,
    "services": services,
    "dateOfBirth": dateOfBirth,
    "image": image,
    "accountType": accountType,
    "status": status,
    "step": step,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
