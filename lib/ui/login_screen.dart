import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart';
import 'package:numerology_yantra/helper/api_helper.dart';
import 'package:numerology_yantra/model/LoginData.dart';
import 'package:numerology_yantra/ui/OtpScreen.dart';
import 'package:numerology_yantra/ui/SignUpScreen.dart';
import 'package:numerology_yantra/ui/dashboard.dart';
import 'package:numerology_yantra/utils/AppColors.dart';
import 'package:numerology_yantra/utils/Strings.dart';
import 'package:numerology_yantra/value/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/AppUtils.dart';




class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  bool isLoading = false;
  late SharedPreferences prefs;
  var _login_api = APIHelper.BASE_URL + "login";
  var res_status;
  var android_token = "";
  var ios_token = "";
  late FirebaseMessaging messaging;

/*  * *
  * * * Login API (onSuccess=> Redirect to Home Screen
  * **/

  Future<String> loginViaMobileapi(String email, String password) async {
    prefs = await SharedPreferences.getInstance();
    var response = await post(Uri.parse(_login_api), body: {
      "mobile": email,

    });

    var resBody = json.decode(response.body);
    final apiResponse = LoginData.fromJson(resBody);
    setState(() {
      if (apiResponse.status == true) {

        Fluttertoast.showToast(
            msg:apiResponse.message.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);


        prefs.setString("android_token", android_token);
        prefs.setBool("isLogin", true);
        /*prefs.setString("userId", apiResponse.data!.id.toString());
        prefs.setString("name", apiResponse.data!.name.toString());
        prefs.setString("email", apiResponse.data!.email.toString());
        prefs.setString("number", apiResponse.data!.mobileNo.toString());
        prefs.setString("image", apiResponse.data!.profileImage.toString());*/
        prefs.setString("token", apiResponse.accessToken.toString());


        String phoneNo = apiResponse.mobile.toString();

        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>OtpScreen(phoneNo,"login")));
      } else {
        Fluttertoast.showToast(
            msg: apiResponse.message.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      EasyLoading.dismiss();
    });

    print('login response:${apiResponse.message}');
    return "Success";
  }

  @override
  void initState() {
    super.initState();
      messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value){
      print('fcm token : ${value}');
      if(Platform.isAndroid){
        android_token=value.toString();
      }else if(Platform.isIOS){
        ios_token=value.toString();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    EasyLoading.dismiss();
  }

/*  loginUser(){

    setState(() {
      isLoading = true;
    });


    CollectionReference ref = fireStore.collection("Users");
    ref.
    where("email", isEqualTo: emailController.text).
    where("password", isEqualTo: passwordController.text).
    limit(1).
    get().then((value) async {

      if(value.docs.isNotEmpty){
        var documentData = value.docs[0];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("userId", documentData.id);
        prefs.setString("number", documentData['number']);
        prefs.setString("name", documentData['name']);
        prefs.setString("email", documentData['email']);
        prefs.setString("latitude", documentData['latitude']);
        prefs.setString("longitude", documentData['longitude']);

        prefs.setString("view_type", "5");

     //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));

        setState(() {
          isLoading = false;
        });
      }
      else{
        Fluttertoast.showToast(
            msg: "Invalid number or password !",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

        setState(() {
          isLoading = false;
        });

      }

    });
  }*/

  final formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          // height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Container(
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage("assets/images/bgimage.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 50, left: 30),
                child: Text('Log in',
                    style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFFA3D133),
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 10, left: 30),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: Strings.welcome_back,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: Strings.signin_to_your_account,
                            style:
                                TextStyle(fontSize: 18, color: Colors.black)),
                      ],
                    ),
                  )),
              SizedBox(
                width: 70,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: AppColors.black,
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 10, left: 30),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.18,
                    left: 30,
                    right: 30),
                width: MediaQuery.of(context).size.width * 0.88,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: emailController,
                  decoration: testInputDecoration.copyWith(
                    hintText: "Phone Number",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Phone Number";
                    }
                    return null;
                  },
                ),
              ),
              // Container(
              //   margin: EdgeInsets.only(top: 20, left: 30, right: 30),
              //   width: MediaQuery.of(context).size.width * 0.88,
              //   child: TextFormField(
              //     keyboardType: TextInputType.text,
              //     controller: passwordController,
              //     obscureText: !_passwordVisible,
              //     //This will obscure text dynamically
              //     decoration: testInputDecoration.copyWith(
              //       hintText: "Password",
              //       // Here is key idea
              //       suffixIcon: IconButton(
              //         icon: Icon(
              //           // Based on passwordVisible state choose the icon
              //           _passwordVisible
              //               ? Icons.visibility
              //               : Icons.visibility_off,
              //           color: AppColors.mainGreen,
              //         ),
              //         onPressed: () {
              //           // Update the state i.e. toogle the state of passwordVisible variable
              //           setState(() {
              //             _passwordVisible = !_passwordVisible;
              //           });
              //         },
              //       ),
              //     ),
              //
              //     validator: (value) {
              //       if (value!.isEmpty) {
              //         return "Please Enter Your Password";
              //       }
              //       return null;
              //     },
              //   ),
              // ),
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
                          if (emailController.text.isEmpty) {
                            AppUtils.showToastView(Strings.please_enter_phone_number);
                          } /*else if (!AppUtils.isEmail(emailController.text)) {
                            AppUtils.showToastView(
                                Strings.please_enter_valid_email_address);
                          } else if (passwordController.text.isEmpty) {
                            AppUtils.showToastView(
                                Strings.please_enter_password);
                          } else if (passwordController.text.length <= 7) {
                            AppUtils.showToastView(Strings
                                .Please_enter_password_atleast_7_character);
                          }*/ else {
                            EasyLoading.show(status: 'loading...');
                            loginViaMobileapi(
                                emailController.text.toString().trim(),"");
                          }
                        });
                      },
                      child: Text(Strings.login_now,
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    )),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 20, left: 0),
                  child: Text(Strings.forgot_password_quesmark,
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Padding(
                        padding: EdgeInsets.only(top: 40.0),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'New User? Just ',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
                              TextSpan(
                                  text: 'Sign Up',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: 13,
                                      color: Color(0xFFA3D133),
                                      fontWeight: FontWeight.w500),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      //Navigator.pushNamed(context, SignUpScreen.routeName);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignUpScreen()));
                                    }),

                              /*  TextSpan(text: ' Now', style: TextStyle(fontSize: 16,color: Colors.black)),*/
                            ],
                          ),
                        )),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
