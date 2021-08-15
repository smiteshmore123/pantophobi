import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
//import 'package:hexcolor/hexcolor.dart';
import 'package:pantophobi_flutter/Controller/loginController.dart';
import 'package:pantophobi_flutter/View/components/rounded_button.dart';


class Login extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: GetBuilder<LoginController>(
              builder: (_) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GestureDetector(
                        onTap: () { Get.back();},//Navigator.of(context).pop(true); },
                        child: Image.asset( 'assests/left_arrow.png',width: size.width * 0.08,),
                      ),
                    ),
                    Padding(
                      padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: SvgPicture.asset('assests/profile_icon.svg',width: size.width * 0.30,),
                    ),
                    SizedBox(height: 18),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: Text(
                        'Welcome Back, Pantophobier',
                        style: TextStyle(color: Colors.black,fontSize: 20)
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      height: 65,
                      color: Colors.grey[100],
                      margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      padding: const EdgeInsets.all(3.0),
                      child: TextField(
                        controller: _emailController,
                        style: TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.black),
                          icon: Icon(Icons.mail_outline),
                        ),
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
                        obscureText: _.showPassword,//!this._showPassword,
                        style: TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.black),
                          icon: Icon(Icons.lock_outlined),
                          suffixIcon: IconButton(
                            icon: Icon( Icons.remove_red_eye,color: _.showPassword ? Colors.grey : Colors.blue),//this._showPassword ? Colors.blue : Colors.grey,),
                            onPressed: () => _.updateShowPassword(), //setState(() => this._showPassword = !this._showPassword);},
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      alignment: Alignment.center,
                      child: RoundedButton(
                        color: Color(0xFF0CCCF7),//HexColor('#0CCCF7'),
                        text: 'Login',
                        press: () =>_.signInWithEmail(mail: _emailController.text.toLowerCase(), password: _passwordController.text)// Get.toNamed('/mapview'),//Navigator.pushNamed(context, '/mapview');
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('or', style: TextStyle(color: Colors.black))
                      ],
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: ()=> _.signInWithGoogle(),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black ),
                          borderRadius: BorderRadius.all(Radius.circular(29)),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(6),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assests/google_logo.png', height: size.height * 0.05),
                            Padding(padding: const EdgeInsets.only(left: 5), child: Text('Login with Google')),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed('/forgotPwd'), //Navigator.pushNamed(context, '/forgotPwd');
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.center,
                        child: Text('Having Trouble?',style: TextStyle(color: Color(0xFF24A5C2) ),//HexColor('#24A5C2')
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: RoundedButton(
                        color: Color(0xFF0CCCF7),//HexColor('#0CCCF7'),
                        text: 'Register',
                        press: () => Get.toNamed('/register')//Navigator.pushNamed(context, '/register');
                      ),
                    ),
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}