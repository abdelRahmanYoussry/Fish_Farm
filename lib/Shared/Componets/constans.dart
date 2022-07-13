import 'package:fish_farm/Modules/Reports/Daily_Report/dailyRepotrs_view.dart';
import 'package:fish_farm/Modules/Reports/Monthly_Report/Monthly_Reports_Layout.dart';
import 'package:fish_farm/Modules/Reports/Stock_Report/StockReports.dart';
import 'package:flutter/material.dart';

import '../../Modules/Reports/Monthly_Report/Monthly_Eel_Report/monthlyEelReport_view/monthlyEelReport_view.dart';
import '../Style/Icons.dart';
int currentIndex=0;
ClassOfAllTanksName?objectOfAllTanksName;
// TankProcessMonthlyItemClass?tankProcessMonthlyReportSelectedUser;
// SuppliesClass?suppliesSelectedUser;
List <BottomNavigationBarItem> bottomNavBarList=[
  BottomNavigationBarItem(
    icon: Icon(MyFlutterIcon1.monthly2,color: Colors.black),
      label: 'Monthly Report',
  ),
  BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today_outlined,color: Colors.black,),label: 'Daily Reports'
  ),
  BottomNavigationBarItem(
      icon: Icon(MyFlutterIcon1.stock,color: Colors.black,),label: 'Stock Report'
  ),
];
List<Widget> reportsScreens=[

  MonthlyReportScreen(),
  DailyReportView(),
  StockReports(),
];


// List<ClassOfAllTanksName> listOfAllTankName = <ClassOfAllTanksName>[
//   const ClassOfAllTanksName('A1',),
//   const ClassOfAllTanksName('A2',),
//   const ClassOfAllTanksName('A3',),
//   const ClassOfAllTanksName('A4',),
//   const ClassOfAllTanksName('A5',),
//   const ClassOfAllTanksName('A6',),
//   const ClassOfAllTanksName('A7',),
//   const ClassOfAllTanksName('A8',),
//   const ClassOfAllTanksName('C5',),
//   const ClassOfAllTanksName('C6',),
//   const ClassOfAllTanksName('C7',),
//   const ClassOfAllTanksName('C8',),
// ];

class ClassOfAllTanksName {
  const ClassOfAllTanksName(this.tankName);
  final String tankName;

}

// class TankProcessMonthlyItemClass{
//   const TankProcessMonthlyItemClass(this.processName,this.icon);
//   final String processName;
//   final Icon   icon;
//
// }
// List<TankProcessMonthlyItemClass> listProcessSelectedMonthlyReport = <TankProcessMonthlyItemClass>[
//   const TankProcessMonthlyItemClass('Quantity',Icon(Icons.circle,color:Colors.red,),),
//   const TankProcessMonthlyItemClass('Weight',Icon(MyFlutterIcon1.weight,size: 25,)),
//   const TankProcessMonthlyItemClass('ِAverage',Icon(Icons.circle,color:  Colors.grey,)),
//   const TankProcessMonthlyItemClass('Mortality',Icon(Icons.circle,color:  const Color(0xFF167F67),)),
//   const TankProcessMonthlyItemClass('Remaining',Icon(Icons.circle,color:Colors.red,),),
//   const TankProcessMonthlyItemClass('Feed',Icon(Icons.circle,color:Colors.red,),),
// ];
//
// class SuppliesClass{
//   const SuppliesClass(this.supplyName,this.icon);
//   final String supplyName;
//   final Icon   icon;
//
// }
// List<SuppliesClass> suppliesList = <SuppliesClass>[
//   const SuppliesClass('Oxygen',Icon(Icons.airline_seat_flat,color:Colors.grey),),
//   const SuppliesClass('Generator',Icon(Icons.electric_car,color:Colors.grey,)),
//   const SuppliesClass('Water',Icon(Icons.waterfall_chart,color:  Colors.grey,)),
// ];

String ?uid;