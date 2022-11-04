
class RegisterModelData {

  bool? status;
  String? message;
  String? verifyOtpStatus;
  String? mobile = "";

  RegisterModelData({this.status, this.message, this.verifyOtpStatus, this.mobile});

  RegisterModelData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    verifyOtpStatus = json['verify_otp_status'].toString();
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['verify_otp_status'] = this.verifyOtpStatus;
    data['mobile'] = this.mobile;
    return data;
  }


  // bool? status;
  // String? message;
  // String? verifyOtpStatus;
  // String? mobile;
  //
  // RegisterModelData({this.status, this.message, this.verifyOtpStatus, this.mobile});
  //
  // RegisterModelData.fromJson(Map<String, dynamic> json) {
  // status = json['status'];
  // message = json['message'];
  // verifyOtpStatus = json['verify_otp_status'];
  // mobile = json['mobile'];
  // }
  //
  // Map<String, dynamic> toJson() {
  // final Map<String, dynamic> data = new Map<String, dynamic>();
  // data['status'] = this.status;
  // data['message'] = this.message;
  // data['verify_otp_status'] = this.verifyOtpStatus;
  // data['mobile'] = this.mobile;
  // return data;
  // }


}