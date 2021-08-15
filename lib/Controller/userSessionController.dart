// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSessionController extends GetxController{

 bool islogin = false;
 var userEmail = "";


  @override
  void onInit() async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    var islogin = prefs.getBool('isLogin') as bool ;
    islogin ? Get.toNamed('/mapview') :  print('userSession');
    userEmail = prefs.getString('email').toString() == "" ? "" : prefs.getString('email').toString();
    super.onInit();
  }

  updateSession()async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
     prefs.getBool('isLogin') as bool ;
    //islogin ? Get.toNamed('/mapview') :  print('userSession');
    userEmail = prefs.getString('email').toString() == "" ? "" : prefs.getString('email').toString();
    update();
  }


 
    
}