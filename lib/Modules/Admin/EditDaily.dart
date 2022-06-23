import 'package:fish_farm/Models/FeedTypeModel.dart';
import 'package:fish_farm/Modules/Admin/Add_Layout.dart';
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

class EditDaily_Screen extends StatelessWidget {
  // var tankNameController = TextEditingController();
  String ?tankName;
  String ?feedName;
  var feedWeightController = TextEditingController();
  var mortalityController = TextEditingController();
  var dateController = TextEditingController();
  int? newDailyMortality;
  num? newDailyFeedWeight;
  num? newDailyRemainingPsc;
  int? newMonthlyMortality;
  num? newMonthlyFeedWeight;
  num? newMonthlyRemainingPsc;
  int? newTotalMortality;
  num? newTotalFeedWeight;
  num? newTotalRemainingPsc;
  var formKey = GlobalKey<FormState>();
  var showDailyFormKey = GlobalKey<FormState>();
  String ?selectedMonth;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FishFarmCubit, FishFarmStates>(
      listener: (context, state) {
        // if(state is EditTanksDataLoadingState){
        //   showToast(text: 'Please Wait', state: ToastState.Warning);
        // }
        // if(state is EditTanksDataSuccessState){
        //   showToast(text: 'Edit has been Added', state: ToastState.Success);
        // }
        // if(state is EditTanksDataErrorState){
        //   showToast(text: 'Error While Editing ', state: ToastState.Error);
        // }
      },
      builder: (context, state) {
        var cubit=FishFarmCubit.get(context);
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: defaultAppBar(context: context,
                title: 'Edit In Day', backGroundColor: defaultColor, elevation: 0.0
            ),
          ),
          backgroundColor: defaultColor,
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
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
                            else tankName=value;
                          },
                          onChange: (value){}),
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
                        onSubmit: (value){print(value);},
                        onChanged: (){},
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultButton(
                          onTap: ()   async {
                            if(formKey.currentState!.validate())
                            {
                            await  cubit.getDailyReportData(tankName: tankName!, selectedDay: dateController.text);
                            await  cubit.getMonthlySelectedTankData(tankName: tankName!, selectedMonth: selectedMonth!);
                            await cubit.getTotalSelectedTankData(tankName: tankName!);
                                cubit.getAllFeedTypesData();
                            if(cubit.dailyModel!.feedType!=null) {
                              await cubit.getRemainingOfSelectedFeed(feedType: cubit.dailyModel!.feedType!);
                              await cubit.getIdDailyFeed(tankName: tankName!, day: dateController.text);
                            }
                            if(cubit.dailyModel!.dailyMortality!>0){
                          await  cubit.getIdDailyMortality(tankName: tankName!, day: dateController.text);
                            }
                              feedWeightController.text=cubit.dailyModel!.dailyFeed.toString();
                              mortalityController.text=cubit.dailyModel!.dailyMortality.toString();
                              print(cubit.dailyModel!.dailyMortality.toString());
                              feedName=cubit.dailyModel!.feedType.toString();

                              
                            }
                          },
                          buttonName: 'Submit'
                      ),
                      if(cubit.dailyModel!=null)
                        SizedBox(
                          height: 30,
                        ),
                      if(cubit.dailyModel!=null)
                        Form(
                          key: showDailyFormKey,
                          child: Container(
                            height: 400,
                            width: 250,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0,right: 8,left: 8,bottom: 10),
                              child: Column(
                                children: [
                                  Text(FishFarmCubit.get(context).dailyModel!.tankName!,
                                    style: TextStyle(fontSize: 20,
                                        fontWeight:FontWeight.bold ),),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(FishFarmCubit.get(context).dailyModel!.day!,
                                    style: TextStyle(fontSize: 20,
                                        fontWeight:FontWeight.bold ),),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  if(cubit.dailyModel!.dailyMortality!>0)
                                  defaultFormText(
                                      borderColor: Colors.black,
                                      labelColor: Colors.black,
                                      prefixIconColor: Colors.black,
                                      textInputFormat: "[0-9]",
                                      onTap: (){},
                                      onChanged: (value){},
                                      control: mortalityController,
                                      type: TextInputType.number,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Mortality Count Cant be Empty';
                                        }
                                      },
                                      label: 'Mortality Count',
                                      prefix: MyFlutterIcon1.glassEel,
                                      onSubmit: (value){
                                        mortalityController.text=value;
                                      }
                                  ),
                                  if(cubit.dailyModel!.dailyMortality!>0&&cubit.dailyModel!.dailyMortality!=null)
                                  SizedBox(
                                    height: 20,
                                  ),
                                  if(cubit.dailyModel!.dailyFeed!>0&&cubit.dailyModel!.feedType!=null)
                                  defaultFormText(
                                      textInputFormat: "[0-9.]",
                                      borderColor: Colors.black,
                                      labelColor: Colors.black,
                                      prefixIconColor: Colors.black,
                                      control: feedWeightController,
                                      type: TextInputType.number,
                                      validator:  (value) {
                                        if (value.isEmpty) {
                                          return 'Feed Weight Cant be Empty';
                                        }
                                      },
                                      label: 'Feed Weight(Kg)',
                                      prefix: MyFlutterIcon1.glassEel,
                                    onTap: (){},
                                    onChanged: (value){},
                                    onSubmit: (value){
                                      feedWeightController.text=value;
                                    },
                                  ),
                                  if(cubit.dailyModel!.dailyFeed!>0&&cubit.dailyModel!.feedType!=null)
                                  SizedBox(
                                    height: 20,
                                  ),
                                  if(cubit.dailyModel!.dailyFeed!>0&&cubit.dailyModel!.feedType!=null)
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blueGrey[300],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20)
                                      )
                                    ),
                                    child: IgnorePointer(
                                      ignoring: true,
                                      child: myDropDownMenu(
                                        myDropDownValue: feedName,
                                          label: 'Select Feed Type',
                                          borderColor: Colors.black,
                                          labelColor: Colors.black,
                                          listName: FishFarmCubit.get(context).feedIdList,
                                          // objectOFClass: objectOfAllTanksName,
                                          myDropDownItems: FishFarmCubit.get(context).feedIdList.map(( feed )
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
                                    ),
                                  ),
                                  if(cubit.dailyModel!.dailyFeed!>=0&&cubit.dailyModel!.feedType!=null)
                                  SizedBox(
                                    height: 10,
                                  ),
                                  MaterialButton(
                                    onPressed: ()async{
                                    if(formKey.currentState!.validate()){
                                      newDailyMortality=(int.parse(mortalityController.text)- cubit.dailyModel!.dailyMortality!)+cubit.dailyModel!.dailyMortality!;
                                      newMonthlyMortality=(int.parse(mortalityController.text)- cubit.dailyModel!.dailyMortality!)+cubit.monthlyModel!.totalMortality!;
                                      newTotalMortality=(int.parse(mortalityController.text)- cubit.dailyModel!.dailyMortality!)+cubit.tankModel!.totalMortality!;
                                      newDailyFeedWeight=(double.parse(feedWeightController.text)- cubit.dailyModel!.dailyFeed!)+cubit.dailyModel!.dailyFeed!;
                                      newMonthlyFeedWeight=(double.parse(feedWeightController.text)- cubit.dailyModel!.dailyFeed!)+cubit.monthlyModel!.totalFeed!;
                                      newTotalFeedWeight=(double.parse(feedWeightController.text)- cubit.dailyModel!.dailyFeed!)+cubit.tankModel!.totalFeed!;
                                      if(cubit.dailyModel!.dailyMortality!>0&&cubit.dailyModel!.dailyMortality!=null)
                                      cubit.editMortalityTankData(
                                          tankName: tankName!, day: dateController.text, month: selectedMonth!,
                                        dailyRemainingPsc: cubit.dailyModel!.remainingPsc!-(int.parse(mortalityController.text)- cubit.dailyModel!.dailyMortality!),
                                        dailyMortalityCount: newDailyMortality!, monthlyMortalityCount: newMonthlyMortality!,
                                        monthlyRemainingPsc: cubit.monthlyModel!.pcsRemaining!-(int.parse(mortalityController.text)- cubit.dailyModel!.dailyMortality!),
                                        totalRemainingPsc: cubit.tankModel!.remaining!-(int.parse(mortalityController.text)- cubit.dailyModel!.dailyMortality!),
                                        totalMortalityCount: newTotalMortality!,
                                      );
                                      if(cubit.dailyModel!.dailyFeed!>0&&cubit.dailyModel!.feedType!=null)
                                      cubit.editFeedTankData(
                                          tankName: tankName!, day: dateController.text, month: selectedMonth!,
                                          dailyFeedWeight:  newDailyFeedWeight!,feedType:cubit.dailyModel!.feedType!,
                                          monthlyFeedWeight: newMonthlyFeedWeight!,totalFeedWeight: newTotalFeedWeight!,
                                        remainingFeed:cubit.feedTypeModel!.remainingFeed!-(double.parse(feedWeightController.text)- cubit.dailyModel!.dailyFeed!),
                                      );
                                    }
                                   navigateAndFinish(context, Add_Home_Screen());
                                  },child:Text('Edit',
                                    style: TextStyle(fontSize: 20,
                                        fontWeight:FontWeight.bold,color: Colors.white ),),
                                    color:Colors.black , ),
                                ],
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
