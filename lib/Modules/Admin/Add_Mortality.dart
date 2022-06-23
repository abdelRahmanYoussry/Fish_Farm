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

class AddMortality_Screen extends StatelessWidget {
  // var tankNameController = TextEditingController();
  String ?tankName;
  String ?selectedMonth;
  var mortalityPscController = TextEditingController();
  var dateController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FishFarmCubit, FishFarmStates>(
      listener: (context, state) {
         if(state is AddTanksMortalityLoadingState||state is AddToDailyReportLoadingState||state is AddToMonthlyReportLoadingState){
        showToast(text: 'Loading please Wait', state: ToastState.Warning);
        }
         else if(state is AddTanksMortalitySuccessState||state is AddToDailyReportSuccessState ||state is AddToMonthlyReportSuccessState ){
          showToast(text: 'Mortality has been Added', state: ToastState.Success);
        }else if(state is AddTanksMortalityErrorState||state is AddToDailyReportErrorState||state is AddToMonthlyReportErrorState ){
          showToast(text: 'Error while Add Mortality', state: ToastState.Error);
        }
      },
      builder: (context, state) {

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: defaultAppBar(context: context,
                title: 'AddMortality', backGroundColor: defaultColor, elevation: 0.0
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
                   // DropdownButtonFormField(
                   //     items:FishFarmCubit.get(context).tanksIdList.map((tank){
                   //       return DropdownMenuItem(
                   //            value: tank,
                   //           child:
                   //           Row(
                   //             children: [
                   //                         Text(tank,),
                   //                         SizedBox(
                   //                           width:60,
                   //                         ),
                   //                       ],
                   //                     )
                   //       );
                   //     } ).toList(),
                   //     onChanged: (value){}),
                    myDropDownMenu(
                        label: 'Select Tank',
                        listName: FishFarmCubit.get(context).tanksIdList,
                        myDropDownValue: objectOfAllTanksName,
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
                          if (value.isEmpty) {
                            return 'Tank Name Cant be Empty';
                          }
                          else tankName=value;
                        },
                        onChange: (value){}),
                    SizedBox(
                      height: 10,
                    ),
                    // defaultFormText(
                    //   textInputFormat:"[a-zA-Z0-9]",
                    //   onTap: (){
                    //   },
                    //   onChanged: (value){},
                    //     control: tankNameController,
                    //     type: TextInputType.text,
                    //     validator: (value) {
                    //       if (value.isEmpty) {
                    //         return 'Name Cant be Empty';
                    //       }
                    //     },
                    //     label: 'Tank Num',
                    //     prefix: Icons.circle),
                    SizedBox(
                      height: 10,
                    ),
                    defaultFormText(
                        textInputFormat: "[0-9]",
                        onTap: (){},
                        onChanged: (value){},
                        control: mortalityPscController,
                        type: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Mortality Count Cant be Empty';
                          }
                        },
                        label: 'Mortality Count',
                        prefix: MyFlutterIcon1.glassEel),
                    SizedBox(
                      height: 10,
                    ),
                    defaultFormText(
                      textInputFormat:"[a-zA-Z0-9]",
                      readOnly: true,
                      control: dateController,
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
                          dateController.text=DateFormat.yMMMMd().format(value!);
                          selectedMonth=DateFormat.yMMMM().format(value);
                        });
                      },
                      onSubmit: (value){
                        print(value);
                      },
                      onChanged: (){},
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    defaultButton(
                        onTap: ()  async {
                          if (formKey.currentState!.validate()) {
                            await FishFarmCubit.get(context).getTotalSelectedTankData(tankName: tankName!);
                            await FishFarmCubit.get(context).getDailyMortalityInTankCollection(tankName: tankName!,selectedDay:dateController.text );
                            await FishFarmCubit.get(context).getMonthlySelectedTankData(tankName: tankName!, selectedMonth: selectedMonth! );
                            await FishFarmCubit.get(context).getDailyReportData(tankName: tankName!, selectedDay: dateController.text);
                            //prevent of became minis Remaining Psc
                            if(FishFarmCubit.get(context).tankModel!.remaining!>=int.parse(mortalityPscController.text,)
                            ||FishFarmCubit.get(context).dailyModel!.remainingPsc!>=int.parse(mortalityPscController.text,)
                            ||FishFarmCubit.get(context).monthlyModel!.pcsRemaining!>=int.parse(mortalityPscController.text,)
                            ){
                              FishFarmCubit.get(context).addMortalityToTanks(
                                  tankName: tankName!,
                                  datetime: DateTime.now().toString(),
                                  mortalityDatetime: dateController.text,
                                  totalDailyMortality:FishFarmCubit.get(context).tankDailyMortality!+int.parse(mortalityPscController.text,) ,
                                  totalTankMortality:FishFarmCubit.get(context).tankModel!.totalMortality!+int.parse(mortalityPscController.text),
                                  remaining: FishFarmCubit.get(context).tankModel!.remaining!-(int.parse(mortalityPscController.text)),
                                  mortalityCount: int.parse(mortalityPscController.text,)
                              );
                              FishFarmCubit.get(context).addToDailyReport(
                                  tankName: tankName!, day: dateController.text,
                                  dailyMortality:FishFarmCubit.get(context).dailyModel!.dailyMortality!+int.parse(mortalityPscController.text,)  ,
                                  remainingPsc: FishFarmCubit.get(context).tankModel!.remaining!-(int.parse(mortalityPscController.text)),
                                  dailyFeed: FishFarmCubit.get(context).dailyModel!.dailyFeed??0,
                                  month: selectedMonth
                              );
                              FishFarmCubit.get(context).addToMonthlyReport(
                                totalMortality:FishFarmCubit.get(context).monthlyModel!.totalMortality!+int.parse(mortalityPscController.text) ,
                                tankName: tankName!, month: selectedMonth!,
                                pcsRemaining: FishFarmCubit.get(context).tankModel!.psc!-(FishFarmCubit.get(context).monthlyModel!.totalMortality!+int.parse(mortalityPscController.text)),
                                day: dateController.text,
                              );

                            }
                            else if(FishFarmCubit.get(context).tankModel!.remaining!<int.parse(mortalityPscController.text,)
                          ||FishFarmCubit.get(context).dailyModel!.remainingPsc!>=int.parse(mortalityPscController.text,)
                          ||FishFarmCubit.get(context).monthlyModel!.pcsRemaining!>=int.parse(mortalityPscController.text,))
                          {
                            showToast(text: 'Cant Make Mortality Higher than the remaining Psc , Remaining Psc is: ${FishFarmCubit.get(context).tankModel!.remaining!}',
                                state: ToastState.Error);
                          }


                            FocusScope.of(context).unfocus();
                          }
                        },
                        buttonName: 'Submit'
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
