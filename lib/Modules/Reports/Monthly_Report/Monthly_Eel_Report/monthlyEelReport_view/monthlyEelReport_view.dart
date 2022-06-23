import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fish_farm/Models/DailyModel.dart';
import 'package:fish_farm/Shared/AppCubit/Cubit.dart';
import 'package:fish_farm/Shared/AppCubit/States.dart';
import 'package:fish_farm/Shared/Componets/components.dart';
import 'package:fish_farm/Shared/Componets/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class MonthlyReportScreen extends StatelessWidget {
var monthController=TextEditingController();
String ?tankName;
String ?selectedMonth;

var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FishFarmCubit,FishFarmStates>(
      listener:(context,state){} ,
      builder: (context,state){
        FishFarmCubit cubit=FishFarmCubit.get(context);
        return Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: textField(
              text: 'Monthly Eel Reports'
          ),),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/image/AllTank3.png'
                ),
                    fit: BoxFit.fill
              )
            ),
            padding:const EdgeInsets.only(left: 20,right: 20,top: 120) ,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  myDropDownMenu(
                      label:'Tank Name',
                      listName:  FishFarmCubit.get(context).tanksIdList,
                      validator:(value) {
                        if (value == null) {
                          return 'Tank Num Cant be Empty';
                        }
                        else tankName =value;
                      },
                      myDropDownItems:  FishFarmCubit.get(context).tanksIdList.map(( tank)
                                    {
                               return DropdownMenuItem(
                             value: tank,
                              child: Row(
                         children: [
                              Text(tank,
                              ),
                            SizedBox(
                            width:60,
                            ),
                               ],
                                )
                                    );
                                      }).toList(),
                                        onChange:(value){}),
                   SizedBox(
                     height: 30,),
                   defaultFormText(
                     textInputFormat:"[a-zA-Z0-9]",
                     readOnly: true,
                       control: monthController,
                       type: TextInputType.datetime,
                       validator: (value){
                         if(value.isEmpty)
                         {return "Date Can't be Empty";}
                         else
                         return null;
                       },
                  prefix: Icons.calendar_today_outlined, label: 'Select Date',
                      onTap: (){
                   showMonthPicker(
                       context: context,
                       initialDate: DateTime.now(),
                       firstDate: DateTime(2020),
                     lastDate: DateTime(2205),
                   ).then((value) {
                     monthController.text=DateFormat.yMMMM().format(value!);
                   });
                      },
                     onSubmit: (value){
                         print(value);
                     },
                     onChanged: (){},
                   ),
                 SizedBox(
                   height:30 ,
                 ),
                 defaultButton(
                     buttonName: 'Submit',
                     onTap: ()async{
                       if(formKey.currentState!.validate())
                       {
                         await  cubit.getTotalSelectedTankData(tankName:tankName! );
                         // cubit.getMonthlySelectedTankData(tankName: tankName!, selectedMonth: monthController.text);
                       await  cubit.getMonthDataByDays(tankName: tankName!, selectedMonth: monthController.text);

                   await  showModalBottomSheet(context: context ,builder:(context)=>
                             bottomSheetBuilder(context: context, Models: cubit.dailyList));
                     }
                     }),
                ],
              ),
            ),
          ),
        );
      },
    );

  }

Widget bottomSheetBuilder({required context,required List<DailyModel> Models})  {
  List<TableRow> rows = <TableRow>[
    new TableRow(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Text('Date'
              ,style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold) ,textAlign: TextAlign.center,),
        ),
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Text('Mor'
              ,style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold) ,textAlign: TextAlign.center),
        ),
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Text('Rem'
              ,style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold) ,textAlign: TextAlign.center),
        ),
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Text('Feed(Kg)'
              ,style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold) ,textAlign: TextAlign.center),
        ),
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Text('F.Type'
              ,style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold) ,textAlign: TextAlign.center),
        ),
      ],
    ),
  ];
  for (DailyModel model in Models) {
    TableRow row=new TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(model.day!
                ,style:TextStyle(fontSize: 22) ,textAlign: TextAlign.left),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(model.dailyMortality.toString()
                ,style:TextStyle(fontSize: 22) ,textAlign: TextAlign.center),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(model.remainingPsc.toString()
                ,style:TextStyle(fontSize: 22) ,textAlign: TextAlign.center),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(model.dailyFeed.toString()
                ,style:TextStyle(fontSize: 22) ,textAlign: TextAlign.center),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(model.feedType??'No Feed'
                ,style:TextStyle(fontSize: 22) ,textAlign: TextAlign.center),
          ),
        ]);
    rows.add(row);
  }
 return SingleChildScrollView(
   child: Padding(
      padding: const EdgeInsets.only(top: 10,bottom: 60,
          left: 5,right: 5),
      child:   Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text('$tankName',style: TextStyle(
                color: Colors.black,fontSize: 30
            ),),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Text(monthController.text,style: TextStyle(
                color: Colors.black,fontSize: 30
            ),),
          ),
          Table(
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(5),
                1: FlexColumnWidth(2),
                2: FixedColumnWidth(60),
                3: FixedColumnWidth(50),
                4: FixedColumnWidth(100),
              },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder.all(width: 2),
            children: rows
          ),
        ],
      ),
    ),
 );

 // List<TableRow> rows = <TableRow>[
 //   new TableRow(
 //     children: <Widget>[
 //       Padding(
 //         padding: const EdgeInsets.all(1.0),
 //         child: Text('Date'
 //             ,style:TextStyle(fontSize: 20) ,textAlign: TextAlign.center),
 //       ),
 //       Padding(
 //         padding: const EdgeInsets.all(1.0),
 //         child: Text('Mor'
 //             ,style:TextStyle(fontSize: 20) ,textAlign: TextAlign.center),
 //       ),
 //       Padding(
 //         padding: const EdgeInsets.all(1.0),
 //         child: Text('Rem'
 //             ,style:TextStyle(fontSize: 20) ,textAlign: TextAlign.center),
 //       ),
 //       Padding(
 //         padding: const EdgeInsets.all(1.0),
 //         child: Text('F.Weight(Kg)'
 //             ,style:TextStyle(fontSize: 20) ,textAlign: TextAlign.center),
 //       ),
 //       Padding(
 //         padding: const EdgeInsets.all(1.0),
 //         child: Text('F.Type'
 //             ,style:TextStyle(fontSize: 20) ,textAlign: TextAlign.center),
 //       ),
 //     ],
 //   ),
 // ];
 // for (int i=0;i>FishFarmCubit.get(context).dailyList.length;i++) {
 //   rows.add(
 //     new TableRow(
 //       doc: doc.widgetList,
 //     ),
 //   );
 // }
 //
 // return new SingleChildScrollView(child: new Table(children: rows));
}}
