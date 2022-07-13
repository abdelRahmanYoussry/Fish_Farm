// import 'package:fish_farm/Shared/Componets/components.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'MonthlySuppliesReports_View/MonthlySuppliesReport_View.dart';
// import 'Monthly_Eel_Report/monthlyEelReport_view/monthlyEelReport_view.dart';
//
// class MonthlyEelReports extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBody: true,
//       body: Container(
//         decoration: BoxDecoration(
//           image:DecorationImage(
//             image: AssetImage('assets/image/farmoutsideblue.png'),
//             fit: BoxFit.fill
//           )
//         ),
//         child: Padding(
//           padding: const EdgeInsets.only(left: 10,right: 25,top: 100),
//           child: Column(
//             children: [
//               umbrellaContainer(
//                   context:context,
//                   title: 'Monthly Reports',
//                   color: Colors.white),
//               SizedBox(height: 30,),
//               reportContainer(
//                  title: 'Monthly Eel Report',
//                 subTitle:'For Each Tank',
//                 whichReport1: 'Quantity , Weight , ِAverage',
//                whichReport2: 'Mortality , Remaining , Feed',
//                 context: context,
//                 onTap:(){
//                   navigateTo(context, widget: MonthlyReportScreen());
//                 },
//               ),
//               SizedBox(
//                 height: 40,
//               ),
//               reportContainer(
//                 title: 'Monthly Supplies Report',
//                 subTitle:'For Each Tank',
//                 whichReport1: 'Oxygen , Generator , Water',
//                 whichReport2: '',
//                 context: context,
//                 onTap:(){navigateTo(context,widget: MonthlySuppliesReportView(),);},
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
