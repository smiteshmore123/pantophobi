import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:hexcolor/hexcolor.dart';

import 'components/rounded_button.dart';

class ForgotPwd extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                    onTap: () => Get.back(),//{ Navigator.of(context).pop(true);},
                    child: Image.asset('assests/left_arrow.png', width: size.width * 0.08,),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 60),
                  alignment: Alignment.center,
                  child: Text('Reset Password', style: TextStyle(color: Colors.black, fontSize: 24)),
                ),
                SizedBox(height: 50),
                Container(
                  height: 65, color: Colors.grey[100],
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  padding: const EdgeInsets.all(3.0),
                  child: TextField(
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration( labelText: 'Email', labelStyle: TextStyle(color: Colors.black), icon: Icon(Icons.mail_outline)),
                  ),
                ),
                SizedBox( height: 40),
                Container(
                  alignment: Alignment.center,
                  child: RoundedButton(color: Color(0xFF0CCCF7), text: 'Send Email',press: () {}),//HexColor('#0CCCF7'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
