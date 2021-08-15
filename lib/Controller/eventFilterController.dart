
import 'package:get/get.dart';


class EventFilterController extends GetxController{

 late List<Map> myEvent ;
 late String allEvent ;

//  late List filterList =  [
//     "Danger",
//     "Threats",
//     "Conflicts",
//     "Protests",
//     "Military",
//     "Police",
//     "Fire",
//     "Other Natural disasters",
//     "Power Outage",
//     "Internet Outage",
//     "Cell phone Outage",
//     "Car wrecks",
//     "Plane wrecks",
//     "Storms",
//     "Criminal activity",
//     "Virus Outbreak",
//     "Other Imaginable trouble"
//     ""
//   ];

late List filterList =  [
  "disaster_c", 
  "ic_danger", 
  "ic_threats", 
  "ic_conflict",
  "ic_protest", 
  "ic_military",  
  "ic_police",
  "ic_fire",
  "ic_disaster",
  "ic_no_plug",  
  "ic_no_smartphones",
  "ic_no_wifi",  
  "ic_car_accident",
  "ic_plane_accident",
  "ic_storm", 
  "ic_robber", 
  "ic_virus",  
  "ic_natural_disasters",


    // "Danger",
    // "Threats",
    // "Conflicts",
    // "Protests",
    // "Military",
    // "Police",
    // "Fire",
    // "Other Natural disasters",
    // "Power Outage",
    // "Internet Outage",
    // "Cell phone Outage",
    // "Car wrecks",
    // "Plane wrecks",
    // "Storms",
    // "Criminal activity",
    // "Virus Outbreak",
    // "Other Imaginable trouble"
    // ""
  ];
  

  @override
  void onInit() async{
    myEvent = loadEventList();
    allEvent = 'true';
    super.onInit();
  }

  updateEvent({index,value}){
      myEvent[index]['value'] = value.toString();
      

      if(value.toString() == 'false'){
        //filterList.removeWhere((element) => myEvent[index]['event']);
        //int ind = filterList.indexOf(myEvent[index]['event']);
        filterList.remove(myEvent[index]['icon']);
      }
      else{
        filterList.add("${myEvent[index]['icon']}");
      }
      //print('filterList-test: $filterList');
      update();
  }

  updateAll(value){
    allEvent = value.toString();
      for(int i=0; i< myEvent.length; i++){
        myEvent[i]['value'] = value.toString();
      }

      if(allEvent.toString() == 'false'){
        filterList = [];
      }
      else{
        for(int i=0; i< myEvent.length; i++){
          filterList.add("${myEvent[i]['icon']}");
        }
      }
     // print('filterList-test: $filterList');
      update();
  }

  loadEventList(){
    var myEvent = [
      {'event': 'Custom Events','value': 'true', 'icon': 'disaster_c'},
    {'event': 'Danger','value': 'true', 'icon': 'ic_danger'},
    {'event': 'Threats','value': 'true', 'icon': 'ic_threats'},
    {'event': 'Conflicts','value': 'true', 'icon': 'ic_conflict'},
    {'event': 'Protests','value': 'true', 'icon': 'ic_protest'},
    {'event': 'Military','value': 'true', 'icon': 'ic_military'},
    {'event': 'Police','value': 'true', 'icon': 'ic_police'},
    {'event': 'Fire','value': 'true', 'icon': 'ic_fire'},
    {'event': 'Other Natural disasters','value': 'true', 'icon': 'ic_disaster'},
    {'event': 'Power Outage','value': 'true', 'icon': 'ic_no_plug'},
    {'event': 'Internet Outage','value': 'true', 'icon': 'ic_no_smartphones'},
    {'event': 'Cell phone Outage','value': 'true', 'icon': 'ic_no_wifi'},
    {'event': 'Car wrecks','value': 'true', 'icon': 'ic_car_accident'},
    {'event': 'Plane wrecks','value': 'true', 'icon': 'ic_plane_accident'},
    {'event': 'Storms','value': 'true', 'icon': 'ic_storm'},
    {'event': 'Criminal activity','value': 'true', 'icon': 'ic_robber'},
    {'event': 'Virus Outbreak','value': 'true', 'icon': 'ic_virus'},
    {'event': 'Other Imaginable trouble','value': 'true', 'icon': 'ic_natural_disasters'},
  ];
  return myEvent;
  }
 
}