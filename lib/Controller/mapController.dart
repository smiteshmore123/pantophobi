import 'dart:async';
import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocode/geocode.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
// import 'package:geocoding/geocoding.dart' as geoCoding;
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:location/location.dart';
import 'package:pantophobi_flutter/Controller/eventFilterController.dart';
import 'package:pantophobi_flutter/Controller/userSessionController.dart';
// import 'package:pantophobi_flutter/Services/admob_service.dart';

class MapController extends GetxController{
   bool isBannerAdReady = false;

  Location location = new Location();
  late GoogleMapController mapController;


  var initialcameraposition = LatLng(0.5937, 0.9629);
  late double latitude;
  late double longitude;
  

  Set<Marker> markers = {};
  Set<Circle> circles = {};
  late LocationData currentPosition;
  String address = "Please wait while we fetch your Location";


   InterstitialAd? _interstitialAd;
   int _numInterstitialLoadAttempts = 0;
   final int maxFailedLoadAttempts = 3;


  final userSessionController = Get.find<UserSessionController>();
  final filterEventController = Get.find<EventFilterController>();
  CollectionReference eventsCollection =FirebaseFirestore.instance.collection('events');

 @override
  void onInit() async{
    //print('test init called');
    getpermission();
    await getLoc();
    await getDocs();
    sleep(Duration(seconds:1));
    loadInterstitial();
    //getAd();
    super.onInit();
   // getNewAd();
    startEventLocationsRunnable();
  }

  get initAd => _interstitialAd;

  getBack(){
    //Get.replace('/login');
    Get.offAllNamed('/');
  }

  void loadInterstitial() async {
    InterstitialAd.load(
      adUnitId: InterstitialAd.testAdUnitId,
      adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 1;
            isBannerAdReady = true;
            update();
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
              loadInterstitial();
            }
          },
        ),
      request: AdRequest(),
    );
  }

get showAd => _showInterstitialAd();
  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) async{
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        isBannerAdReady = false;
        //Future.delayed(Duration(seconds: 10));
        Timer(Duration(seconds: 40), () =>loadInterstitial());
        
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        loadInterstitial();
      },
    );
    _interstitialAd!.show();
   // print('ad/i printing');
    _interstitialAd = null;
  }


  @override
  void onClose() {
    //stopLocationUpdates();
    print('onCLose caleld');
   // bannerAd.dispose();
    super.onClose();
  }

  late Timer timer;

  void startEventLocationsRunnable() {
    timer = Timer.periodic(Duration(seconds: 60), (Timer timer) {
      markers.clear();
      circles.clear();
      getDocs();
      //print('I/Ads a');
      // _showInterstitialAd();
      //print("working future");
    });
  }

  //get gps permisson 
  getpermission()async{
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) { return;}
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) { return; }
    }
  }


  //create Map 

  void onMapCreated(GoogleMapController controller) {
    //getDocs();
    mapController = controller;
    location.onLocationChanged.listen((l) {
      latitude = l.latitude!;
      longitude = l.longitude!;
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude ?? 0.0, l.longitude ?? 0.0), zoom: 16.0,tilt: 90.0),
        ),
      );
    });
  }


  getLoc() async {
    currentPosition = await location.getLocation();
    initialcameraposition = LatLng(currentPosition.latitude ?? 0.0, currentPosition.longitude ?? 0.0);
    var add = await getAddress(currentPosition.latitude ?? 0.0, currentPosition.longitude ?? 0.0);
    address = '$add';
    update();
  }

  getAddress(double lat, double lang) async {
    try{
      // print('testtt: get add');
    //List<geoCoding.Placemark> placemarks;
    GeoCode geoCode = GeoCode();
    Address addr = await geoCode.reverseGeocoding(latitude: lat,longitude: lang);
    //print('testtt: myageAddress ${addr.city}');
    return addr.city;
    }
    catch(e){
      print('testtt: $e');
    }
  }


  Future getDocs() async {
    markers.clear();
    circles.clear();
    eventsCollection.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        //print('mydoc ${doc.id}');

        //String docID = doc.id;
        String icon = doc["iconPicture"].toString();

        BitmapDescriptor bitmapDescriptor =await bitmapDescriptorFromSvgAsset(Get.context as BuildContext, 'assests/$icon.svg');

        BitmapDescriptor bitmapUser = await bitmapDescriptorFromSvgAsset( Get.context as BuildContext, 'assests/user_marker.svg');
    
          markers.add(Marker(
              markerId: MarkerId("User"),
              icon: bitmapUser,
              position: LatLng(latitude, longitude),
              infoWindow: InfoWindow(
                title: "Your Location",
              )));

        if(int.parse(doc["rating"].toString()) > -3){
          if(filterEventController.filterList.contains(doc["iconPicture"].toString())){
            circles.add(Circle(
              circleId: CircleId(doc.id),
              center: LatLng(doc["geoPoint"].latitude, doc["geoPoint"].longitude),
              radius: 100,
              fillColor: HexColor('22'+doc["colour"].toString()),//Color(0xFF + doc["colour"] as int),// HexColor(doc["colour"].toString()),
              strokeColor:  HexColor(doc["colour"].toString()),
              strokeWidth: 1,
            ));
            
            markers.add(Marker(
              onTap: (){
                //print('alert act');
                showDialog(
                  context: Get.context as BuildContext, 
                  builder: (_)=> AlertDialog(
                    title: Text(doc["title"].toString()),  // To display the title it is optional
                    content: Container(
                      height: 50,
                      width: double.infinity,
                      child: Row(
                       //crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: (){
                            var rating = int.parse(doc["rating"].toString()) + 1;
                            if(doc['userEmail'].toString() != userSessionController.userEmail.toString()){    
                              CollectionReference usersEvent = FirebaseFirestore.instance.collection('events');
                                usersEvent.doc('${doc.id}').update({"rating" : "$rating"}).then((value) => print("hackerTest: event Updated")).catchError((error) => print("hackerTest: Failed to update event: $error"));
                             Get.back();
                             getDocs();     
                            }
                            else{
                              Get.back();
                              Get.snackbar("Warning","Can't upvote your own posted event",backgroundColor: Colors.orange[200]);
                                
                            }
                            //Navigator.of(context).pop();
                          }, icon: Icon(Icons.thumb_up),iconSize: 40,),
                          IconButton(onPressed: (){
                            var rating = int.parse(doc["rating"].toString()) - 1;
                            if(rating == -3 || doc['userEmail'].toString() == userSessionController.userEmail.toString()){
                              //doc.reference.delete();
                              int hide = -3;
                              doc.reference.update({'rating':'$hide'});
                              getDocs();
                            }
                            else{
                             doc.reference.update({'rating':'$rating'});
                             getDocs();
                            }

                            Get.back();
                            //Navigator.of(context).pop();
                          }, icon: Icon(Icons.thumb_down),iconSize: 40)
                      ],),
                    )
                  )
                  );
              },
              markerId: MarkerId(doc.id),
              icon: bitmapDescriptor,
              position: LatLng(doc["geoPoint"].latitude, doc["geoPoint"].longitude),
              infoWindow: InfoWindow( title: doc["title"].toString())
            )
            );
          }
        }
      update();
      });
    });
  }

  
  bitmapDescriptorFromSvgAsset(BuildContext context, String assetName) async {
    String svgString = await DefaultAssetBundle.of(context).loadString(assetName);
    DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, "");
    MediaQueryData queryData = MediaQuery.of(context);
    double devicePixelRatio = queryData.devicePixelRatio;
    double width = 40 * devicePixelRatio; // where 32 is your SVG's original width
    double height = 40 * devicePixelRatio; // same thing
    ui.Picture picture = svgDrawableRoot.toPicture(size: Size(width, height));
    ui.Image image = await picture.toImage(width.toInt(), height.toInt());
    ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
  }

  

  

}