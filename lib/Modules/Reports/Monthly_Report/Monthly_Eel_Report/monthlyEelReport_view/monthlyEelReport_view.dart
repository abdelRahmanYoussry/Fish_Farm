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
                  dropDownReports(
                      label:'Tank Num',
                      className: ClassOfAllTanksName,
                      listName: listOfAllTankName,
                      objectOFClass: objectOfAllTanksName,
                      onChange: cubit.functionChangeTankNumMonthlyReport,
                      validator:(value) {
                        if (value == null) {
                          return 'Tank Num Cant be Empty';
                        }
                        else return null;
                      },
                      items: listOfAllTankName.map((ClassOfAllTanksName tankListNumMonthlyReport )
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
                    dropDownReports(
                        label: 'Quantity , Weight , ِAverage , Mortality  Remaining , Feed',
                        className: TankProcessMonthlyItemClass,
                        listName: listProcessSelectedMonthlyReport,
                        objectOFClass: tankProcessMonthlyReportSelectedUser,
                        validator: (value){
                          if(value==null)
                          { return'Process Cant be Empty';}
                          else return null;},
                        onChange: cubit.functionChangeProcessMonthlyReport,
                        items: listProcessSelectedMonthlyReport.map((TankProcessMonthlyItemClass listProcessSelectedMonthlyReport ) {
                        return DropdownMenuItem<TankProcessMonthlyItemClass>(
                        value: listProcessSelectedMonthlyReport,
                          child: Row(
                                     children: [
                                      Text(listProcessSelectedMonthlyReport.processName,
                                      style:TextStyle(
                                        fontSize: 20, color: Colors.white
                                        ),),
                                      SizedBox(
                                    width:60,
                                   ),
                            listProcessSelectedMonthlyReport.icon,
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
                     onTap: (){
                       if(formKey.currentState!.validate())
                       {

                         FishFarmCubit.get(context).getAllTankData();
                       print(monthController.text);
                       print(objectOfAllTanksName!.tankName.toString());
                       print(tankProcessMonthlyReportSelectedUser!.processName.toString());
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
