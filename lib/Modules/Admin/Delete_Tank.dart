import 'package:fish_farm/Shared/AppCubit/Cubit.dart';
import 'package:fish_farm/Shared/AppCubit/States.dart';
import 'package:fish_farm/Shared/Style/Icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../Shared/Componets/components.dart';
import '../../Shared/Componets/constans.dart';
import '../../Shared/Style/style.dart';

class DeleteTank_Screen extends StatelessWidget {
  var tankNameController = TextEditingController();
  String ?tankName;
  // String ?feedName;
  // var tankNameController2 = TextEditingController();
  // var dateController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  // String ?selectedMonth;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FishFarmCubit, FishFarmStates>(
      listener: (context, state) {
      },
      builder: (context, state) {

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: defaultAppBar(context: context,
                title: 'DeleteTank',
                backGroundColor: defaultColor, elevation: 0.0
            ),
          ),
          backgroundColor: defaultColor,
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10, top: 30),
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    myDropDownMenu(
                        label: 'Select Tank',
                        listName: FishFarmCubit.get(context).tanksIdList,
                       // objectOFClass: objectOfAllTanksName,
                        myDropDownItems: FishFarmCubit.get(context).tanksIdList.map(( tank )
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
                    SizedBox(
                      height: 20,
                    ),
                    // myDropDownMenu(
                    //     label: 'Select Feed Type',
                    //     listName: FishFarmCubit.get(context).feedIdList,
                    //    // objectOFClass: objectOfAllTanksName,
                    //     items: FishFarmCubit.get(context).feedIdList.map(( feed )
                    //     {
                    //       return DropdownMenuItem(
                    //           value: feed,
                    //           child: Row(
                    //             children: [
                    //               Text(feed,
                    //               ),
                    //             ],
                    //           )
                    //       );
                    //     }).toList(),
                    //     validator: (value)  {
                    //       if (value==null) {
                    //         return 'Feed Type Cant be Empty';
                    //       }
                    //       else
                    //         feedName=value;
                    //     },
                    //     onChange: (value){}),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    defaultFormText(
                        textInputFormat: "[a-zA-Z0-9]",
                        onTap: ()  {},
                        onChanged: (value){},
                        control: tankNameController,
                        type: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Tank Name Cant be Empty';
                          }
                        },
                        label: 'Confirm Tank Name',
                        prefix: Icons.circle),
                    SizedBox(
                      height: 30
                      ,
                    ),
                    // defaultFormText(
                    //   textInputFormat:"[a-zA-Z0-9]",
                    //   readOnly: true,
                    //   control: dateController,
                    //   type: TextInputType.datetime,
                    //   validator: (value){
                    //     if(value.isEmpty)
                    //     {return "Date Can't be Empty";}
                    //     else
                    //       return null;
                    //   },
                    //   prefix:Icons.calendar_today_outlined,
                    //   label: 'Select Date',
                    //   onTap: (){
                    //     showDatePicker(
                    //         context: context,
                    //         initialDate:DateTime.now(),
                    //         firstDate: DateTime(2019),
                    //         lastDate: DateTime(2024) ).then((value) {
                    //       dateController.text=DateFormat.yMMMMd().format(value!);
                    //       selectedMonth=DateFormat.yMMMM().format(value);
                    //     });
                    //   },
                    //   onSubmit: (value){
                    //     print(value);
                    //   },
                    //   onChanged: (){
                    //
                    //   },
                    // ),
                    // SizedBox(
                    //   height: 30,
                    // ),
                    defaultButton(
                        onTap: ()    {
                          if(formKey.currentState!.validate())
                          {
                          if(tankName==tankNameController.text){
                            FishFarmCubit.get(context).deleteTank(tankName: tankName!);
                            showToast(text: 'Success Delete  ', state: ToastState.Success);

                          }else{
                            showToast(text: 'The Tank Names not Match ', state: ToastState.Error);
                          }
                          }
                          FocusScope.of(context).unfocus();
                        },
                        buttonName: 'Delete'
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
