class AvailableSlotResponseModel {
  bool? status;
  String? message;
  List<String>? data;

  AvailableSlotResponseModel({this.status, this.message, this.data});

  factory AvailableSlotResponseModel.fromJson(Map<String, dynamic> json) =>
      AvailableSlotResponseModel(
        status: json["status"],
        message: json["message"],
        data:
            json["data"] == null
                ? []
                : List<String>.from(json["data"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
  };
}

class AvailableSlotRequestModel {
  String? day;
  String? date;
  int? doctorId;

  AvailableSlotRequestModel({this.day, this.date, this.doctorId});

  factory AvailableSlotRequestModel.fromJson(Map<String, dynamic> json) =>
      AvailableSlotRequestModel(
        day: json["day"],
        date: json["date"],
        doctorId: json["doctorId"],
      );

  Map<String, dynamic> toJson() => {
    "day": day,
    "date": date,
    "doctorId": doctorId,
  };
}

class BookAppoinmentReponerseedModel {
  bool? status;
  String? message;
  int? bookingId;

  BookAppoinmentReponerseedModel({this.status, this.message, this.bookingId});

  factory BookAppoinmentReponerseedModel.fromJson(Map<String, dynamic> json) =>
      BookAppoinmentReponerseedModel(
        status: json["status"],
        message: json["message"],
        bookingId: json["bookingId"],
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "bookingId": bookingId,
  };
}

class BookAppoinmentRequestdModel {
  String? date;
  String? day;
  String? availableTime;
  String? forWhom;
  String? name;
  int? age;
  String? number;
  String? gender;
  String? problem;
  int? doctorId;
  int? memberId;

  BookAppoinmentRequestdModel({
    this.date,
    this.day,
    this.availableTime,
    this.forWhom,
    this.name,
    this.age,
    this.number,
    this.gender,
    this.problem,
    this.doctorId,
    this.memberId,
  });

  factory BookAppoinmentRequestdModel.fromJson(Map<String, dynamic> json) =>
      BookAppoinmentRequestdModel(
        date: json["date"],
        day: json["day"],
        availableTime: json["availableTime"],
        forWhom: json["forWhom"],
        name: json["name"],
        age: json["age"],
        number: json["number"],
        gender: json["gender"],
        problem: json["problem"],
        doctorId: json["doctorId"],
        memberId: json["memberId"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (date != null && date!.isNotEmpty) data["date"] = date;
    if (day != null && day!.isNotEmpty) data["day"] = day;
    if (availableTime != null && availableTime!.isNotEmpty) {
      data["availableTime"] = availableTime;
    }
    if (forWhom != null && forWhom!.isNotEmpty) data["forWhom"] = forWhom;
    if (name != null && name!.isNotEmpty) data["name"] = name;
    if (age != null && age != 0) data["age"] = age;
    if (number != null && number!.isNotEmpty) data["number"] = number;
    if (gender != null && gender!.isNotEmpty) data["gender"] = gender;
    if (problem != null && problem!.isNotEmpty) data["problem"] = problem;
    if (doctorId != null && doctorId != 0) data["doctorId"] = doctorId;
    if (memberId != null && memberId != 0) data["memberId"] = memberId;

    return data;
  }
}

class BookingListResponseModel {
  bool? status;
  String? message;
  List<BookingList>? data;

  BookingListResponseModel({this.status, this.message, this.data});

  factory BookingListResponseModel.fromJson(Map<String, dynamic> json) =>
      BookingListResponseModel(
        status: json["status"],
        message: json["message"],
        data:
            json["data"] == null
                ? []
                : List<BookingList>.from(
                  json["data"]!.map((x) => BookingList.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data":
        data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class BookingList {
  int? id;
  String? bookingId;
  String? date;
  String? day;
  String? availableTime;
  String? forWhom;
  String? name;
  String? age;
  String? number;
  String? gender;
  String? problem;
  int? userId;
  int? doctorId;
  String? image;
  String? status;
  String? doctorName;
  String? doctorImage;
  String? doctorJobTitle;
  DateTime? createdAt;
  DateTime? updatedAt;

  BookingList({
    this.id,
    this.bookingId,
    this.date,
    this.day,
    this.availableTime,
    this.forWhom,
    this.name,
    this.age,
    this.number,
    this.gender,
    this.problem,
    this.userId,
    this.doctorId,
    this.image,
    this.status,
    this.doctorName,
    this.doctorImage,
    this.doctorJobTitle,
    this.createdAt,
    this.updatedAt,
  });

  factory BookingList.fromJson(Map<String, dynamic> json) => BookingList(
    id: json["id"],
    bookingId: json["bookingId"],
    date: json["date"],
    day: json["day"],
    availableTime: json["availableTime"],
    forWhom: json["forWhom"],
    name: json["name"],
    age: json["age"],
    number: json["number"],
    gender: json["gender"],
    problem: json["problem"],
    userId: json["userId"],
    doctorId: json["doctorId"],
    image: json["image"],
    status: json["status"],
    doctorName: json["doctorName"],
    doctorImage: json["doctorImage"],
    doctorJobTitle: json["doctorJobTitle"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bookingId": bookingId,
    "date": date,
    "day": day,
    "availableTime": availableTime,
    "forWhom": forWhom,
    "name": name,
    "age": age,
    "number": number,
    "gender": gender,
    "problem": problem,
    "userId": userId,
    "doctorId": doctorId,
    "image": image,
    "status": status,
    "doctorName": doctorName,
    "doctorImage": doctorImage,
    "doctorJobTitle": doctorJobTitle,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class BookingDetailsResponseModel {
  bool? status;
  String? message;
  BookingDetail? data;

  BookingDetailsResponseModel({this.status, this.message, this.data});

  factory BookingDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      BookingDetailsResponseModel(
        status: json["status"],
        message: json["message"],
        data:
            json["data"] == null ? null : BookingDetail.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class BookingDetail {
  int? id;
  String? bookingId;
  String? date;
  String? day;
  String? availableTime;
  String? forWhom;
  String? name;
  String? age;
  String? number;
  String? gender;
  String? problem;
  int? userId;
  int? doctorId;
  String? image;
  String? status;
  DateTime? createdAt;
  dynamic updatedAt;

  BookingDetail({
    this.id,
    this.bookingId,
    this.date,
    this.day,
    this.availableTime,
    this.forWhom,
    this.name,
    this.age,
    this.number,
    this.gender,
    this.problem,
    this.userId,
    this.doctorId,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory BookingDetail.fromJson(Map<String, dynamic> json) => BookingDetail(
    id: json["id"],
    bookingId: json["bookingId"],
    date: json["date"],
    day: json["day"],
    availableTime: json["availableTime"],
    forWhom: json["forWhom"],
    name: json["name"],
    age: json["age"],
    number: json["number"],
    gender: json["gender"],
    problem: json["problem"],
    userId: json["userId"],
    doctorId: json["doctorId"],
    image: json["image"],
    status: json["status"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bookingId": bookingId,
    "date": date,
    "day": day,
    "availableTime": availableTime,
    "forWhom": forWhom,
    "name": name,
    "age": age,
    "number": number,
    "gender": gender,
    "problem": problem,
    "userId": userId,
    "doctorId": doctorId,
    "image": image,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt,
  };
}
