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

class AddFeed_Screen extends StatelessWidget {
  // var tankNameController = TextEditingController();
  String ?tankName;
  String ?feedName;
  var feedWeightController = TextEditingController();
  var dateController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  String ?selectedMonth;
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
                title: 'AddFeed', backGroundColor: defaultColor, elevation: 0.0
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
                    SizedBox(
                      height: 10,
                    ),
                    myDropDownMenu(
                        label: 'Select Feed Type',
                        listName: FishFarmCubit.get(context).feedIdList,
                       // objectOFClass: objectOfAllTanksName,
                        items: FishFarmCubit.get(context).feedIdList.map(( feed )
                        {
                          return DropdownMenuItem(
                              value: feed,
                              child: Row(
                                children: [
                                  Text(feed,
                                  ),
                                ],
                              )
                          );
                        }).toList(),
                        validator: (value)  {
                          if (value==null) {
                            return 'Feed Type Cant be Empty';
                          }
                          else
                            feedName=value;
                        },
                        onChange: (value){}),
                    SizedBox(
                      height: 10,
                    ),
                    defaultFormText(
                        textInputFormat: "[0-9.]",
                        onTap: ()  {

                        },
                        onChanged: (value){},
                        control: feedWeightController,
                        type: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Feed Weight Cant be Empty';
                          }
                        },
                        label: 'Feed Weight(Kg)',
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
                      onChanged: (){
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    defaultButton(
                        onTap: ()   async {
                          if(formKey.currentState!.validate())
                          {
                           await FishFarmCubit.get(context).getTotalSelectedTankData(tankName: tankName!);
                           await FishFarmCubit.get(context).getMonthlySelectedTankData(tankName: tankName!, selectedMonth: selectedMonth!);
                           await FishFarmCubit.get(context).getDailyReportData(tankName: tankName!, selectedDay: dateController.text);
                           await FishFarmCubit.get(context).getRemainingOfSelectedFeed(feedType: feedName!);
                           // await FishFarmCubit.get(context).getRemainingOfSelectedFeed(feedType: feedName!);
                            FishFarmCubit.get(context).addFeedToTanks(
                              totalFeed:double.parse(feedWeightController.text)+FishFarmCubit.get(context).tankModel!.totalFeed!,
                                tankName: tankName!,
                                datetime: DateTime.now().toString(),
                                feedName: feedName!,
                                feedDatetime: dateController.text,
                                feedWeight: double.parse(feedWeightController.text),
                               dailyTotalFeed:double.parse(feedWeightController.text)+FishFarmCubit.get(context).dailyModel!.dailyFeed!
                            );
                            FishFarmCubit.get(context).addToDailyReport(
                              dailyMortality:FishFarmCubit.get(context).dailyModel!.dailyMortality ??0,
                                remainingPsc: FishFarmCubit.get(context).dailyModel!.remainingPsc??FishFarmCubit.get(context).tankModel!.remaining,
                                tankName: tankName!,
                                day: dateController.text,
                              feedType: feedName,
                              dailyFeed:FishFarmCubit.get(context).dailyModel!.dailyFeed!+double.parse(feedWeightController.text),
                              month: selectedMonth!,
                            );
                            FishFarmCubit.get(context).addToMonthlyReport(
                                tankName: tankName!,
                                month: selectedMonth!,
                                pcsRemaining: FishFarmCubit.get(context).monthlyModel!.pcsRemaining!,
                                totalFeed: FishFarmCubit.get(context).monthlyModel!.totalFeed!+double.parse(feedWeightController.text),
                              totalMortality:  FishFarmCubit.get(context).monthlyModel!.totalMortality!,
                              // day: dateController.text,
                            );
                            FishFarmCubit.get(context).updateRemainingFeed(
                              remainingFeed: FishFarmCubit.get(context).feedTypeModel!.remainingFeed!-double.parse(feedWeightController.text),
                              feedType: feedName!
                            );
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
