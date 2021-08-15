import 'package:flutter/material.dart';

class ThankYouDialog extends StatelessWidget {
  const ThankYouDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 2,
      backgroundColor: Colors.white,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'Thank you for reporting! \nYour event will be displayed in a while.',
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text('OK',
                style: TextStyle(
                  fontSize: 16,
                )),
          ),
        ])
      ],
    );
  }
}
