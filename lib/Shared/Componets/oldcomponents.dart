//     Widget dropDownTankNumMonthlyReport ({
// required Text hint,
// }){
// return DropdownButtonFormField<TankNumMonthlyReportItemClass> (
// validator:(value){
// if(value==null)
// {
// return'Tank Num Cant be Empty';
// }
// return null;
// } ,
// decoration: InputDecoration(
// border: OutlineInputBorder()
// ),
// iconSize: 30,
// iconEnabledColor: Colors.blue,
// hint:hint,
// isExpanded: true,
// icon: Icon(Icons.anchor),
// value: tankNumMonthlyReportSelectedUser,
// onChanged:changeTankNumMonthlyReport,
// items: tankListNumMonthlyReport.map((TankNumMonthlyReportItemClass tankListNumMonthlyReport ) {
// return DropdownMenuItem<TankNumMonthlyReportItemClass>(
// value: tankListNumMonthlyReport,
// child: Row(
// children: [
// Text(tankListNumMonthlyReport.tankName,
// style:TextStyle(
// fontSize: 25,
// color: Colors.black
// ),),
// SizedBox(
// width:60,
// ),
// tankListNumMonthlyReport.icon,
// ],
// )
// );
// }).toList(),
//
// );
// }
//

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


// Widget dropDownProcessSelectedMonthlyReport ({
//   required Text hint,
// }){
//   return DropdownButtonFormField<TankProcessMonthlyItemClass> (
//     validator:(value){
//       if(value==null){
//         return'Process Cant be Empty';
//       }
//       return null;
//     } ,
//     decoration: InputDecoration(
//         border: OutlineInputBorder()
//     ),
//     iconSize: 30,
//     iconEnabledColor: Colors.blue,
//     hint:hint,
//     isExpanded: true,
//     icon: Icon(Icons.anchor),
//     value: tankProcessMonthlyReportSelectedUser,
//     onChanged: (value){
//       tankProcessMonthlyReportSelectedUser=value!;
//       emit(ProcessMonthlyReportChanged());
//     },
//     items: listProcessSelectedMonthlyReport.map((TankProcessMonthlyItemClass listProcessSelectedMonthlyReport ) {
//       return DropdownMenuItem<TankProcessMonthlyItemClass>(
//           value: listProcessSelectedMonthlyReport,
//           child: Row(
//             children: [
//               Text(listProcessSelectedMonthlyReport.processName,
//                 style:TextStyle(
//                     fontSize: 20,
//                     color: Colors.black
//                 ),),
//               SizedBox(
//                 width:60,
//               ),
//               listProcessSelectedMonthlyReport.icon,
//             ],
//           )
//       );
//     }).toList(),
//
//   );
// }


//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
// GestureDetector(
//     onTap: (){
//       Navigator.push(context,
//           MaterialPageRoute(builder: (context)=>ReportScreen()));
//     },
//     child: Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Container(
//         child: Column(
//           children: [
//             Image.asset('assets/report.png',
//               width: 90,height: 90,
//             ),
//             Text(
//               'Reports',
//               style: TextStyle(fontSize: 30),
//             ),
//           ],
//         ),
//         decoration: BoxDecoration(
//           boxShadow: [BoxShadow(
//               color: Colors.grey.withOpacity(0.6),
//             spreadRadius: 5,
//             blurRadius: 5,
//             offset: Offset(0,2)
//           )],
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//
//       ),
//     )
// ) ,

// Column(
//     children: [
//       Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Row(
//           children: [
//             myGestureDetectorWithIcon(
//                 context,
//                 icon: Icon(MyFlutterIcon1.report),
//                 name: 'Reports',
//                 onTap:()=> navigateTo(context, widget:ReportScreen()),
//               containerColor:HexColor('#110088'),
//               shadowColor: Colors.blue,
//               iconColor: Colors.blue,
//             // Column(
//             //   children: [
//             //     IconButton(icon:Icon(MyFlutterIcon1.report) ,
//             //       onPressed: () { navigateTo(context, widget:ReportScreen() ); },
//             //       iconSize: 100,color: HexColor('#110088'),
//             //     ),
//             //     Text('Reports',
//             //       style: TextStyle(fontSize: 25,color: HexColor('#110088')),
//             //     )
//             //   ],
//             // ),
//
//             // myGestureDetector(
//             //     context,
//             //     image:'assets/image/report.png',
//             //     name: 'Reports',
//             //     onTap: () { navigateTo(context, widget:ReportScreen() ); }),
//             )
//           ],
//         ),
//       ),
//         ],
//       ),
// textField(text: 'An eel can live for up to 85 years',fontSize: 22),