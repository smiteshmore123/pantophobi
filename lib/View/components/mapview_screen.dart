// import 'dart:async';
// import 'dart:convert';
// import 'dart:ui' as ui;
// import 'package:geocode/geocode.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import 'package:geocoding/geocoding.dart' as geoCoding;
// import 'package:get/get.dart';
// // import 'package:geocoder/geocoder.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:hexcolor/hexcolor.dart';
// // import 'package:permission_handler/permission_handler.dart';
// import 'package:location/location.dart';
// import 'package:pantophobi_flutter/Controller/eventFilterController.dart';
// import 'package:pantophobi_flutter/Controller/loginController.dart';
// import 'package:pantophobi_flutter/Controller/userSessionController.dart';
// import 'package:pantophobi_flutter/Services/admob_service.dart';
// import 'package:pantophobi_flutter/View/components/filter_events_dialog.dart';
// import 'package:pantophobi_flutter/View/components/report_dialog_box.dart';

// class MapViewScreen extends StatefulWidget {
//   const MapViewScreen({Key? key}) : super(key: key);

//   @override
//   _MapViewScreenState createState() => _MapViewScreenState();
// }

// class _MapViewScreenState extends State<MapViewScreen> {

//   final filterEventController = Get.find<EventFilterController>();

//   final userSessionController = Get.find<UserSessionController>();

//   Location location = new Location();

//   late LocationData _currentPosition;
//   late double latitude;
//   late double longitude;
//   String _address = "Getting Your Location";
//   bool _serviceEnabled = false;
//   late PermissionStatus _permissionGranted;
//   late LocationData _locationData;
//   LatLng _initialcameraposition = LatLng(0.5937, 0.9629);
//   late GoogleMapController mapController;

//   Set<Marker> _markers = {};
//   Set<Circle> circles = {};

//   bool permissionStatus = false;

//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   CollectionReference eventsCollection =FirebaseFirestore.instance.collection('events');

//   late BitmapDescriptor mapMarker;

//   //converting svg to bitmap
//   Future<BitmapDescriptor> _bitmapDescriptorFromSvgAsset(BuildContext context, String assetName) async {
//     // Read SVG file as String
//     String svgString =
//         await DefaultAssetBundle.of(context).loadString(assetName);
//     // Create DrawableRoot from SVG String
//     DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, "");

//     // toPicture() and toImage() don't seem to be pixel ratio aware, so we calculate the actual sizes here
//     MediaQueryData queryData = MediaQuery.of(context);
//     double devicePixelRatio = queryData.devicePixelRatio;
//     double width =
//         40 * devicePixelRatio; // where 32 is your SVG's original width
//     double height = 40 * devicePixelRatio; // same thing

//     // Convert to ui.Picture
//     ui.Picture picture = svgDrawableRoot.toPicture(size: Size(width, height));

//     // Convert to ui.Image. toImage() takes width and height as parameters
//     // you need to find the best size to suit your needs and take into account the
//     // screen DPI
//     ui.Image image = await picture.toImage(width.toInt(), height.toInt());
//     ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);
//     return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
//   }

//   Future getDocs() async {
//     _markers.clear();
    
//     eventsCollection.get().then((QuerySnapshot querySnapshot) {
//       querySnapshot.docs.forEach((doc) async {
//         print('mydoc ${doc.id}');
//         String docID = doc.id;
//         String icon = doc["iconPicture"].toString();

//         BitmapDescriptor bitmapDescriptor =await _bitmapDescriptorFromSvgAsset(context, 'assests/$icon.svg');

//         BitmapDescriptor bitmapUser = await _bitmapDescriptorFromSvgAsset( context, 'assests/user_marker.svg');

//         setState(() {
//           print('test: getDocs called ');
//           _markers.add(Marker(
//               markerId: MarkerId("User"),
//               icon: bitmapUser,
//               position: LatLng(latitude, longitude),
//               infoWindow: InfoWindow(
//                 title: "Your Location",
//               )));

//          if(int.parse(doc["rating"]..toString()) > -3){
//            if(filterEventController.filterList.contains(doc["iconPicture"].toString())){
//             circles.add(Circle(
//               circleId: CircleId(doc.id),
//               center: LatLng(doc["geoPoint"].latitude, doc["geoPoint"].longitude),
//               radius: 100,
//               fillColor: HexColor('22'+doc["colour"].toString()),//Color(0xFF + doc["colour"] as int),// HexColor(doc["colour"].toString()),
//               strokeColor:  HexColor(doc["colour"].toString()),
//               strokeWidth: 1,
//             ));
            
//             _markers.add(Marker(
//               onTap: (){
//                 print('alert act');
//                 showDialog(
//                   context: context, 
//                   builder: (_)=> AlertDialog(
//                     title: Text(doc["title"].toString()),  // To display the title it is optional
//                     content: Container(
//                       height: 50,
//                       width: double.infinity,
//                       child: Row(
//                        //crossAxisAlignment: CrossAxisAlignment.center,
//                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           IconButton(onPressed: (){
//                             // print('hackerTest: ${doc['rating']}');
//                             // print('hackerTest: ${doc.id}');
//                             var rating = int.parse(doc["rating"].toString()) + 1;
//                             // var xyz = doc.data();
//                             // print('hackerTest: json $xyz');
//                             // var res = jsonDecode(xyz.toString());

                             
//                             //  print('hackerTest: res $res');
//                             // String mail = "";
//                             // try{
//                             // //   var dt = jsonDecode(doc.data().toString());
//                             // // print('hackerTest: json $dt');
//                             //    //..doc['userEmail'];
//                             //    var xyz = doc.data();
                               
//                             // }
//                             // catch(e){
//                             //   print("hackerTest: err--------------- $e");
//                             // }
//                             // print('hackerTest:not  enter if loop yet');
//                             //  print("hackerTest:val $mail");
//                             //print("hackerTest:n cond ${mail != userSessionController.userEmail.toString()}");
//                             if(doc['userEmail'].toString() != userSessionController.userEmail.toString()){
//                               print('hackerTest: enter if loop');
//                               //doc.reference.update({"rating" : "$rating"});
//                               //var mDatabase =  FirebaseFirestore.instance.// FirebaseDatabase.getInstance().getReference("QuoteList")
//                               //eventsCollection.doc('${doc.id}').  //update({"rating" : "$rating"});
//                               CollectionReference usersEvent = FirebaseFirestore.instance.collection('events');
//                                 usersEvent.doc('${doc.id}').update({"rating" : "$rating"}).then((value) => print("hackerTest: event Updated")).catchError((error) => print("hackerTest: Failed to update event: $error"));
//                               Navigator.of(context).pop();
                              
//                             }
//                             else{
//                               Navigator.of(context).pop();
//                               Get.snackbar("Warning","Can't upvote your own posted event",backgroundColor: Colors.orange[200]);
                                
//                             }
//                             //Navigator.of(context).pop();
//                           }, icon: Icon(Icons.thumb_up),iconSize: 40,),
//                           IconButton(onPressed: (){
//                             var rating = int.parse(doc["rating"].toString()) - 1;
//                             if(rating == -3 || doc['userEmail'].toString() == userSessionController.userEmail.toString()){
//                               //doc.reference.delete();
//                               int hide = -3;
//                               doc.reference.update({'rating':'$hide'});
//                             }
//                             else{
//                              doc.reference.update({'rating':'$rating'});
//                             }

                            
//                             Navigator.of(context).pop();
//                           }, icon: Icon(Icons.thumb_down),iconSize: 40)
//                       ],),
//                     )//Text('Please Select Report option'), 
//                       // Message which will be pop up on the screen
//                     // Action widget which will provide the user to acknowledge the choice
//                       // actions: [
//                       //   IconButton(onPressed: (){}, icon: Icon(Icons.thumb_up)),
//                       //   IconButton(onPressed: (){
                          
//                       //   }, icon: Icon(Icons.thumb_down))
//                       // ],
//                   )
//                   );
//               },
//               markerId: MarkerId(doc.id),
//               icon: bitmapDescriptor,
//               position:
//                   LatLng(doc["geoPoint"].latitude, doc["geoPoint"].longitude),
//               infoWindow: InfoWindow(
//                 title: doc["title"].toString(),
//               )));
//          } 
//          }  

//         });
//       });
//     });
  
//   }

//   // Future<List<Address>> _getAddress(double lat, double lang) async {
//   //   final coordinates = new Coordinates(lat, lang);
//   //   List<Address> add =
//   //       await Geocoder.local.findAddressesFromCoordinates(coordinates);
//   //   return add;
//   // }
//    getAddress(double lat, double lang) async {
//     print('testtt: getAddress called $lat $lang');
//     List<geoCoding.Placemark> placemarks;
//     GeoCode geoCode = GeoCode();
//     Address addr = await geoCode.reverseGeocoding(latitude: lat,longitude: lang);
//     print('testtt: myageAddress ${addr.city}');
//       //  placemarks = await geoCoding.placemarkFromCoordinates(lat, lang);
//       //var xyz = await geoCoding.placemarkFromCoordinates(19.1621788, 72.9975725);
      
//         //var xys= ['',''];
//       // placemarks = addr.city;
    
//     return addr.city;
//   }

//   getLoc() async {
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;

//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }

//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }
//       print('testtt: loc start');
//     _currentPosition = await location.getLocation();
//     _initialcameraposition = LatLng(_currentPosition.latitude ?? 0.0, _currentPosition.longitude ?? 0.0);
//     location.onLocationChanged.listen((LocationData currentLocation) {
//       print("${currentLocation.longitude} : ${currentLocation.longitude}");
//       print('testtt: loc got ${currentLocation.longitude} : ${currentLocation.longitude}');
//       setState(() {
//          print('testtt: loc setState');
//         _currentPosition = currentLocation;
//         _initialcameraposition = LatLng(_currentPosition.latitude ?? 0.0, _currentPosition.longitude ?? 0.0);
//         getAddress(_currentPosition.latitude ?? 0.0, _currentPosition.longitude ?? 0.0).then((value) {
//           print('testtt: loc got  add${value}');
//           setState(() {
//             _address = value.toString();
//           });
//         });
//       });
//     });
//   }

//   // void checkLocationPermission() async {
//   //   var status = await Permission.location.status;
//   //   if (status.isGranted) {
//   //     print("granted");
//   //     permissionStatus = true;
//   //     // getCurrentLocation();
//   //     // We didn't ask for permission yet or the permission has been denied before but not permanently.
//   //   } else {
//   //     if (await Permission.location.request().isGranted) {
//   //       print('granted');
//   //       permissionStatus = true;
//   //       // getCurrentLocation();
//   //     } else if (await Permission.location.isDenied) {
//   //       openAppSettings();
//   //     }
//   //   }
//   // }

//   // Future<LatLng> getCurrentLocation() async {
//   //   var position = await GeolocatorPlatform.instance
//   //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//   //
//   //   var currentPosition = LatLng(position.latitude, position.longitude);
//   //
//   //   return currentPosition;
//   //   // setState(() {
//   //   //   currentPostion = LatLng(position.latitude, position.longitude);
//   //   //   print('current location: $currentPostion');
//   //   // });
//   // }
//   //late BannerAd _bannerAd;

  
//   //bool _isBannerAdReady = false;

//   late Timer timer;

//   void startEventLocationsRunnable() {
//     timer = Timer.periodic(Duration(seconds: 20), (Timer timer) {
//       _markers.clear();
//       circles.clear();
//       getDocs();
//       print("working future");
//     });
//   }

//   void stopLocationUpdates() {
//     timer.cancel();
//   }


//   @override
//   void initState() {

   
//     // }
  
//     //AdMobService.createBannerAd()..load();
//     super.initState();
//       getLoc();
//     startEventLocationsRunnable();
//   }

//   @override
//   void dispose() {
//     stopLocationUpdates();
//     super.dispose();
//   }

//   // BitmapDescriptor bitmapDescriptor =
//   //     await _bitmapDescriptorFromSvgAsset(context, 'assests/.svg');

//   void _onMapCreated(GoogleMapController controller) {
//     getDocs();
//     mapController = controller;
//     location.onLocationChanged.listen((l) {
//       latitude = l.latitude!;
//       longitude = l.longitude!;
//       mapController.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(
//               target: LatLng(l.latitude ?? 0.0, l.longitude ?? 0.0), zoom: 15),
//         ),
//       );

//       // _markers.add(Marker(
//       //     markerId: MarkerId("User"),
//       //     position: LatLng(l.latitude ?? 0.0, l.longitude ?? 0.0),
//       //     infoWindow: InfoWindow(
//       //       title: "Your Location",
//       //     )));
//     });
//   }

//   void updateFilter(){
//     // setState(() {
//     //   getDocs();
//     // });
//     getDocs();
//   }

//   @override
//   Widget build(BuildContext context) {
//    return  GetBuilder<LoginController>(
//     builder: (_) {
//      return Scaffold(
//          bottomNavigationBar: Container(
//          height: 50,
//          child: AdWidget(
//            key: UniqueKey(),
//            ad: AdMobService.createBannerAd()..load(),
//          ),
//        ),
//       //    bottomNavigationBar: _isBannerAdReady ?
//       //    Container(
//       //    height: 100,
//       //    width: MediaQuery.of(context).size.width,
//       //    child: Center(
//       //      child: AdWidget(
//       //        key: UniqueKey(),
//       //        ad:_bannerAd,
//       //      ),
//       //    ),
//       //  ) : Container(
//       //    height: 0,width :0
//       //  ),
//         body: SafeArea(
//           child: Stack(
//             children: [
//               GoogleMap(
//                 initialCameraPosition: CameraPosition(
//                   target: _initialcameraposition,
//                 ),
//                 onMapCreated: _onMapCreated,
//                 markers: _markers,
//                 circles: circles,
//               ),
//               Positioned(
//                 bottom: 190,
//                 right: 8,
//                 child: FloatingActionButton(
//                   onPressed: () {
//                     showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return FilterEventsDialog(updateFilter);
//                         });
//                   },
//                   child: Icon(
//                     Icons.filter_alt_outlined,
//                     color: Colors.black,
//                   ),
//                   backgroundColor: Colors.white,
//                 ),
//               ),
//               Positioned(
//                 bottom: 120,
//                 right: 8,
//                 child: FloatingActionButton(
//                   onPressed: () {
//                     setState() {
//                       getLoc();
//                     }
//                   },
//                   child: Icon(
//                     Icons.location_on,
//                     color: Colors.black,
//                   ),
//                   backgroundColor: Colors.white,
//                 ),
//               ),
//               Positioned(
//                 bottom: 0,
//                 child: Container(
//                   padding: EdgeInsets.all(10),
//                   width: MediaQuery.of(context).size.width,
//                   color: Colors.white,
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Expanded(
//                         flex: 1,
//                         child: Image.asset(
//                           'assests/placeholder.png',
//                           height: 25,
//                         ),
//                       ),
//                       Expanded(
//                         flex: 2,
//                         child: Text('My Location:'),
//                       ),
//                       Expanded(
//                         flex: 2,
//                         child: Text(
//                           '${_address}',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 10),
//                         child: GestureDetector(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Center(
//                                 child: Image.asset(
//                                   'assests/megaphone.png',
//                                   width: 35,
//                                   height: 35,
//                                 ),
//                               ),
//                               Text('Report Event'),
//                             ],
//                           ),
//                           onTap: () {
//                             showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return ReportDialogBox(
//                                       currentLatitude: latitude,
//                                       currentLongitude: longitude);
//                                 });
//                           },
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 20,left: 15,
//                 child:  IconButton(onPressed: () => _.logOutUser(),
//                  icon: Image.asset('assests/logout.png',height: 80,width: 40,))
//                 )
//             ],
//           ),
//         ),
//       );

//               }
//     );



//   }
// }
