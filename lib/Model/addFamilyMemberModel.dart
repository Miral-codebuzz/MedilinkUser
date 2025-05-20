class AddFamilyMemberRequestModel {
  String? name;
  String? number;
  String? gender;
  String? dob;
  String? relation;

  AddFamilyMemberRequestModel({
    this.name,
    this.number,
    this.gender,
    this.dob,
    this.relation,
  });

  factory AddFamilyMemberRequestModel.fromJson(Map<String, dynamic> json) =>
      AddFamilyMemberRequestModel(
        name: json["name"],
        number: json["number"],
        gender: json["gender"],
        dob: json["dob"],
        relation: json["relation"],
      );

  Map<String, dynamic> toJson() => {
    "name": name,
    "number": number,
    "gender": gender,
    "dob": dob,
    "relation": relation,
  };
}

class FamilyMemberResponsModel {
  bool? status;
  String? message;
  List<FamilyMember>? data;

  FamilyMemberResponsModel({this.status, this.message, this.data});

  factory FamilyMemberResponsModel.fromJson(Map<String, dynamic> json) =>
      FamilyMemberResponsModel(
        status: json["status"],
        message: json["message"],
        data:
            json["data"] == null
                ? []
                : List<FamilyMember>.from(
                  json["data"]!.map((x) => FamilyMember.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data":
        data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class FamilyMember {
  int? id;
  String? name;
  String? number;
  String? gender;
  String? dob;
  String? relation;

  FamilyMember({
    this.id,
    this.name,
    this.number,
    this.gender,
    this.dob,
    this.relation,
  });

  factory FamilyMember.fromJson(Map<String, dynamic> json) => FamilyMember(
    id: json["id"],
    name: json["name"],
    number: json["number"],
    gender: json["gender"],
    dob: json["dob"],
    relation: json["relation"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "number": number,
    "gender": gender,
    "dob": dob,
    "relation": relation,
  };
}

class FamilyDoctorResponseModel {
  bool? status;
  String? message;
  List<FamilyDoctor>? data;

  FamilyDoctorResponseModel({this.status, this.message, this.data});

  factory FamilyDoctorResponseModel.fromJson(Map<String, dynamic> json) =>
      FamilyDoctorResponseModel(
        status: json["status"],
        message: json["message"],
        data:
            json["data"] == null
                ? []
                : List<FamilyDoctor>.from(
                  json["data"]!.map((x) => FamilyDoctor.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data":
        data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class FamilyDoctor {
  String? name;
  String? image;
  String? jobTitle;

  FamilyDoctor({this.name, this.image, this.jobTitle});

  factory FamilyDoctor.fromJson(Map<String, dynamic> json) => FamilyDoctor(
    name: json["name"],
    image: json["image"],
    jobTitle: json["jobTitle"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
    "jobTitle": jobTitle,
  };
}
