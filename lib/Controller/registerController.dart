import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController{

 bool _showPassword = true;
 var auth;

 bool get showPassword {
   return _showPassword;
 }

  @override
  void onInit() async{
    await Firebase.initializeApp();
    auth = FirebaseAuth.instance;
    super.onInit();
  }

 updateShowPassword(){
   _showPassword = !_showPassword;
   update();
 }

 postUser({required String mail,required String password,required String userName})async{
      try {
     UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: mail,password: password);
      Get.toNamed('/login');
      Get.snackbar('', '${userCredential.additionalUserInfo?.username} !!',backgroundColor: Colors.orange[200]);
      Get.snackbar('Registration Status', 'Successful !!',backgroundColor: Colors.orange[200]);
      var data= {
        'userEmail' : mail,
        'userName' : userName
      };
      FirebaseFirestore.instance.collection('users').add(data);
      // UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      //   email: mail,
      //   password: password
      // );
    } on FirebaseAuthException catch (e) {
        Get.snackbar('error', '$e',backgroundColor: Colors.orange[200]);
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
    }
    }
    
}