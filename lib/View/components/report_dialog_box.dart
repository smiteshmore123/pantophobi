import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pantophobi_flutter/Controller/mapController.dart';
import 'package:pantophobi_flutter/Controller/userSessionController.dart';
import 'package:pantophobi_flutter/Model/reportItemModel.dart';
import 'package:pantophobi_flutter/View/components/add_user_event.dart';
import 'package:pantophobi_flutter/View/components/thank_you_dialog.dart';

class ReportDialogBox extends StatefulWidget {
  final double currentLatitude;
  final double currentLongitude;

  const ReportDialogBox(
      {Key? key, required this.currentLatitude, required this.currentLongitude})
      : super(key: key);
  @override
  _ReportDialogBoxState createState() => _ReportDialogBoxState();
}

class _ReportDialogBoxState extends State<ReportDialogBox> {


  final gMapController = Get.find<MapController>();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference eventsCollection =
      FirebaseFirestore.instance.collection('events');

  // final GeoPoint geoPoint;
  // final String iconPicture;
  //
  // final String snippet;
  // final String title;
  // final String colour;
  // final int rating;
  // final String userEmail;

  final TextEditingController eventTextecontroller = TextEditingController();

  final List<ReportItemModel> reportItems = [
    ReportItemModel(
        title: "Add Event", iconName: "disaster_c", colour: "#83A2A4"),
    ReportItemModel(title: "Danger", iconName: "ic_danger", colour: "#7E0000"),
    ReportItemModel(
        title: "Threats", iconName: "ic_threats", colour: "#D0D3D4"),
    ReportItemModel(
        title: "Conflicts", iconName: "ic_conflict", colour: "#D0D3D4"),
    ReportItemModel(
        title: "Protests", iconName: "ic_protest", colour: "#F25DA9"),
    ReportItemModel(
        title: "Military", iconName: "ic_military", colour: "#1C6A00"),
    ReportItemModel(title: "Police", iconName: "ic_police", colour: "#00ACFC"),
    ReportItemModel(title: 'Fire', iconName: 'ic_fire', colour: '#EA1A1A'),
    ReportItemModel(
        title: "Other Natural disasters",
        iconName: "ic_disaster",
        colour: "#DBD69F"),
    ReportItemModel(
        title: "Power Outages", iconName: "ic_no_plug", colour: "#FCF500"),
    ReportItemModel(
        title: "Cell phone outage",
        iconName: "ic_no_smartphones",
        colour: "#17202A"),
    ReportItemModel(
        title: "Internet Outage", iconName: "ic_no_wifi", colour: "#808B96"),
    ReportItemModel(
        title: "Car Wrecks", iconName: "ic_car_accident", colour: "#F76147"),
    ReportItemModel(
        title: "Plane Wrecks",
        iconName: "ic_plane_accident",
        colour: "#FFFFFF"),
    ReportItemModel(title: "Storms", iconName: "ic_storm", colour: "#83A2A4"),
    ReportItemModel(
        title: "Criminal Activity", iconName: "ic_robber", colour: "#2A3C3D"),
    ReportItemModel(
        title: "Virus Outbreaks", iconName: "ic_virus", colour: "#2EF249"),
    ReportItemModel(
        title: "Other Imaginable trouble",
        iconName: "ic_natural_disasters",
        colour: "#BEDB9F"),
    // ReportItemModel(
    //     title: "Custom Events",
    //     iconName: "ic_default",
    //     colour: "#BEDB9F"),    

  ];

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
                gMapController.getDocs();
                return ThankYouDialog();
              }),
        )
        .catchError((error) => print('Failed to add event: $error'));
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
    
      _.islogin ? SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            width: double.infinity,
            color: Colors.black,
            child: Text(
              'Report',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GridView.builder(
            itemCount: reportItems.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      child: SvgPicture.asset(
                        'assests/${reportItems[index].iconName}.svg',
                        height: 60,
                        width: 60,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        if (reportItems[index].title == 'Add Event') {
                          Navigator.pop(context, true);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AddUserEvent(
                                    currentLatitude: widget.currentLatitude,
                                    currentLongitude: widget.currentLongitude);
                              });
                        } else {
                          GeoPoint geoPoint = new GeoPoint(
                              widget.currentLatitude, widget.currentLongitude);
                          addEvent(
                              reportItems[index].title,
                              reportItems[index].colour,
                              "",
                              1,
                              geoPoint,
                              reportItems[index].iconName,
                              _.userEmail);//"sample@email.com");
                          Navigator.pop(context, true);
                        }
                      }
                      );
                    },
                  ),
                  Text(
                    reportItems[index].title,
                    textAlign: TextAlign.center,
                    style: TextStyle(),
                  ),
                ],
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.5)),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextField(
          //    decoration: InputDecoration(
          //      labelText: 'Enter Your Event',
          //       border: OutlineInputBorder(
          //         borderSide: BorderSide(
          //           color: Colors.red, 
          //             width: 5.0
          //           ),
          //         )
          //       ),
          //     controller: eventTextecontroller,
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       TextButton(
          //         onPressed: (){
          //           if(eventTextecontroller.text.length > 0 ) {
          //              GeoPoint geoPoint = new GeoPoint(
          //                     widget.currentLatitude, widget.currentLongitude);
          //             addEvent(eventTextecontroller.text,
          //                     "#BEDB9F",
          //                     "",
          //                     1,
          //                     geoPoint,
          //                     "ic_default",
          //                     _.userEmail);//"sample@email.com");
          //                 Navigator.pop(context, true);
          //           }
          //         }, 
          //       child: Text('Submit Event',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),)
          //       ,style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueAccent)),)
          //     ],
          //   ),
          // )
        ],
      ),
    ) 
    : Container(
      height: 300,
      width: 500,
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Please login to Add Event'),
          SizedBox(height: 30.0),
          TextButton(onPressed: (){gMapController.getBack();}, child: Text("Go Back to Login Page"))
        ],
      )),
    );
      }
    );
  }
}
