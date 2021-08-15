import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Policy extends StatelessWidget {
  const Policy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFFB4EFFE),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  'PANTOPHOBI END USER LICENSE AGREEMENT',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset('assests/pantophobi_logo.JPG', width: size.width * 0.35),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'My Company operates http://www.mysite.com. This page informs you of our policies regarding the collection, use and disclosure of Personal Information we receive from users of the Site. We use your Personal Information only for providing and improving the Site. By using the Site, you agree to the collection and use of information in accordance with this policy. Information Collection And Use While using our Site, we may ask you to provide us with certain personally identifiable information that can be used to contact or identify you. Personally identifiable information may include, but is not limited to your name Like many site operators, we collect information that your browser sends whenever you visit our Site This Log Data may include information such as your computers Internet Protocol address, browser type, browser version, the pages of our Site that you visit, the time and date of your visit, the time spent on those pages and other statistics. In addition, we may use third party services such as Google Analytics that collect, monitor and analyze this. The Log Data section is for businesses that use analytics or tracking services in websites or apps, like Google Analytics. For the full disclosure section, create your own Privacy Policy. Communications',
                  style: TextStyle(color: Color(0xFF0CCCF7)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Get.toNamed('/'),
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('No Thanks',style: TextStyle(color: Colors.red[900])),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed('/login'),
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Accept',style: TextStyle(color: Color(0xFF0CCCF7))),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
