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
  String? email;
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
  String? aboutDoctor;
  String? status;
  String? step;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? averageRating;
  String? totalPatients;

  DoctorList({
    this.id,
    this.email,
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
    this.aboutDoctor,
    this.status,
    this.step,
    this.createdAt,
    this.updatedAt,
    this.averageRating,
    this.totalPatients,
  });

  factory DoctorList.fromJson(Map<String, dynamic> json) => DoctorList(
    id: json["id"],
    email: json["email"],
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
    aboutDoctor: json["aboutDoctor"],
    status: json["status"],
    step: json["step"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    averageRating: json["averageRating"],
    totalPatients: json["totalPatients"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
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
    "aboutDoctor": aboutDoctor,
    "status": status,
    "step": step,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "averageRating": averageRating,
    "totalPatients": totalPatients,
  };
}

class DoctorDetailResponseModel {
  bool? status;
  String? message;
  List<DoctorDetail>? data;

  DoctorDetailResponseModel({this.status, this.message, this.data});

  factory DoctorDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      DoctorDetailResponseModel(
        status: json["status"],
        message: json["message"],
        data:
            json["data"] == null
                ? []
                : List<DoctorDetail>.from(
                  json["data"]!.map((x) => DoctorDetail.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data":
        data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DoctorDetail {
  int? id;
  String? email;
  String? mobileNumber;
  String? name;
  String? gender;
  String? dateOfBirth;
  String? address;
  String? city;
  String? country;
  String? aboutDoctor;
  String? image;
  String? status;
  String? experience;
  String? jobTitle;
  String? services;
  String? step;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic averageRating;
  String? totalPatients;

  DoctorDetail({
    this.id,
    this.email,
    this.mobileNumber,
    this.name,
    this.gender,
    this.dateOfBirth,
    this.address,
    this.city,
    this.country,
    this.aboutDoctor,
    this.image,
    this.status,
    this.experience,
    this.jobTitle,
    this.services,
    this.step,
    this.createdAt,
    this.updatedAt,
    this.averageRating,
    this.totalPatients,
  });

  factory DoctorDetail.fromJson(Map<String, dynamic> json) => DoctorDetail(
    id: json["id"],
    email: json["email"],
    mobileNumber: json["mobileNumber"],
    name: json["name"],
    gender: json["gender"],
    dateOfBirth: json["dateOfBirth"],
    address: json["address"],
    city: json["city"],
    country: json["country"],
    aboutDoctor: json["aboutDoctor"],
    image: json["image"],
    status: json["status"],
    experience: json["experience"],
    jobTitle: json["jobTitle"],
    services: json["services"],
    step: json["step"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    averageRating: json["averageRating"],
    totalPatients: json["totalPatients"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "mobileNumber": mobileNumber,
    "name": name,
    "gender": gender,
    "dateOfBirth": dateOfBirth,
    "address": address,
    "city": city,
    "country": country,
    "aboutDoctor": aboutDoctor,
    "image": image,
    "status": status,
    "experience": experience,
    "jobTitle": jobTitle,
    "services": services,
    "step": step,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "averageRating": averageRating,
    "totalPatients": totalPatients,
  };
}
