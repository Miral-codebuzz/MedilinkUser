class DocumentsResponseModel {
  bool? status;
  String? message;
  List<DocumentsList>? data;

  DocumentsResponseModel({this.status, this.message, this.data});

  factory DocumentsResponseModel.fromJson(Map<String, dynamic> json) =>
      DocumentsResponseModel(
        status: json["status"],
        message: json["message"],
        data:
            json["data"] == null
                ? []
                : List<DocumentsList>.from(
                  json["data"]!.map((x) => DocumentsList.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data":
        data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DocumentsList {
  int? id;
  String? document;
  DocumentType? documentType;

  DocumentsList({this.id, this.document, this.documentType});

  factory DocumentsList.fromJson(Map<String, dynamic> json) => DocumentsList(
    id: json["id"],
    document: json["document"],
    documentType: documentTypeValues.map[json["documentType"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "document": document,
    "documentType": documentTypeValues.reverse[documentType],
  };
}

enum DocumentType { INSURANCE, REPORT }

final documentTypeValues = EnumValues({
  "insurance": DocumentType.INSURANCE,
  "report": DocumentType.REPORT,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
