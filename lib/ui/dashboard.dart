import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:numerology_yantra/helper/api_helper.dart';
import 'package:numerology_yantra/model/HomeListModel.dart';
import 'package:numerology_yantra/ui/GenerateReportScreen.dart';
import 'package:numerology_yantra/ui/login_screen.dart';
import 'package:numerology_yantra/utils/AppColors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen> {
  DateTime selectedDate = DateTime.now();
  String date = "";
  String outputDate = "";
  String outputDateShow = "";
  var _product_list = APIHelper.BASE_URL + "get-number";
  List product_list = [];
  List product_list2 = [];
  List product_list1 = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P"];
  late SharedPreferences prefs;
  bool firstBuild = true;
  late BuildContext dialogContext;
  String currentSelectedValue = "";
  String strNumber = "";
  String destiny = "";
  String strBasicNo = "";
  String personal_year_no = "";
  var deviceTypes = ["1", "2", "3", "4", "5", "6", "7", "8", "9"];

  Future<String> _homePageAPI(String dob, String number) async {
    EasyLoading.show(status: 'loading...');
    // await EasyLoading.show(
    //   status: 'loading...',
    //   maskType: EasyLoadingMaskType.black,
    // );

    prefs = await SharedPreferences.getInstance();

    var response = await post(Uri.parse(_product_list), headers: {
      'Authorization': 'Bearer ${prefs.getString("token")}',
    }, body: {
      'dob': dob,
      'number': number
    });

    var resBody = json.decode(response.body.toString());
    final apiResponse = HomeListModel.fromJson(resBody);
    setState(() {
      if (apiResponse.status == true) {
        product_list = resBody['data'];




        destiny = apiResponse.destiny.toString();
        strBasicNo = apiResponse.basic.toString();
        personal_year_no = apiResponse.personalYearNum.toString();

        print("NumberApi" + currentSelectedValue);
        print("===>>" + product_list.toString());
        print("===>>ALPHA" + product_list1.toString());
        print('product.len===>> ${product_list.length}');

      } else {
        Fluttertoast.showToast(
            msg: "server error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
    await EasyLoading.dismiss();
    print('response:${apiResponse.status}');
    return "Success";
  }





  int getLength() {
    return product_list.length;
  }




  @override
  void initState() {
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await  showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1901),
      lastDate: DateTime.now(),
      //lastDate: DateTime(2025),
      helpText: "SELECT DATE",
      cancelText: "NOT NOW",
      confirmText: "OK",
      initialDatePickerMode: DatePickerMode.year,


      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.amberAccent, // <-- SEE HERE
              onPrimary: Colors.redAccent, // <-- SEE HERE
              onSurface: Colors.blueAccent, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },


    );


    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        date = picked.toString();

        var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
        // var date1 = inputFormat.parse('31/12/2000 23:59');
        var inputDate = inputFormat.parse(date); // <-- dd/MM 24H format

        var outputFormat = DateFormat('ddMMyyyy');
        outputDate = outputFormat.format(inputDate);
        print("OUtPUT DATE==>>" + outputDate); // 12/31/2000 11:59 PM <-- MM/dd 12H format

        var outputFormat1 = DateFormat('dd-MM-yyyy');
        outputDateShow = outputFormat1.format(inputDate);
        print("OUtPUT DATE==>>" + outputDateShow);

        // Close progress dialog
        if (firstBuild == false) {
          _homePageAPI(outputDate, "");
          Navigator.pop(dialogContext);
        } else {
          strNumber = currentSelectedValue;

          print("DATE" + outputDate);
          print("NUMBER" + strNumber);
          _homePageAPI(outputDate, "");

        }
      });
    }
  }






  Widget getChildForIndex(String index) {
    String i = "";

    if(index == "1"){
      i = "Job, Promotion ,Leadership,Health,Study,Opportunities";
    }else if(index == "2"){
      i = "Marriage Love Marriage";
    }else if(index == "3"){
      i = "Relaxation,Health";
    }else if(index == "4"){
      i = "Avoid!!";
    }else if(index == "5"){
      i = "Advanture Foreign,Look After the World,Health";
    }else if(index == "6"){
      i = "Marriage, Baby Plan, Saas Bahu/ In laws Problem";
    }else if(index == "7"){
      i = "Spiritualism";
    }else if(index == "8"){
      i = "Money Yantra";
    }else if(index == "9"){
      i = "Army, Police, Sports";
    }

    return Text(i,
        style: TextStyle(
            fontSize: 16,
            color: AppColors.black,
            fontWeight: FontWeight.w600));
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (firstBuild) {
        firstBuild = false;
        _showFirstTimePopup("Abhishek");
      }
    });

    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;
        // show the confirm dialog
        await showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Are you sure want to exit?'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      willLeave = true;
                      //  Navigator.of(context).pop();
                      Navigator.pop(context,
                          true); // It worked for me instead of above line
                      if (Platform.isAndroid) {
                        SystemNavigator.pop();
                      } else if (Platform.isIOS) {
                        exit(0);
                      }
                    },
                    child: const Text('Yes')),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('No'))
              ],
            ));
        return willLeave;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 60,
                  color: AppColors.mainGreen,
                  child: Row(
                    children: [

                      SizedBox(
                        width: 25,
                      ),

                      Expanded(
                        child: Center(
                          child: Text(
                            "Yantra",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            _showLogoutMessagePopup("Are you sure want to logout ?");
                          }, //
                          child: Image.asset(
                            "assets/icons/logout.png",
                            width: 20,
                            height: 20,
                            color: AppColors.white_00,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //Header

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: <Widget>[

                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Text("Date of Birth:",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.mainGreen,
                                      fontWeight: FontWeight.w800)),
                              Text(outputDateShow,
                                  style: TextStyle(fontSize: 16, color: Colors.black)),
                              ElevatedButton(
                                onPressed: () => _selectDate(context),
                                child: Text('Change date',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500)),

                                style: ElevatedButton.styleFrom(
                                    primary: AppColors.mainGreen,
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    textStyle: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                        ),


                        Card(
                          elevation: 10,
                          child :Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 20,right: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Text("Basic : $strBasicNo",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w800)),
                                    ),

                                    Expanded(child:
                                    Text("Destiny : $destiny",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w800),textAlign: TextAlign.end,)),

                                    SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.only(top: 10,left: 20),
                                child: Text('Personal Yantra Number : $personal_year_no',style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w800)),
                              ),

                              Container(
                                margin: EdgeInsets.only(left: 20, right: 20, top: 20,bottom: 20),
                                child: Container(
                                  child: GridView.count(
                                      shrinkWrap: true,
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 4.0,
                                      mainAxisSpacing: 4.0,
                                      physics: const NeverScrollableScrollPhysics(),
                                      children: List.generate(getLength(), (index) {
                                        return InkWell(
                                          child: Container(
                                            color: setColor(index),
                                            child:  Stack(
                                              children: [
                                                Container(
                                                  child: Center(
                                                    child: Text(
                                                      product_list[index].toString(),
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                  ),

                                                ),
                                                Visibility(
                                                  visible:false,
                                                  child: Container(
                                                    margin:EdgeInsets.all(5),
                                                    child: Align(
                                                      alignment: FractionalOffset.bottomRight,
                                                      child: Text(
                                                        product_list1[index].toString(),
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                              ],
                                            ),

                                          ),
                                          onTap: () {

                                          },
                                        );

                                      })),
                                ),
                              ),

                            ],
                          ),

                        ),




                        SizedBox(
                          height: 20.0,
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
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>GenerateReportScreen(outputDate)));
                                },
                                child: Text('Submit',
                                    style: TextStyle(fontSize: 18, color: Colors.white)),
                              )),
                        ),

                        SizedBox(
                          height: 20.0,
                        ),



                      ],
                    ),
                  ),
                ),

              ],
            )


        ),

      ),
    );
  }





  Future<void> _showLogoutMessagePopup(String msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(

          title: Row(
            children: [
              Expanded(
                  child: Text('Message',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black))),
              GestureDetector(
                onTap: () {

                   Navigator.pop(context);
                },
                child: Image.asset(
                  "assets/icons/ic_close.png",
                  width: 25,
                  height: 25,
                ),
              )
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(msg,textAlign:TextAlign.center,style: TextStyle(color: Colors.black),),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                          prefs.clear();
                          Navigator.pop(context);
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const LoginScreen()));
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute( builder: (ctx) => LoginScreen()), (route) => false);
                        },
                        child: Container(
                            width: 80,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              color: AppColors.mainGreen,
                            ),
                            child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Logout',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16)),
                                ))),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }




  Future<void> _showFirstTimePopup(String msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        dialogContext = context;
        return AlertDialog(
          title: Row(
            children: [
              Expanded(
                  child: Text('Please select date of birth',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black))),

            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      // Text("Date of birth:", style:TextStyle(fontSize: 16,color:Colors.black ,fontWeight: FontWeight.bold)),
                      // Text(outputDateShow,),
                      ElevatedButton(

                        onPressed: () => _selectDate(context),
                        child: Text('Select date',
                            textAlign: TextAlign.center,
                            style:
                            TextStyle(fontSize: 14, color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                            primary: AppColors.mainGreen,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            textStyle: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

              ],
            ),
          ),

        );
      },
    );
  }



  Color? setColor(int index) {

    if(index == 0) {
      return AppColors.mainGreen;
    }else if(index == 1) {
      return Colors.lime[300];
    }else if(index == 2) {
      return Colors.yellowAccent;
    }else if(index == 3) {
      return Colors.red;
    }else if(index == 4) {
      return Colors.pink;
    }else if(index == 5) {
      return Colors.lime[300];
    }else if(index == 6) {
      return Colors.yellowAccent;
    }else if(index == 7) {
      return Colors.red;
    }else if(index == 8) {
      return Colors.pink;
    }else if(index == 9) {
      return  Colors.lime[300];
    }else if(index == 10) {
      return Colors.yellowAccent;
    }else if(index == 11) {
      return AppColors.mainGreen;
    }else if(index == 12) {
      return  Colors.pink;
    }else if(index == 13) {
      return Colors.red;
    }else if(index == 14) {
      return  Colors.pink;
    }else if(index == 15) {
      return Colors.yellowAccent;
    }else{
      return AppColors.mainGreen;
    }




  }
}
