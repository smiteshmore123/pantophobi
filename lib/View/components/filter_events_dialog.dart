import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantophobi_flutter/Controller/eventFilterController.dart';

// class FilterEventsDialog extends StatefulWidget {

// FilterEventsDialog(this.updateFilter);

// final Function updateFilter;
// //final VoidCallback updateFilter;
  
//   //const FilterEventsDialog({Key? key}) : super(key: key);

//   @override
//   _FilterEventsDialogState createState() => _FilterEventsDialogState();
// }

// class _FilterEventsDialogState extends State<FilterEventsDialog> {


//   @override
//   // void dispose() {
//   //   widget.updateFilter();
//   //   super.dispose();
//   // }
//   // List<String> eventsList = [
//   //   "All",
//   //   "Danger",
//   //   "Threats",
//   //   "Conflicts",
//   //   "Protests",
//   //   "Military",
//   //   "Police",
//   //   "Fire",
//   //   "Other Natural disasters",
//   //   "Power Outage",
//   //   "Internet Outage",
//   //   "Cell phone Outage",
//   //   "Car wrecks",
//   //   "Plane wrecks",
//   //   "Storms",
//   //   "Criminal activity",
//   //   "Virus Outbreak",
//   //   "Other Imaginable trouble"
//   // ];

//   // List<Map> myEvent = [
//   //   {'event': 'Danger','value': 'false'},
//   //   {'event': 'Threats','value': 'false'},
//   //   {'event': 'Conflicts','value': 'false'},
//   //   {'event': 'Protests','value': 'false'},
//   //   {'event': 'Military','value': 'false'},
//   //   {'event': 'Police','value': 'false'},
//   //   {'event': 'Fire','value': 'false'},
//   //   {'event': 'Other Natural disasters','value': 'false'},
//   //   {'event': 'Power Outage','value': 'false'},
//   //   {'event': 'Internet Outage','value': 'false'},
//   //   {'event': 'Cell phone Outage','value': 'false'},
//   //   {'event': 'Car wrecks','value': 'false'},
//   //   {'event': 'Plane wrecks','value': 'false'},
//   //   {'event': 'Storms','value': 'false'},
//   //   {'event': 'Criminal activity','value': 'false'},
//   //   {'event': 'Virus Outbreak','value': 'false'},
//   //   {'event': 'Other Imaginable trouble','value': 'false'},
//   // ];
  
//   @override
//   Widget build(BuildContext context) {

    
//     return WillPopScope(
//       onWillPop: widget.updateFilter(),
//       child: Dialog(
//         elevation: 2,
//         backgroundColor: Colors.white,
//         child: contentBox(context),
//       ),
//     );
//   }

//   contentBox(context) {
//     return GetBuilder<EventFilterController>(
//       builder: (_) {
//      return
    
//     Container(
//       height: MediaQuery.of(context).size.height * 0.9,
//       padding: EdgeInsets.all(15),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Filter Events',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             CheckboxListTile(
//               title: Text('All'),
//               onChanged: (bool? value) {
//                 _.updateAll(value);
//               },
//               value: _.allEvent.toString() == 'false' ? false : true ,
//             ),
//             ListView.builder(
//               itemCount: _.myEvent.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return CheckboxListTile(
//                   title: Text(_.myEvent[index]['event']),
//                   onChanged: (bool? value) {
//                     // setState(() {
//                     //   myEvent[index]['value'] = '$value';
//                     // });
//                     _.updateEvent(index: index,value: value);

//                   },
//                   value: _.myEvent[index]['value'].toString() == 'false' ? false : true ,
//                 );
//               },
//               shrinkWrap: true,
//              physics: NeverScrollableScrollPhysics()
//             ),
//           ],
//         ),
//       ),
//     );
//       }
//       );


//   }
// }


class FilterEventsDialog extends StatelessWidget {
  FilterEventsDialog(this.updateFilter);

final Function updateFilter;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: updateFilter(),
      child: Dialog(
        elevation: 2,
        backgroundColor: Colors.white,
        child: contentBox(context),
      ),
    );
  }
  contentBox(context) {
    return GetBuilder<EventFilterController>(
      builder: (_) {
     return
    
    Container(
      height: MediaQuery.of(context).size.height * 0.9,
      padding: EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter Events',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            CheckboxListTile(
              title: Text('All'),
              onChanged: (bool? value) {
                _.updateAll(value);
              },
              value: _.allEvent.toString() == 'false' ? false : true ,
            ),
            ListView.builder(
              itemCount: _.myEvent.length,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  title: Text(_.myEvent[index]['event']),
                  onChanged: (bool? value) {
                    // setState(() {
                    //   myEvent[index]['value'] = '$value';
                    // });
                    _.updateEvent(index: index,value: value);

                  },
                  value: _.myEvent[index]['value'].toString() == 'false' ? false : true ,
                );
              },
              shrinkWrap: true,
             physics: NeverScrollableScrollPhysics()
            ),
          ],
        ),
      ),
    );
      }
      );


  }
}