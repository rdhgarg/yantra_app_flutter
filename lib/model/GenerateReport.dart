
class GenerateReport {


  bool? status;
  Data? data;
  String? baseUrl;

  GenerateReport({this.status, this.data, this.baseUrl});

  GenerateReport.fromJson(Map<String, dynamic> json) {
  status = json['status'];
  data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  baseUrl = json['base_url'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['status'] = this.status;
  if (this.data != null) {
  data['data'] = this.data!.toJson();
  }
  data['base_url'] = this.baseUrl;
  return data;
  }
  }

  class Data {
  String? id;
  String? box;
  String? no;
  String? detail;
  String? detailHindi;
  String? createdAt;
  String? updatedAt;

  Data(
  {this.id,
  this.box,
  this.no,
  this.detail,
  this.detailHindi,
  this.createdAt,
  this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  box = json['box'];
  no = json['no'];
  detail = json['detail'];
  detailHindi = json['detail_hindi'];
  createdAt = json['created_at'];
  updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['box'] = this.box;
  data['no'] = this.no;
  data['detail'] = this.detail;
  data['detail_hindi'] = this.detailHindi;
  data['created_at'] = this.createdAt;
  data['updated_at'] = this.updatedAt;
  return data;
  }


}