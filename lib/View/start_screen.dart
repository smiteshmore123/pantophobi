import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantophobi_flutter/Controller/userSessionController.dart';
import 'package:pantophobi_flutter/View/components/Slider3.dart';
import 'package:pantophobi_flutter/View/components/rounded_button.dart';
import 'components/Slider2.dart';
import 'components/slider1.dart';


class StartScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
     PageController _controller = PageController(initialPage: 0, );
   // Size size = MediaQuery.of(context).size;
    return GetBuilder<UserSessionController>(
      init: UserSessionController(),
              builder: (_) { return
    
    
    SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            height: 500,
            child: PageView(
              controller: _controller,
              children: [
                Slider1(),
                Slider2(),
                Slider3(),
              ],
            ),
          ),
          Expanded(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RoundedButton(
                    text: 'Get Started',
                    color: Color(0xFF0CCCF7),
                    press: () => Get.toNamed('/mapview')//Navigator.pushNamed(context, '/mapview');
                ),
                GestureDetector(
                  onTap: () =>  Get.toNamed("/login"),// Navigator.pushNamed(context, '/login');
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFF0CCCF7),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(29)),
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'LOGIN',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    )
    );
              }
    );



  }
}