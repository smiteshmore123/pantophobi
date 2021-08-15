// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:hexcolor/hexcolor.dart';
import 'package:pantophobi_flutter/Controller/loginController.dart';
import 'package:pantophobi_flutter/Controller/mapController.dart';
//import 'package:pantophobi_flutter/Services/admob_service.dart';
// import 'package:pantophobi_flutter/View/MapScreen/admobWidget.dart';
import 'package:pantophobi_flutter/View/components/filter_events_dialog.dart';
import 'package:pantophobi_flutter/View/components/report_dialog_box.dart';

class MapViewScreen2 extends StatelessWidget {
  MapViewScreen2({Key? key}) : super(key: key);

  //Completer<GoogleMapController> _controller = Completer();
  final gMapController = Get.find<MapController>();
  final loginController = Get.find<LoginController>();

 


  
  //CollectionReference eventsCollection =FirebaseFirestore.instance.collection('events');



  updateFilter(){
    gMapController.getDocs();
  }

   

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(
     // init: MapController().setContext(context,getDocs),
      builder: (_) {
        if(_.isBannerAdReady) _.showAd ;
        return SafeArea(
          child: Scaffold(
          //   bottomNavigationBar: _.isBannerAdReady ? Container(
          //  height: 50,
          //  child: AdWidget(
          //    key: UniqueKey(),
          //    ad: _.bannerAd//AdMobService.createBannerAd()..load(),
          //     ),
          //   ) : Container(),
            body: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _.initialcameraposition//_initialcameraposition,
                  ),
                  onMapCreated: _.onMapCreated,
                  // (GoogleMapController controller){
                  //   _.getLoc();
                  //   _.getDocs();
                  //   _controller.complete(controller); },//_.onMapCreated,//_onMapCreated,
                  markers: _.markers,//_markers,   ----
                  circles: _.circles //circles,    ----
                ),
                Positioned(
                  bottom: 190,
                  right: 8,
                  child: FloatingActionButton(
                    heroTag: 'id1',
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return FilterEventsDialog(updateFilter);
                          });
                    },
                    child: Icon(
                      Icons.filter_alt_outlined,
                      color: Colors.black,
                    ),
                    backgroundColor: Colors.white,
                  ),
                ),
                Positioned(
                  bottom: 120,
                  right: 8,
                  child: FloatingActionButton(
                    heroTag: 'id2',
                    onPressed: () {
                      _.getLoc();
                    //   _goToMyLoc();
                    //  _.getLoc();
                    //   setState() {
                    //     getLoc();
                    //   }
                    },
                    child: Icon(
                      Icons.location_on,
                      color: Colors.black,
                    ),
                    backgroundColor: Colors.white,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(flex: 1,child: Image.asset('assests/placeholder.png', height: 25) ),
                        Expanded(flex: 2, child: Text('My Location:'),),
                        Expanded( flex: 2,child: Text('${_.address}',//'${_address}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: GestureDetector(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Image.asset(
                                    'assests/megaphone.png',
                                    width: 35,
                                    height: 35,
                                  ),
                                ),
                                Text('Report Event'),
                              ],
                            ),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ReportDialogBox(
                                        currentLatitude: _.latitude,//latitude,
                                        currentLongitude: _.longitude);//longitude);
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                top: 20,left: 15,
                child:  IconButton(onPressed: () => loginController.logOutUser(),
                 icon: Image.asset('assests/logout.png',height: 80,width: 40,))
                ),
                // Positioned(
                //   top: 10.0,
                //   child: Container(
                //     height: 50,
                //     width: Get.width,
                //     child: _.isBannerAdReady ?_.initAd : Container()
                //       )   
                //         ),
                  
              ],
            ),
          ),
        );
      }
    );
  }

}




