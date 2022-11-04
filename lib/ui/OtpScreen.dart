import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:numerology_yantra/helper/api_helper.dart';
import 'package:numerology_yantra/model/OtpVerifyDataModel.dart';
import 'package:numerology_yantra/ui/dashboard.dart';
import 'package:numerology_yantra/utils/AppColors.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';



class OtpScreen extends StatefulWidget {
  String  phone="";
  OtpScreen(this.phone) ;

  @override
  State<OtpScreen> createState() => _OtpScreen(this.phone);
}



class _OtpScreen extends State<OtpScreen> {
  String phone="";
  String trimmed ="";
  String strPin = "";
  late SharedPreferences prefs;


  _OtpScreen(this.phone);

  var _otp_verify_api = APIHelper.BASE_URL+"otp-verify";

  Future<String> otpVerifyapi(String otp,String mobile) async {
    prefs = await SharedPreferences.getInstance();
    var response = await post(Uri.parse(_otp_verify_api),
        body: {
          "otp": otp,
          "mobile": mobile,
        });

    var resBody = json.decode(response.body);
    final apiResponse = OtpVerifyDataModel.fromJson(resBody);
    setState(() {
      if (apiResponse.status == true) {
        prefs.setBool("isLogin", true);
        prefs.setString("token", apiResponse.accessToken.toString());


        Fluttertoast.showToast(
            msg:apiResponse.message.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>DashboardScreen()));

      }else{

        Fluttertoast.showToast(
            msg:apiResponse.message.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      EasyLoading.dismiss();

    });


    print('register response:${apiResponse.message}');
    return "Success";
  }


  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;

  @override
  void initState()  {
    super.initState();


    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();

    phone = this.phone;
    trimmed = phone.substring(phone.length - 4);
    print("TRIM"+trimmed);
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    EasyLoading.dismiss();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
        EdgeInsets.symmetric(horizontal: (20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.10),
              Text(
                "OTP Verification",
                style:TextStyle(
                  fontSize: (28),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.5,
                ),
              ),
              Text("We sent your code to ***"+trimmed),
              buildTimer(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  OTPTextField(
                    length: 4,
                    width: MediaQuery.of(context).size.width*0.75,
                    fieldWidth: 50,
                    style: TextStyle(
                        fontSize: 17
                    ),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.underline,
                    onCompleted: (pin) {

                      strPin =pin.toString();
                      print("Completed: " + strPin);
                    },
                  ),
    //               SizedBox(
    //                 width: (60),
    //                 child: TextFormField(
    //                   autofocus: true,
    //                   obscureText: true,
    //                   style: TextStyle(fontSize: 24),
    //                   keyboardType: TextInputType.number,
    //                   textAlign: TextAlign.center,
    //                   decoration:  InputDecoration(
    //                     contentPadding:
    //                     EdgeInsets.symmetric(vertical: (15)),
    //                     border:OutlineInputBorder(
    //                       borderRadius: BorderRadius.circular((15)),
    //                       borderSide: BorderSide(color: AppColors.blue_10),
    //                     ),
    //                     focusedBorder:OutlineInputBorder(
    //                       borderRadius: BorderRadius.circular((15)),
    //                       borderSide: BorderSide(color: AppColors.blue_10),
    //                     ),
    //                     enabledBorder: OutlineInputBorder(
    //                       borderRadius: BorderRadius.circular((15)),
    //                       borderSide: BorderSide(color: AppColors.blue_10),
    //                     ),
    //                   ),
    //                   onChanged: (value) {
    //                     nextField(value, pin2FocusNode);
    //                   },
    //                 ),
    //               ),
    //               SizedBox(
    //                 width: (60),
    //                 child: TextFormField(
    //                   focusNode: pin2FocusNode,
    //                   obscureText: true,
    //                   style: TextStyle(fontSize: 24),
    //                   keyboardType: TextInputType.number,
    //                   textAlign: TextAlign.center,
    //                   decoration: InputDecoration(
    //                     contentPadding:
    //                     EdgeInsets.symmetric(vertical: (15)),
    //                     border: OutlineInputBorder(
    //                       borderRadius: BorderRadius.circular((15)),
    //                       borderSide: BorderSide(color: AppColors.blue_10),
    //                     ),
    //                     focusedBorder: OutlineInputBorder(
    //                       borderRadius: BorderRadius.circular((15)),
    //                       borderSide: BorderSide(color: AppColors.blue_10),
    //                     ),
    //                     enabledBorder: OutlineInputBorder(
    //                       borderRadius: BorderRadius.circular((15)),
    //                       borderSide: BorderSide(color: AppColors.blue_10),
    //                     ),
    //                   ),
    //                   onChanged: (value) => nextField(value, pin3FocusNode),
    //                 ),
    //               ),
    //               SizedBox(
    //                 width: (60),
    //                 child: TextFormField(
    //                   focusNode: pin3FocusNode,
    //                   obscureText: true,
    //                   style: TextStyle(fontSize: 24),
    //                   keyboardType: TextInputType.number,
    //                   textAlign: TextAlign.center,
    //                   decoration: InputDecoration(
    //                     contentPadding:
    //                     EdgeInsets.symmetric(vertical: (15)),
    //                     border: OutlineInputBorder(
    //                       borderRadius: BorderRadius.circular((15)),
    //                       borderSide: BorderSide(color: AppColors.blue_10),
    //                     ),
    //                     focusedBorder: OutlineInputBorder(
    //                       borderRadius: BorderRadius.circular((15)),
    //                       borderSide: BorderSide(color: AppColors.blue_10),
    //                     ),
    //                     enabledBorder: OutlineInputBorder(
    //                       borderRadius: BorderRadius.circular((15)),
    //                       borderSide: BorderSide(color: AppColors.blue_10),
    //                     ),
    //                   ),
    //                   onChanged: (value) => nextField(value, pin4FocusNode),
    //                 ),
    //               ),
    //               SizedBox(
    //                 width: (60),
    //                 child: TextFormField(
    //                   focusNode: pin4FocusNode,
    //                   obscureText: true,
    //                   style: TextStyle(fontSize: 24),
    //                   keyboardType: TextInputType.number,
    //                   textAlign: TextAlign.center,
    //                   decoration: InputDecoration(
    // contentPadding:
    // EdgeInsets.symmetric(vertical: (15)),
    // border: OutlineInputBorder(
    // borderRadius: BorderRadius.circular((15)),
    // borderSide: BorderSide(color: AppColors.blue_10),
    // ),
    // focusedBorder: OutlineInputBorder(
    // borderRadius: BorderRadius.circular((15)),
    // borderSide: BorderSide(color: AppColors.blue_10),
    // ),
    // enabledBorder: OutlineInputBorder(
    // borderRadius: BorderRadius.circular((15)),
    // borderSide: BorderSide(color: AppColors.blue_10),
    // ),
    // ),
    //                   onChanged: (value) {
    //                     if (value.length == 1) {
    //                       pin4FocusNode!.unfocus();
    //                       // Then you need to check is the code is correct or not
    //                     }
    //                   },
    //                 ),
    //               ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),

              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              GestureDetector(
                onTap: () {
                  // OTP code resend
                },
                child: Text(
                  "Resend OTP Code",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),


              ),
              Center(
                child: Container(
                    margin: EdgeInsets.only(top: 30),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFA3D133),
                        onPrimary: Colors.white,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0)),
                        minimumSize: Size(180, 50), //////// HERE
                      ),
                      onPressed: () {
                        setState(() {
                          otpVerifyapi(strPin,phone);
                        });
                      },

                        child:  Container(
                            child: Text("Continue", style: TextStyle(fontSize: 18, color: Colors.white)),
                          ),

                      ),

                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: Duration(seconds: 30),
          builder: (_, dynamic value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: AppColors.mainGreen),
          ),
        ),
      ],
    );

  }
}