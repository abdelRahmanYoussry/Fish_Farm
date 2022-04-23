import 'package:fish_farm/Shared/AppCubit/Cubit.dart';
import 'package:fish_farm/Shared/AppCubit/States.dart';
import 'package:fish_farm/Shared/Style/Icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../Shared/Componets/components.dart';
import '../../Shared/Style/style.dart';

class AddMortality_Screen extends StatelessWidget {
  var tankNameController = TextEditingController();
  var mortalityPscController = TextEditingController();
  var dateController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FishFarmCubit, FishFarmStates>(
      listener: (context, state) {
        // TODO: implement listener
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


                    defaultFormText(
                      textInputFormat:"[a-zA-Z0-9]",
                      onTap: (){
                      },
                      onChanged: (value){},
                        control: tankNameController,
                        type: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Name Cant be Empty';
                          }
                        },
                        label: 'Tank Num',
                        prefix: Icons.circle),
                    SizedBox(
                      height: 10,
                    ),
                    defaultFormText(
                        textInputFormat: "[0-9]",
                        onTap: (){},
                        onChanged: (value){},
                        control: mortalityPscController,
                        type: TextInputType.text,
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
                            await FishFarmCubit.get(context).getSelectedTankData(tankName: tankNameController.text);
                             FishFarmCubit.get(context).addMortality(
                               totalMortality:FishFarmCubit.get(context).tankTotalMortality!+int.parse(mortalityPscController.text),
                               remaining: FishFarmCubit.get(context).tankTotalPscCount!-(FishFarmCubit.get(context).tankTotalMortality!+int.parse(mortalityPscController.text)),
                               mortalityCount: int.parse(mortalityPscController.text,),
                                 tankName: tankNameController.text,
                                 datetime: DateTime.now().toString(),
                                 mortalityDatetime: dateController.text,
                             );
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
