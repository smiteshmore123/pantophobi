import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
//import 'package:hexcolor/hexcolor.dart';
import 'package:pantophobi_flutter/Controller/registerController.dart';

import 'components/rounded_button.dart';

class Register extends StatelessWidget {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child:  GetBuilder<RegisterController>(
            builder: (_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GestureDetector(
                      onTap: () => Get.back(),//{Navigator.of(context).pop(true);},
                      child: Image.asset( 'assests/left_arrow.png',width: size.width * 0.08),
                    ),
                  ),
                  Padding(
                    padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: SvgPicture.asset( 'assests/profile_icon.svg', width: size.width * 0.30),
                  ),
                  SizedBox(height: 18),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: Text( 'Welcome To Pantophobi',style: TextStyle( color: Colors.black, fontSize: 20,)),
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 65,
                    color: Colors.grey[100],
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    padding: const EdgeInsets.all(3.0),
                    child: TextField(
                      controller: _userNameController,
                      style: TextStyle(fontSize: 16),
                      decoration: InputDecoration( labelText: 'Name',labelStyle: TextStyle(color: Colors.black),icon: Icon(Icons.person_outline)),
                    ),
                  ),
                  SizedBox( height: 30),
                  Container(
                    height: 65,
                    color: Colors.grey[100],
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    padding: EdgeInsets.all(3.0),
                    child: TextField(
                      controller: _emailController,
                      style: TextStyle(fontSize: 16),
                      decoration: InputDecoration(labelText: 'Email',labelStyle: TextStyle(color: Colors.black), icon: Icon(Icons.mail_outline)),
                    ),
                  ),
                  SizedBox( height: 20),
                  Container(
                    height: 65,
                    color: Colors.grey[100],
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    padding: const EdgeInsets.all(3.0),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: _.showPassword,// !this._showPassword,
                      style: TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black),
                        icon: Icon(Icons.lock_outlined),
                        suffixIcon: IconButton(
                          icon: Icon( Icons.remove_red_eye, color: _.showPassword ? Colors.grey : Colors.blue ),//this._showPassword ? Colors.blue : Colors.grey,                 
                          onPressed: () => _.updateShowPassword(),//setState(() => this._showPassword = !this._showPassword);
                        ),
                      ),
                    ),
                  ),
                  SizedBox( height: 20),
                  Container(
                    alignment: Alignment.center,
                    child: RoundedButton(color: Color(0xFF0CCCF7),text: 'Register',press: () => _.postUser(userName: _userNameController.text,mail: _emailController.text.toLowerCase(), password: _passwordController.text)),
                  ),
                ]
              );
            }
          ) 
        ),
      ),
    );
  }
}