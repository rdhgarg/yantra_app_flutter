import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:numerology_yantra/helper/api_helper.dart';
import 'package:numerology_yantra/model/RegisterModelData.dart';
import 'package:numerology_yantra/ui/OtpScreen.dart';
import 'package:numerology_yantra/ui/login_screen.dart';
import '../utils/AppColors.dart';
import '../utils/AppUtils.dart';



class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreen();

}

class _SignUpScreen extends State<SignUpScreen> {

  TextEditingController fnameController = new TextEditingController();
  TextEditingController lnameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController cpasswordController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  var _register_api = APIHelper.BASE_URL+"register";
  var android_token = "";
  var ios_token = "";
  late FirebaseMessaging messaging;

/*  * *
  * * * Register API (onSuccess=> Redirect to Home Screen
  * **/


  Future<String> registerViaMobileapi(String name,String email,String  mobile) async {
    var response = await post(Uri.parse(_register_api),
        body: {
          "name": name,
          "email": email,
          "mobile": mobile,
          "device_key_android": android_token,
        });

    var resBody = json.decode(response.body);
    final apiResponse = RegisterModelData.fromJson(resBody);
    setState(() {
      if (apiResponse.status == true) {

        Fluttertoast.showToast(
            msg:apiResponse.message.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);

        String phoneNo = apiResponse.mobile.toString();
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => OtpScreen(phoneNo)));

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


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: 0),
          child: SingleChildScrollView(

            child :Container(
              color: Colors.white,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child:  Container(
                      height: 60,

                      decoration: const BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage("assets/images/bgimage.png"),fit: BoxFit.fill,
                        ),
                      ),
                    ),

                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 50,left: 30),
                    child:Text('SignUp',style:TextStyle(fontSize: 24,color: Color(0xFFA3D133),fontWeight: FontWeight.bold)),
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 10,left: 30),

                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: 'Create Your Account now ', style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )

                    // child: new Text('Welcome back! Signin to your account',textAlign: TextAlign.start, style: TextStyle(fontSize: 16,color: Colors.black)),
                  ),

                  SizedBox(
                    width: 70,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: AppColors.black,
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 10,left: 30),



                    ),
                  ),


                  Container(
                    margin: EdgeInsets.only(top: 50,left: 30,right: 30),
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller:fnameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                    ),
                  ),





                  Container(
                    margin: EdgeInsets.only(top: 10,left: 30,right: 30),
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller:emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email Address',
                      ),
                    ),
                  ),


                  Container(
                    margin: EdgeInsets.only(top: 10,left: 30,right: 30),
                    padding:  EdgeInsets.all(10),
                    child: TextField(
                      controller:phoneController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]')),],
                      decoration:  InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone Number',
                      ),
                    ),
                  ),


                  Center(
                    child: Container(
                        margin: EdgeInsets.only(top: 50),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary:  Color(0xFFA3D133),
                            onPrimary: Colors.white,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                            minimumSize: Size(180, 50), //////// HERE
                          ),
                          onPressed: () {
                            if(fnameController.text.isEmpty){
                              AppUtils.showToastView("Please enter name");
                            }else if(emailController.text.isEmpty){
                              AppUtils.showToastView("Please enter email");
                            }else if(!AppUtils.isEmail(emailController.text)){
                              AppUtils.showToastView("Please enter valid email address");
                            }else if(phoneController.text.isEmpty){
                              AppUtils.showToastView("Please enter phone number");
                            } else{
                              EasyLoading.show(status: 'loading...');

                              registerViaMobileapi(fnameController.text.toString().trim(),emailController.text.toString().trim(),phoneController.text.toString().trim());
                            }
                          },

                          child: Text('Register Now',style:TextStyle(fontSize: 18,color: Colors.white)),
                        )
                    ),
                  ),


                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      child:Text('Forgot Password?',style:TextStyle( decoration: TextDecoration.underline,fontSize: 14,color:Colors.black,fontWeight: FontWeight.bold)),

                    ),
                  ),



                  SizedBox(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Padding(
                          padding: EdgeInsets.only(bottom: 30.0,top: 30),

                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: 'Already have an account? ',style: TextStyle(fontSize: 16,color: Colors.black)),
                                TextSpan(
                                    text: 'Login',
                                    style: TextStyle(decoration: TextDecoration.underline,fontSize: 16,color: Color(0xFFA3D133)),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                           Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                                      }),

                                TextSpan(text: ' Now', style: TextStyle(fontSize: 16,color: Colors.black)),
                              ],
                            ),
                          )

                      ),
                    ),

                  ),

                  SizedBox(height: 20),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
