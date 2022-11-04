import 'dart:async';
import 'package:flutter/services.dart';
import 'package:numerology_yantra/ui/dashboard.dart';
import 'package:numerology_yantra/ui/login_screen.dart';
import 'package:numerology_yantra/utils/AppColors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);


  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {

  String APP_STORE_URL = 'https://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftwareUpdate?id=com.homeservices.bubdiuser&mt=8';
  String PLAY_STORE_URL = 'https://play.google.com/store/apps/details?id=com.homeservices.bubdiuser';
  late bool isLoginUser;



  void _moveToNext(){
    Timer(const Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
     // userid = prefs.getString('userId');
      isLoginUser = (prefs.getBool('isLogin') ?? false);
      print('isLogin $isLoginUser');
      if(isLoginUser == false){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
      }
    });
  }


  @override
  void initState() {
    super.initState();
    _moveToNext();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.mainGreen,
      statusBarBrightness: Brightness.dark,
    ));


    return Scaffold(
      backgroundColor:Colors.white,

      bottomNavigationBar: BottomAppBar(

        child: Container(
          height: 60,
          child:
          Container(
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage(
                    "assets/images/bottombgimage.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
      child:  Container(
          width: MediaQuery.of(context).size.width,
          child: Column(

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

              Image.asset("assets/images/applogo1.png",fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width * 0.80,
                height: MediaQuery.of(context).size.height * 0.50,


              ),

            ],
          ),
        ),
      ),

    );
  }
}
