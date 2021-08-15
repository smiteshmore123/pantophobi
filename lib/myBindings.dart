import 'package:get/get.dart';
import 'package:pantophobi_flutter/Controller/eventFilterController.dart';
import 'package:pantophobi_flutter/Controller/loginController.dart';
import 'package:pantophobi_flutter/Controller/mapController.dart';
import 'package:pantophobi_flutter/Controller/registerController.dart';
import 'package:pantophobi_flutter/Controller/userSessionController.dart';


class MyBinding extends Bindings{
 @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => RegisterController());
    Get.lazyPut(() => MapController());
    Get.lazyPut(() => UserSessionController(),fenix: true);
    Get.lazyPut(() => EventFilterController(),fenix: true);
  } 
}