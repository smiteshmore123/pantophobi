import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pantophobi_flutter/Controller/userSessionController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController{

 bool _showPassword = true;
 var auth;
  var user = "".obs;

  final userSessionController = Get.find<UserSessionController>();
  

  @override
  void onInit() async{
    await Firebase.initializeApp();
    auth = FirebaseAuth.instance;
    
    super.onInit();
  }

 bool get showPassword {
   return _showPassword;
 }

 updateShowPassword(){
   _showPassword = !_showPassword;
   update();
 }

 signInWithGoogle()async{
   SharedPreferences prefs =await SharedPreferences.getInstance();
    //await Firebase.initializeApp();
      try{
        // final googleUser = await GoogleSignIn(scopes: <String>[ 'email','https://www.googleapis.com/auth/contacts.readonly',],).signIn();
        final googleUser = await GoogleSignIn().signIn();
        // Obtain the auth details from the request
        if (googleUser == null) {
              print('sign in failed');
            return;
        } else {
          final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
          // final GoogleSignInAuthentication googleAuth =  await googleUser?.authentication ?? GoogleSignInAuthentication;

          // Create a new credential
          final credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken,);
          print('crediantials ---$credential');
          var omg =await FirebaseAuth.instance.signInWithCredential(credential) ;
          prefs.setBool('isLogin', true);
          prefs.setString('signInWith', 'google');
          prefs.setString('email', '${omg.user?.email}');
          //String temp = omg.user?.displayName as String;
          //username = RxString(temp);
          print('mytype ${omg.runtimeType}');
          Get.toNamed('/mapview');
          //UserSessionController()..userEmail = "$temp";
          userSessionController.updateSession();
           Get.snackbar('User', '${FirebaseAuth.instance.currentUser?.displayName}  !!',backgroundColor: Colors.orange[200]);
           int isDublicateMail = 0;
           CollectionReference eventsCollection =FirebaseFirestore.instance.collection('users');
            eventsCollection.get().then((QuerySnapshot querySnapshot) {
               querySnapshot.docs.forEach((doc) async { 
                 if(doc['userEmail'].toString() == omg.user?.email.toString())  isDublicateMail++ ;
               });
               print('test 10 $isDublicateMail');
               if(isDublicateMail == 0) { 
                  var data= { 'userEmail' : omg.user?.email,'userName' : omg.user?.displayName};
                  FirebaseFirestore.instance.collection('users').add(data);
               }
            });

        }
        }
        catch(e){
          print(e);
      }

  }

 signInWithEmail({required String mail,required String password}) async{
   SharedPreferences prefs =await SharedPreferences.getInstance();
      try {
         UserCredential userCredential = await auth.signInWithEmailAndPassword(email: mail,password: password);
         var xyz = userCredential.user?.email as String;
         //print( "xyz   $xyz");
          user = RxString(xyz);

          Get.toNamed('/mapview');
           Get.snackbar('Login Status', '${userCredential.user?.email}  !!',backgroundColor: Colors.orange[200]);
           prefs.setBool('isLogin', true);
           prefs.setString('email', '$xyz');
           prefs.setString('signInWith', 'email');
           userSessionController.updateSession();
         // Get.snackbar('Login Status', 'Successful  !!',backgroundColor: Colors.orange[200]);
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

    logOutUser()async{
      SharedPreferences prefs =await SharedPreferences.getInstance();
        if(prefs.getString('signInWith') == 'google'){
          await GoogleSignIn().disconnect();
          FirebaseAuth.instance.signOut();
          prefs.setBool('isLogin', false);
          prefs.setString('signInWith', 'none');
          prefs.setString('email', '');
          Get.back();
          Get.snackbar('LogOut', 'Successful',backgroundColor: Colors.orange[200]);
        }
        else if(prefs.getString('signInWith') == 'email'){
          auth.signOut();
          prefs.setBool('isLogin', false);
          prefs.setString('signInWith', 'none');
          prefs.setString('email', '');
          Get.back();
          Get.snackbar('LogOut', 'Successful',backgroundColor: Colors.orange[200]);
        }
        else{
          Get.back();
          prefs.setString('email', '');
          Get.snackbar('LogOut', 'Successful',backgroundColor: Colors.orange[200]);
        }



      // Get.back();
      // auth.signOut();
      // await GoogleSignIn().disconnect();
      // FirebaseAuth.instance.signOut();
      // Get.snackbar('LogOut', 'Successful',backgroundColor: Colors.orange[200]);
      // //SharedPreferences prefs =await SharedPreferences.getInstance();
      // prefs.setBool('isLogin', true);
      // prefs.setString('email', '');
      // userSessionController.updateSession();
    }
}