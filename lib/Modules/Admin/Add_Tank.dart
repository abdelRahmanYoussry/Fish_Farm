import 'package:fish_farm/Shared/AppCubit/Cubit.dart';
import 'package:fish_farm/Shared/AppCubit/States.dart';
import 'package:fish_farm/Shared/Style/Icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Shared/Componets/components.dart';
import '../../Shared/Style/style.dart';

class AddTank_Screen extends StatelessWidget {
  var tankNameController = TextEditingController();
  var tankWeightController = TextEditingController();
  var tankPscController = TextEditingController();
  var tankAvgController = TextEditingController();
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
                title: 'AddTank', backGroundColor: defaultColor, elevation: 0.0
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
                      onTap: (){},
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
                      textInputFormat: "[0-9.]",
                        onTap: (){},
                        onChanged: (value){},
                        control: tankWeightController,
                        type: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Weight Cant be Empty';
                          }
                        },
                        label: 'Tank wight',
                        prefix: MyFlutterIcon1.weight),
                    SizedBox(
                      height: 10,
                    ),
                    defaultFormText(
                        textInputFormat: "[0-9]",
                        onTap: (){},
                        onChanged: (value){},
                        control: tankPscController,
                        type: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Psc Count Cant be Empty';
                          }
                        },
                        label: 'Tank Psc Count',
                        prefix: MyFlutterIcon1.glassEel),
                    SizedBox(
                      height: 10,
                    ),
                    defaultFormText(
                        textInputFormat: "[0-9.]",
                        onTap: (){},
                        onChanged: (value){},
                        control: tankAvgController,
                        type: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Avg of Psc Cant be Empty';
                          }
                        },
                        label: 'Tank Avg of Psc',
                        prefix: MyFlutterIcon1.weight),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            FishFarmCubit.get(context).createTank(
                                tankName: tankNameController.text,
                                tankTotalCount:int.parse( tankPscController.text),
                                tankTotalWeight: double.parse(tankWeightController.text),
                                tankTotalRemaining: int.parse( tankPscController.text),
                                tankAvgPsc: double.parse( tankAvgController.text));
                            FocusScope.of(context).unfocus();
                          }
                        },
                        buttonName: 'Submit'
                    )
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
