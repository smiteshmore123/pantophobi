
// import 'dart:io';

// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class AdMobService {

//   static String get bannerAdUnitId => Platform.isAndroid ? 'ca-app-pub-3940256099942544/6300978111': 'ca-app-pub-3940256099942544/6300978111';

//   static initialize(){
//     List<String> id = ['1595A74F4CCAAF5D54F666EA8EAC31C7'];
//     RequestConfiguration config = RequestConfiguration(testDeviceIds: id);

//     //RequestConfiguration(testDeviceIds: id);
//    // List<String> testDeviceIds = ["33BE2250B43518CCDA7DE426D04EE231"];
//     //RequestConfiguration configuration =new RequestConfiguration(testDeviceIds: id);  //uilder().setTestDeviceIds(testDeviceIds).build();
//     // ignore: unrelated_type_equality_checks
//     if(MobileAds.instance == false){
//       MobileAds.instance.initialize();
//       //MobileAds.instance.updateRequestConfiguration(config);
//     }
//     //MobileAds.instance.updateRequestConfiguration(config);
//   }

//   static BannerAd createBannerAd(){
//     print(' I/Ads logcat output');
//     BannerAd ad = new BannerAd(
//       size: AdSize.banner, 
//       adUnitId: bannerAdUnitId,
//       request: AdRequest(), 
//       listener: BannerAdListener(
//         onAdLoaded: (Ad ad) => print('Ad Loaded'),
//         onAdFailedToLoad: (Ad ad,LoadAdError error) {
//           print('Ad Error $error');
//           ad.dispose();
//         } ,
//         onAdOpened: (Ad ad) => print('Ad opened'),
//         onAdClosed: (Ad ad) => print('On Ad Closed')
//       ),
//     );
//     return ad;  
//   }
// }













