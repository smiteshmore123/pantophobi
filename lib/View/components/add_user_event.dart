import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantophobi_flutter/Controller/userSessionController.dart';
import 'package:pantophobi_flutter/View/components/thank_you_dialog.dart';

class AddUserEvent extends StatefulWidget {
  final double currentLatitude;
  final double currentLongitude;

  const AddUserEvent(
      {Key? key, required this.currentLatitude, required this.currentLongitude})
      : super(key: key);

  @override
  _AddUserEventState createState() => _AddUserEventState();
}

class _AddUserEventState extends State<AddUserEvent> {
  final textController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference eventsCollection =
      FirebaseFirestore.instance.collection('events');

  Future<void> addEvent(String title, String colour, String snippet, int rating,
      GeoPoint geoPoint, String iconPicture, String userEmail) {
    return eventsCollection
        .add({
          'title': title,
          'colour': colour,
          'snippet': snippet,
          'rating': rating,
          'geoPoint': geoPoint,
          'iconPicture': iconPicture,
          'userEmail': userEmail,
        })
        .then(
          (value) => showDialog(
              context: context,
              builder: (BuildContext context) {
                return ThankYouDialog();
              }),
        )
        .catchError((error) => print('Failed to add event: $error'));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 2,
      backgroundColor: Colors.white,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return GetBuilder<UserSessionController>(
      init: UserSessionController(),
      builder: (_) { return 
    
    //////////////////
    Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.black,
            width: double.infinity,
            padding: EdgeInsets.all(15),
            child: Text(
              'Add an event',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              controller: textController,
              decoration: InputDecoration(hintText: 'Event Name'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
              TextButton(
                  onPressed: () {
                    // Fluttertoast.showToast(
                    //     msg: textController.text,
                    //     toastLength: Toast.LENGTH_SHORT);

                    GeoPoint geoPoint = new GeoPoint( widget.currentLatitude, widget.currentLongitude);
                    _.userEmail != "" ? 
                    addEvent(textController.text, '#83A2A4', "", 1, geoPoint,'disaster_c', _.userEmail) : print('please login');

                    Navigator.pop(context, true);
                  },
                  child: Text('Submit'))
            ],
          )
        ],
      ),
    );
      }
    );
  }
}
