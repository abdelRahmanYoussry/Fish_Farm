
import 'package:fish_farm/Shared/AppCubit/Cubit.dart';
import 'package:fish_farm/Shared/AppCubit/States.dart';
import 'package:fish_farm/Shared/Style/Icons.dart';
import 'package:fish_farm/Shared/Componets/components.dart';
import 'package:fish_farm/Shared/Componets/constans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../Shared/Componets/constans.dart';


class DailyReportView extends StatelessWidget {
  var dailyController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  String ?tankName;
  String ?selectedMonth;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FishFarmCubit,FishFarmStates>(
      listener:(context,state){} ,
      builder: (context,state){
        FishFarmCubit cubit=FishFarmCubit.get(context);
        return Scaffold(
          extendBody: true,
          body: Container(
            decoration: BoxDecoration(
                image:DecorationImage(
                    image: AssetImage('assets/image/OverViewblue.png'),
                    fit: BoxFit.fill
                )
            ),
            child: Container(
              padding:const EdgeInsets.only(left: 20,right: 20,top: 120) ,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    myDropDownMenu(
                        label: 'Select Tank',
                        listName: FishFarmCubit.get(context).tanksIdList,
                        // objectOFClass: objectOfAllTanksName,
                        items: FishFarmCubit.get(context).tanksIdList.map(( tank )
                        {
                          return DropdownMenuItem(
                              value: tank,
                              child: Row(
                                children: [
                                  Text(tank,
                                  ),
                                ],
                              )
                          );
                        }).toList(),
                        validator: (value){
                          if (value==null) {
                            return 'Tank Name Cant be Empty';
                          }
                          // print(value);
                          else tankName=value;
                        },
                        onChange: (value){}),
                    // myDropDownMenu(
                    //   label:'Tank Num',
                    //   className: ClassOfAllTanksName,
                    //   listName: listOfAllTankName,
                    //   objectOFClass: objectOfAllTanksName,
                    //   onChange: cubit.functionChangeTankNumMonthlyReport,
                    //   validator:(value) {
                    //     if (value == null)
                    //     {
                    //       return 'Tank Num Cant be Empty';
                    //     }
                    //     else {
                    //       selectedTankName=value.tankName.toString();
                    //       print(value.tankName.toString());
                    //
                    //     }
                    //   },
                    //   items: listOfAllTankName.map((ClassOfAllTanksName tankListNumMonthlyReport )
                    //   {
                    //     return DropdownMenuItem<ClassOfAllTanksName>(
                    //         value: tankListNumMonthlyReport,
                    //         child: Row(
                    //           children: [
                    //             Text(tankListNumMonthlyReport.tankName,
                    //             ),
                    //             SizedBox(
                    //               width:60,
                    //             ),
                    //
                    //           ],
                    //         )
                    //     );
                    //   }).toList(),),
                    SizedBox(
                      height: 30,),
                    defaultFormText(
                      textInputFormat:"[a-zA-Z0-9]",
                      readOnly: true,
                      control: dailyController,
                      type: TextInputType.datetime,
                      validator: (value){
                        if(value.isEmpty)
                        {return "Date Can't be Empty";}
                        else
                          return null;
                      },
                      prefix:Icons.calendar_today_outlined,
                      label: 'Select Date',
                      onTap: (){
                         showDatePicker(
                             context: context,
                             initialDate:DateTime.now(),
                             firstDate: DateTime(2019),
                             lastDate: DateTime(2024) ).then((value) {
                               dailyController.text=DateFormat.yMMMMd().format(value!);
                               selectedMonth=DateFormat.yMMMM().format(value);
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
                        onTap: ()async {
                          if(formKey.currentState!.validate())
                          {
                            await FishFarmCubit.get(context).getTotalSelectedTankData(tankName: tankName!);
                            await FishFarmCubit.get(context).getDailyReportData(
                                tankName: tankName! , selectedDay: dailyController.text);
                            print(dailyController.text+' $tankName '+ selectedMonth!);

                             cubit.isEnable=true;
                             showModalBottomSheet(
                               elevation: 0.0,
                                 backgroundColor: Colors.transparent,
                                 context: context, builder: (context)=>bottomSheetBuilder(context: context));
                           // BottomSheet(
                           //   builder: (context)=>bottomSheetBuilder(),
                           //   onClosing: (){},);
                          }
                        }),
                    SizedBox(
                      height:30 ,
                    ),
                    // if(cubit.userModel!.isAdmin==true)
                    // defaultButton(
                    //     buttonName: 'Add',
                    //     onTap: (){
                    //
                    //     }),
                    // SizedBox(
                    //   height:30 ,
                    // ),
                    // Row(
                    //   children: [
                    //     ElevatedButton(
                    //         style: ButtonStyle(
                    //
                    //           backgroundColor: MaterialStateProperty.all(Colors.grey.shade300)
                    //         ),
                    //         onPressed:()=>cubit.functionShowButtons(),
                    //           // cubit.isEnable? print('submit is ok'):print("submit is not ok");
                    //
                    //         child: Column(
                    //           children:
                    //           [
                    //           Image.asset('assets/image/report.png',
                    //           height: 100,width: 100,
                    //           ),
                    //             Text('Test',
                    //               style: TextStyle(
                    //                 fontSize: 25,color: Colors.black
                    //               ),)
                    //         ],)),
                    //     SizedBox(
                    //       width: 100,
                    //     ),
                    //     ElevatedButton(
                    //         style: ButtonStyle(
                    //             backgroundColor: MaterialStateProperty.all(Colors.grey.shade300)
                    //         ),
                    //         onPressed: (){},
                    //         child: Column(
                    //           children:
                    //           [
                    //             Image.asset('assets/image/report.png',
                    //               height: 100,width: 100,
                    //             ),
                    //             Text('Dead EEl',
                    //               style: TextStyle(
                    //                   fontSize: 25,color: Colors.black
                    //               ),)
                    //           ],)),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height:60 ,
                    // ),
                    // Row(
                    //   children: [
                    //     ElevatedButton(
                    //         style: ButtonStyle(
                    //             backgroundColor: MaterialStateProperty.all(Colors.grey.shade300)
                    //         ),
                    //         onPressed: (){},
                    //         child: Column(
                    //           children:
                    //           [
                    //             Image.asset('assets/image/report.png',
                    //               height: 100,width: 100,
                    //             ),
                    //             Text('Dead EEl',
                    //               style: TextStyle(
                    //                   fontSize: 25,color: Colors.black
                    //               ),)
                    //           ],)),
                    //     SizedBox(
                    //       width: 100,
                    //     ),
                    //     ElevatedButton(
                    //         style: ButtonStyle(
                    //             backgroundColor: MaterialStateProperty.all(Colors.grey.shade300)
                    //         ),
                    //         onPressed: (){},
                    //         child: Column(
                    //           children:
                    //           [
                    //             Image.asset('assets/image/report.png',
                    //               height: 100,width: 100,
                    //             ),
                    //             Text('Dead EEl',
                    //               style: TextStyle(
                    //                   fontSize: 25,color: Colors.black
                    //               ),)
                    //           ],)),
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
          ),

        );
      },
    );
  }
Widget bottomSheetBuilder({@required context})=>Padding(
  padding: const EdgeInsets.only(bottom: 60,left: 10,right: 10),
  child:   Container(
    width: 200,
    height: 300,
    decoration: BoxDecoration(
      color: Colors.black87.withOpacity(0.2),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(30),
        right: Radius.circular(30),
      )
    ),
    child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text('$tankName',style: TextStyle(
              color: Colors.white,fontSize: 26
            ),),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(dailyController.text,style: TextStyle(
              color: Colors.white,fontSize: 26
            ),),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text('EEls Size :',style: TextStyle(
                    color: Colors.white,fontSize: 20
                ),),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(FishFarmCubit.get(context).tankModel!.avgPsc.toString(),style: TextStyle(
                    color: Colors.white,fontSize: 20
                ),),
              ),

            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text('Tank Total Weight(Kg) :',style: TextStyle(
                    color: Colors.white,fontSize: 20
                ),),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(FishFarmCubit.get(context).tankModel!.weight.toString(),style: TextStyle(
                    color: Colors.white,fontSize: 20
                ),),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text('Mortality :',style: TextStyle(
                    color: Colors.white,fontSize: 20
                ),),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(FishFarmCubit.get(context).tankModel!.totalMortality.toString(),style: TextStyle(
                    color: Colors.white,fontSize: 20
                ),),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text('Remaining  :',style: TextStyle(
                    color: Colors.white,fontSize: 20
                ),),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(FishFarmCubit.get(context).tankModel!.remaining.toString(),style: TextStyle(
                    color: Colors.white,fontSize: 20
                ),),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text('Feed Type  :',
                  style: TextStyle(color: Colors.white,fontSize: 20
                ),),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(FishFarmCubit.get(context).dailyModel!.feedType.toString(),
                  style: TextStyle(color: Colors.white,fontSize: 20
                ),),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text('Daily Feed Weight(Kg):',
                  style: TextStyle(color: Colors.white,fontSize: 20
                ),),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(FishFarmCubit.get(context).dailyModel!.dailyFeed.toString(),
                  style: TextStyle(color: Colors.white,fontSize: 20
                ),),
              ),
            ],
          ),
        ],
      ),
    ),
  ),
);
}
