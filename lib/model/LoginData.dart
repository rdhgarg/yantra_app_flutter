class LoginData {
  bool? status;
  String? accessToken;
  String? tokenType;
  Data? data;
  String? message;
  String? mobile;

  LoginData(
      {this.status, this.accessToken, this.tokenType, this.data, this.message,this.mobile});

  LoginData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    mobile = json['mobile'];
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
    data['mobile'] = this.mobile;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? roleId;
  String? mobileNo;
  Null? emailVerifiedAt;
  int? status;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  Null? profileImage;
  Null? otp;
  String? walletAmt;
  Null? deviceKeyAndroid;
  Null? deviceKeyIos;

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
        this.otp,
        this.walletAmt,
        this.deviceKeyAndroid,
        this.deviceKeyIos});

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
    otp = json['otp'];
    walletAmt = json['wallet_amt'];
    deviceKeyAndroid = json['device_key_android'];
    deviceKeyIos = json['device_key_ios'];
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
    data['otp'] = this.otp;
    data['wallet_amt'] = this.walletAmt;
    data['device_key_android'] = this.deviceKeyAndroid;
    data['device_key_ios'] = this.deviceKeyIos;
    return data;
  }
}

