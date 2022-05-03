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

class CreateFeed_Screen extends StatelessWidget {
  var feedNameController = TextEditingController();
  String ?tankName;
  var feedWeightController = TextEditingController();
  var dateController = TextEditingController();
  var formKey = GlobalKey<FormState>();
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
                title: 'CreateFeed', backGroundColor: defaultColor, elevation: 0.0
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
                    defaultFormText(
                        textInputFormat:"[a-zA-Z0-9 .]",
                        onTap: (){},
                        onChanged: (value){},
                        control: feedNameController,
                        type: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Name Cant be Empty';
                          }
                        },
                        label: 'Feed name and Size',
                        prefix: MyFlutterIcon1.stock),
                    // myDropDownMenu(
                    //     label: 'Select Tank',
                    //     listName: FishFarmCubit.get(context).tanksIdList,
                    //     objectOFClass: objectOfAllTanksName,
                    //     items: FishFarmCubit.get(context).tanksIdList.map(( tank )
                    //     {
                    //       return DropdownMenuItem(
                    //           value: tank,
                    //           child: Row(
                    //             children: [
                    //               Text(tank,
                    //               ),
                    //             ],
                    //           )
                    //       );
                    //     }).toList(),
                    //     validator: (value){
                    //       if (value.isEmpty) {
                    //         return 'Tank Name Cant be Empty';
                    //       }
                    //       else tankName=value;
                    //     },
                    //     onChange: (value){}),
                    SizedBox(
                      height: 20,
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
                    defaultFormText(
                        textInputFormat: "[0-9.]",
                        onTap: (){},
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
                      height: 20,
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
                        onTap: ()   {
                          FishFarmCubit.get(context).createFeed(
                              feedName: feedNameController.text,
                              purchasedFeedWeight: double.parse(feedWeightController.text),
                              remainingFeedWeight: double.parse(feedWeightController.text),
                              purchasedDate: dateController.text);
                          FocusScope.of(context).unfocus();
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
