import 'package:flutter/material.dart';

class Slider3 extends StatelessWidget {
  const Slider3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assests/slider3.PNG',
            height: 300,
            width: 300,
          ),
          Container(
            margin: EdgeInsets.all(40),
            alignment: Alignment.center,
            child: Text(
              'Plan ahead and arrive on time, every time',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            child: Image.asset(
              'assests/blue_circle.png',
              width: 30,
              height: 30,
            ),
          )
        ],
      ),
    );
  }
}
