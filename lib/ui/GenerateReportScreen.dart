import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:numerology_yantra/helper/api_helper.dart';
import 'package:numerology_yantra/model/HomeListModel.dart';
import 'package:numerology_yantra/utils/AppColors.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GenerateReportScreen extends StatefulWidget {
  String outputDate = "";

  GenerateReportScreen(this.outputDate) ;

  @override
  State<StatefulWidget> createState() => _GenerateReportScreen(this.outputDate);

}

class _GenerateReportScreen extends State<GenerateReportScreen> {
  DateTime selectedDate = DateTime.now();
  String date = "";
  String outputDate = "";
  String outputDateShow = "";
  var _product_list = APIHelper.BASE_URL + "get-number";
  List product_list = [];
  List product_list2 = [];
  List category_list = [];
  List product_list1 = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P"];
  late SharedPreferences prefs;
  String currentSelectedValue = "";
  String strNumber = "";
  String destiny = "";
  String strBasicNo = "";
  String personal_year_no = "";
  var deviceTypes = ["1", "2", "3", "4", "5", "6", "7", "8", "9"];


  _GenerateReportScreen(this.outputDate);


  Future<String> _homePageAPI(String dob ,String number) async {
    EasyLoading.show(status: 'loading...');
    // await EasyLoading.show(
    //   status: 'loading...',
    //   // maskType: EasyLoadingMaskType.black,
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
        category_list = resBody['desc'];

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

  Future<String> _homePageAPI1(String dob, String number) async {
    EasyLoading.show(status: 'loading...');
    // await EasyLoading.show(
    //   status: 'loading...',
    //    maskType: EasyLoadingMaskType.black,
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
        product_list2 = resBody['data'];
        category_list = resBody['desc'];

        print("NumberApi" + currentSelectedValue);
        print("===>>" + product_list2.toString());
        print("===>>ALPHA" + product_list1.toString());
        print('product.len===>> ${product_list2.length}');

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


  int getLength2() {
    return product_list2.length;
  }


  @override
  void initState() {
    super.initState();

    _homePageAPI(outputDate,"");
  }



  int getLengthDetailCategory() {
    return category_list.length;
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
    return  Scaffold(
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

                      SizedBox(width: 10,),

                      GestureDetector(
                          onTap: () {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            } else {
                              SystemNavigator.pop();
                            }
                          }, //
                          child: Image.asset(
                            "assets/icons/back_icon.png",
                            width: 35,
                            height: 35,
                            color: AppColors.white_00,
                          ),

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

                      SizedBox(width: 20,),
                    ],
                  ),
                ),

                //Header

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: <Widget>[

                        // Container(
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       SizedBox(
                        //         width: 5,
                        //       ),
                        //       Text("Date of Birth:",
                        //           style: TextStyle(
                        //               fontSize: 16,
                        //               color: AppColors.mainGreen,
                        //               fontWeight: FontWeight.w800)),
                        //       Text(outputDateShow,
                        //           style: TextStyle(fontSize: 16, color: Colors.black)),
                        //       ElevatedButton(
                        //         onPressed: () => _selectDate(context),
                        //         child: Text('Change date',
                        //             style: TextStyle(
                        //                 fontSize: 14,
                        //                 color: Colors.white,
                        //                 fontWeight: FontWeight.w500)),
                        //
                        //         style: ElevatedButton.styleFrom(
                        //             primary: AppColors.mainGreen,
                        //             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        //             textStyle: TextStyle(
                        //                 fontSize: 30,
                        //                 fontWeight: FontWeight.bold)),
                        //       ),
                        //       SizedBox(
                        //         width: 5,
                        //       ),
                        //     ],
                        //   ),
                        // ),

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
                                            // if(product_list1[index].toString() == "E" || product_list1[index].toString() == "F" || product_list1[index].toString() == "I"
                                            //     || product_list1[index].toString() == "J" || product_list1[index].toString() == "L"||product_list1[index].toString() == "M"
                                            //     ||product_list1[index].toString() == "O" || product_list1[index].toString() == "P"){
                                            //   print("VALUE==>>"+ product_list[index].toString());
                                            //   print("ALPHABET==>>"+ product_list1[index].toString());
                                            //   _GetReportAPI(product_list1[index].toString(),product_list[index].toString());
                                            // }else{
                                            //
                                            // }
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

                        Card(
                          elevation: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(

                                margin: EdgeInsets.only(top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text("Desired Number: ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w800)),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(currentSelectedValue,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w600)),


                                    Container(

                                      child: DropdownButtonHideUnderline(

                                        child: DropdownButton<String>(
                                          isExpanded: false,
                                          isDense: true,
                                          onChanged: (newValue) {
                                            setState(() {
                                              currentSelectedValue = newValue.toString();
                                              _homePageAPI1(outputDate, currentSelectedValue);
                                            });
                                          },
                                          items: deviceTypes.map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              // child: Text(value),

                                              child: Column(
                                                children: [
                                                  Text(value),
                                                  // Text("(Job, Promotion ,Leadership,Health,Study,Opportunities)",),
                                                  SizedBox(height:10)
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                              ),


                              Container(
                                color: Colors.white,
                                padding: EdgeInsets.all(20.0),
                                child: Table(

                                  columnWidths: {
                                    0: FlexColumnWidth(1),
                                    1: FlexColumnWidth(4),

                                  },
                                  border: TableBorder.all(color: Colors.black),

                                  children: [
                                    TableRow(children: [


                                      Text(' 1', style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),),
                                      Text(' Job, Promotion ,Leadership,Health,Study,Opportunities',style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),

                                    ]),
                                    TableRow(children: [
                                      Text(' 2',style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),),
                                      Text(' Marriage Love Marriage' ,style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),

                                    ]),

                                    TableRow(children: [
                                      Text(' 3',style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),),
                                      Text(' Relaxation,Health' ,style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),

                                    ]),


                                    TableRow(children: [
                                      Text(' 4',style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),),
                                      Text(' Avoid!!' ,style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),

                                    ]),

                                    TableRow(children: [
                                      Text(' 5',style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),),
                                      Text(' Advanture Foreign,Look After the World,Health' ,style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),

                                    ]),

                                    TableRow(children: [
                                      Text(' 6',style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),),
                                      Text(' Marriage, Baby Plan, Saas Bahu/ In laws Problem' ,style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),

                                    ]),


                                    TableRow(children: [
                                      Text(' 7',style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),),
                                      Text(' Spiritualism' ,style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),

                                    ]),


                                    TableRow(children: [
                                      Text(' 8',style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),),
                                      Text(' Money Yantra' ,style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),

                                    ]),


                                    TableRow(children: [
                                      Text(' 9',style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),),
                                      Text(' Army, Police, Sports' ,style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),

                                    ]),
                                  ],
                                ),
                              ),



                              SizedBox(height: 20,),


                              Container(
                                margin: EdgeInsets.only(left: 20,top: 10),
                                child:  getChildForIndex(currentSelectedValue),
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
                                      children: List.generate(getLength2(), (index) {
                                        return InkWell(
                                          child: Container(
                                            color: setColor(index),
                                            child:  Stack(
                                              children: [
                                                Container(
                                                  child: Center(
                                                    child: Text(
                                                      product_list2[index].toString(),
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
                                            // if(product_list1[index].toString() == "E" || product_list1[index].toString() == "F" || product_list1[index].toString() == "I"
                                            //     || product_list1[index].toString() == "J" || product_list1[index].toString() == "L"||product_list1[index].toString() == "M"
                                            //     ||product_list1[index].toString() == "O" || product_list1[index].toString() == "P"){
                                            //   print("VALUE==>>"+ product_list[index].toString());
                                            //   print("ALPHABET==>>"+ product_list1[index].toString());
                                            //   _GetReportAPI(product_list1[index].toString(),product_list[index].toString());
                                            // }else{
                                            //
                                            // }
                                          },
                                        );

                                      })),
                                ),
                              ),

                            ],
                          ),
                        ),

                        SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.only(left: 15,right: 15),
                          child:  _detailListWidget(),
                        ),

                        SizedBox(height: 20),

                      ],
                    ),
                  ),
                ),

              ],
            )


        ),

      );

  }


  Widget _detailListWidget(){

    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child:ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: getLengthDetailCategory(),
          itemBuilder: _detailListItemBuilder,
        )
    );
  }

  Widget _detailListItemBuilder(BuildContext context, int index) {

    return InkWell(
      child: GestureDetector(
        onTap: () {

        },
        child: Card(
          elevation: 10,
          child: InkWell(
            child: Container(
              padding: EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 18),
                        child: Text("Box :",
                            style: TextStyle(
                                fontSize: 18,
                                color: AppColors.black,
                                fontWeight: FontWeight.w600)),

                      ),

                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(category_list[index]['box_name'],
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.only(left: 18),
                    child: Text(category_list[index]['detail'],
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColors.black,
                            fontWeight: FontWeight.w400)),
                  ),



                  SizedBox(height: 10,),

                  Container(
                    margin: EdgeInsets.only(left: 18),
                    child: Text(category_list[index]['detail_hindi'],
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColors.black,
                            fontWeight: FontWeight.w400)),
                  ),


                  SizedBox(height: 20,)

                ],
              ),

            ),
          ),
        ),
      ),
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
