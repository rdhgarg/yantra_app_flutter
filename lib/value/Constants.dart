
import 'package:flutter/material.dart';
import 'package:numerology_yantra/utils/AppColors.dart';


var buttonDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(12),
  color: AppColors.mainOrange
);

var testInputDecoration = InputDecoration(
  filled: true,
  fillColor: AppColors.lightGrey,
  isDense: true,
  hintStyle: TextStyle(color: AppColors.mainGreen,fontFamily: "Averta-regular", fontSize: 15),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
    borderSide: BorderSide(color: AppColors.mainGreen.withOpacity(0.5),width: 0.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
    borderSide: BorderSide(color: AppColors.mainGreen.withOpacity(0.5),width: 0.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
    borderSide: BorderSide(color: AppColors.mainGreen,width: 1.0),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
    borderSide: BorderSide(color: AppColors.mainGreen,width: 1.0),
  ),
);


var testInputDecoration2 = InputDecoration(
  filled: true,
  fillColor: AppColors.lightGrey,
  hintStyle: TextStyle(color: AppColors.textGrey,fontFamily: "Poppins-Regular", fontSize: 14,),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
    borderSide: BorderSide(color: AppColors.mainBlack.withOpacity(0.5),width: 1.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
    borderSide: BorderSide(color: AppColors.mainBlack.withOpacity(0.5),width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
    borderSide: BorderSide(color: AppColors.mainOrange,width: 1.0),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
    borderSide: BorderSide(color: AppColors.red_00,width: 1.0),
  ),
);
