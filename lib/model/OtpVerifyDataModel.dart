
class OtpVerifyDataModel{


  bool? status;
  String? accessToken;
  String? tokenType;
  Data? data;
  String? message;

  OtpVerifyDataModel(
  {this.status, this.accessToken, this.tokenType, this.data, this.message});

  OtpVerifyDataModel.fromJson(Map<String, dynamic> json) {
  status = json['status'];
  accessToken = json['access_token'];
  tokenType = json['token_type'];
  data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  message = json['message'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['status'] = this.status;
  data['access_token'] = this.accessToken;
  data['token_type'] = this.tokenType;
  if (this.data != null) {
  data['data'] = this.data!.toJson();
  }
  data['message'] = this.message;
  return data;
  }
  }

  class Data {
  int? id;
  String? name;
  String? email;
  Null? roleId;
  String? mobileNo;
  Null? emailVerifiedAt;
  String? status;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  Null? profileImage;
  String? verifyOtpStatus;
  String? registerOtp;
  Null? deviceToken;
  Null? deviceKey;
  Null? otp;
  Null? walletAmt;

  Data(
  {this.id,
  this.name,
  this.email,
  this.roleId,
  this.mobileNo,
  this.emailVerifiedAt,
  this.status,
  this.createdBy,
  this.createdAt,
  this.updatedAt,
  this.profileImage,
  this.verifyOtpStatus,
  this.registerOtp,
  this.deviceToken,
  this.deviceKey,
  this.otp,
  this.walletAmt});

  Data.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  name = json['name'];
  email = json['email'];
  roleId = json['role_id'];
  mobileNo = json['mobile_no'];
  emailVerifiedAt = json['email_verified_at'];
  status = json['status'];
  createdBy = json['created_by'];
  createdAt = json['created_at'];
  updatedAt = json['updated_at'];
  profileImage = json['profile_image'];
  verifyOtpStatus = json['verify_otp_status'];
  registerOtp = json['register_otp'];
  deviceToken = json['device_token'];
  deviceKey = json['device_key'];
  otp = json['otp'];
  walletAmt = json['wallet_amt'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['name'] = this.name;
  data['email'] = this.email;
  data['role_id'] = this.roleId;
  data['mobile_no'] = this.mobileNo;
  data['email_verified_at'] = this.emailVerifiedAt;
  data['status'] = this.status;
  data['created_by'] = this.createdBy;
  data['created_at'] = this.createdAt;
  data['updated_at'] = this.updatedAt;
  data['profile_image'] = this.profileImage;
  data['verify_otp_status'] = this.verifyOtpStatus;
  data['register_otp'] = this.registerOtp;
  data['device_token'] = this.deviceToken;
  data['device_key'] = this.deviceKey;
  data['otp'] = this.otp;
  data['wallet_amt'] = this.walletAmt;
  return data;
  }


}