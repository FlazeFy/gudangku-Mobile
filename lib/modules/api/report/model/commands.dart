import 'dart:convert';

class PutReportDetailModel {
  String reportTitle;
  String? reportDesc;
  String reportCategory;

  PutReportDetailModel({
    required this.reportTitle,
    this.reportDesc,
    required this.reportCategory,
  });

  Map<dynamic, dynamic> toJson() {
    return {
      "report_title": reportTitle,
      "report_category": reportCategory,
      "report_desc": reportDesc,
    };
  }
}

String reportDetailModelToJson(PutReportDetailModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
