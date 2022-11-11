
class HomeListModel {
  bool? status;
  int? destiny;
  int? basic;
  int? personalYearNum;
  List<int>? data;
  List<Desc>? desc;

  HomeListModel({this.status, this.destiny, this.data, this.desc});

  HomeListModel.fromJson(Map<String, dynamic> json) {
  status = json['status'];
  destiny = json['destiny'];
  basic = json['basic'];
  personalYearNum = json['personal_year_no'];
  data = json['data'].cast<int>();
  if (json['desc'] != null) {
  desc = <Desc>[];
  json['desc'].forEach((v) {
  desc!.add(new Desc.fromJson(v));
  });
  }
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['status'] = this.status;
  data['destiny'] = this.destiny;
  data['personal_year_no'] = this.personalYearNum;
  data['basic'] = this.basic;
  data['data'] = this.data;
  if (this.desc != null) {
  data['desc'] = this.desc!.map((v) => v.toJson()).toList();
  }
  return data;
  }
  }

  class Desc {
  String? id;
  String? box;
  String? boxName;
  String? no;
  String? detail;
  String? detailHindi;
  String? createdAt;
  String? updatedAt;


  Desc(
  {this.id,
  this.box,
  this.boxName,
  this.no,
  this.detail,
  this.detailHindi,
  this.createdAt,
  this.updatedAt});

  Desc.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  box = json['box'];
  boxName = json['box_name'];
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
  data['box_name'] = this.boxName;
  data['no'] = this.no;
  data['detail'] = this.detail;
  data['detail_hindi'] = this.detailHindi;
  data['created_at'] = this.createdAt;
  data['updated_at'] = this.updatedAt;
  return data;

  }


  // bool? status;
  // int? destiny;
  // List<int>? data;
  //
  // HomeListModel({this.status,this.destiny,this.data});
  //
  // HomeListModel.fromJson(Map<String, dynamic> json) {
  //   status = json['status'];
  //   destiny = json['destiny'];
  //   data = json['data'].cast<int>();
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   data['destiny'] = this.destiny;
  //   data['data'] = this.data;
  //   return data;
  // }
}