
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:pantophobi_flutter/Services/admob_service.dart';
import 'package:pantophobi_flutter/View/MapScreen/mapViewScreen.dart';
// import 'package:pantophobi_flutter/View/components/mapview_screen.dart';
import 'package:pantophobi_flutter/View/forgot_password.dart';
import 'package:pantophobi_flutter/View/login_screen.dart';
import 'package:pantophobi_flutter/View/privacy_policy.dart';
import 'package:pantophobi_flutter/View/register_screen.dart';
import 'package:pantophobi_flutter/View/start_screen.dart';
import 'package:pantophobi_flutter/myBindings.dart';
// import 'package:shared_preferences/shared_preferences.dart';






void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Firebase.initializeApp();
  runApp(MainActivity());
}

class MainActivity extends StatelessWidget {
  // This widget is the root of your application.
  // MainActivity({required this.prefs});
  // final bool prefs;
  @override
  Widget build(BuildContext context) {
   // print('pref $prefs');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pantophobi Flutter',
      theme: ThemeData( primaryColor: Color(0xFF0CCCF7)),
      initialRoute: '/',// prefs == true ? '/mapview' : '/' , //'/',
      getPages: [
        GetPage(name: '/', page: ()=>StartScreen(),binding: MyBinding()),
        GetPage(name: '/login', page: ()=>Login(),binding: MyBinding()),
        GetPage(name: '/policy', page: ()=>Policy(),binding: MyBinding()),
        GetPage(name: '/register', page: ()=>Register(),binding: MyBinding()),
        GetPage(name: '/forgotPwd', page: ()=>ForgotPwd(),binding: MyBinding()),
        GetPage(name: '/mapview', page: ()=>MapViewScreen2(),binding: MyBinding()),
      ],
    );
  }
}
