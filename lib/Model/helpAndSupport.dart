// ignore_for_file: file_names

class HelpAndSupportModel {
  String? mobileNumber;
  String? name;
  String? problemType;
  String? problem;

  HelpAndSupportModel({
    this.mobileNumber,
    this.name,
    this.problemType,
    this.problem,
  });

  factory HelpAndSupportModel.fromJson(Map<String, dynamic> json) =>
      HelpAndSupportModel(
        mobileNumber: json["mobileNumber"],
        name: json["name"],
        problemType: json["problemType"],
        problem: json["problem"],
      );

  Map<String, dynamic> toJson() => {
    "mobileNumber": mobileNumber,
    "name": name,
    "problemType": problemType,
    "problem": problem,
  };
}
