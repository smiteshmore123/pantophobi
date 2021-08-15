// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:pantophobi_flutter/Controller/mapController.dart';

// class AdMobWidget extends StatelessWidget {
//   const AdMobWidget({Key? key}) : super(key: key);

  

//   @override
//   Widget build(BuildContext context) {
//     final gMapController = Get.find<MapController>();
//     return 
//     Container(
//           width: Get.width,
//         height: 50,
//         child: AdWidget(
//           key: UniqueKey(),
//           ad: gMapController.bannerAd//AdMobService.createBannerAd()..load(),
//             ),
//           );
//     // FutureBuilder(
//     //   //future: gMapController.getAd(),
//     //   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//     //     if(snapshot.connectionState == ConnectionState.done){
//     //       return Container(
//     //       width: Get.width,
//     //       height: 50,
//     //       child: AdWidget(
//     //         key: UniqueKey(),
//     //         ad: gMapController.bannerAd//AdMobService.createBannerAd()..load(),
//     //           ),
//     //         );
//     //       }
//     //       else{
//     //         return Container();
//     //       }
//     //     }
//     //   );
    
//     // GetBuilder<MapController>(
//     //  // init: MapController().setContext(context,getDocs),
//     //   builder: (_) {
//     //     return
//     //     _.isBannerAdReady ? Container(
//     //       width: Get.width,
//     //     height: 50,
//     //     child: AdWidget(
//     //       key: UniqueKey(),
//     //       ad: _.bannerAd//AdMobService.createBannerAd()..load(),
//     //         ),
//     //       ) : Container();
//     //   }
//     // );
//   }
// }

