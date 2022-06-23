import 'package:fish_farm/Shared/AppCubit/Cubit.dart';
import 'package:fish_farm/Shared/AppCubit/States.dart';

import 'package:fish_farm/Shared/Componets/components.dart';
import 'package:fish_farm/Shared/Componets/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class MonthlySuppliesReportView extends StatelessWidget {
  var monthController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FishFarmCubit,FishFarmStates>(
      listener:(context,state){} ,
      builder: (context,state){
        FishFarmCubit cubit=FishFarmCubit.get(context);
        return Scaffold(
          appBar: AppBar(title: textField(
              text: 'Monthly Supplies Reports'
          ),),
          body: Container(padding:const EdgeInsets.only(left: 20,right: 20,top: 20) ,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  myDropDownMenu(
                    label:'Please Select Tank',
                    className: ClassOfAllTanksName,
                    listName: listOfAllTankName,
                    myDropDownValue: objectOfAllTanksName,
                    onChange: cubit.functionChangeTankNumMonthlyReport,
                    validator:(value) {
                      if (value == null) {
                        return 'Tank Num Cant be Empty';
                      }
                      else return null;
                    },
                    myDropDownItems: listOfAllTankName.map((ClassOfAllTanksName tankListNumMonthlyReport )
                    {
                      return DropdownMenuItem<ClassOfAllTanksName>(
                          value: tankListNumMonthlyReport,
                          child: Row(
                            children: [
                              Text(tankListNumMonthlyReport.tankName,
                               ),
                              SizedBox(
                                width:60,
                              ),

                            ],
                          )
                      );
                    }).toList(),),
                  SizedBox(
                    height: 30,),
                  myDropDownMenu(
                    label: 'Oxygen , Generator , Water ',
                    className: SuppliesClass,
                    listName: suppliesList,
                    myDropDownValue: suppliesSelectedUser,
                    validator: (value){
                      if(value==null)
                      { return'supply Cant be Empty';}
                      else return null;},
                    onChange: cubit.functionChangeSupplyMonthlyReport,
                    myDropDownItems: suppliesList.map((SuppliesClass suppliesList ) {
                      return DropdownMenuItem<SuppliesClass>(
                          value: suppliesList,
                          child: Row(
                            children: [
                              Text(suppliesList.supplyName,
                                style:TextStyle(
                                    fontSize: 20, color: Colors.black
                                ),),
                              SizedBox(
                                width:60,
                              ),
                              suppliesList.icon,
                            ],
                          )
                      );
                    }).toList(),
                  ),
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
                        lastDate: DateTime(2023),
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
                      onTap: (){
                        if(formKey.currentState!.validate())
                        {
                          print(monthController.text);
                          print(objectOfAllTanksName!.tankName.toString());
                          print(suppliesSelectedUser!.supplyName.toString());
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

}
