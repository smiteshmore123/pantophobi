import 'package:flutter/material.dart';

class Slider2 extends StatelessWidget {
  const Slider2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assests/slider2.PNG',
            height: 300,
            width: 300,
          ),
          Container(
            margin: EdgeInsets.all(40),
            alignment: Alignment.center,
            child: Text(
              'Get real-time updates from nearby drivers',
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
              'assests/right_arrow.png',
              width: 30,
              height: 30,
            ),
          )
        ],
      ),
    );
  }
}
