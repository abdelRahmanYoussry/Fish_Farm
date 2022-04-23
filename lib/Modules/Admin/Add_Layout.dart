import 'package:fish_farm/Shared/AppCubit/Cubit.dart';
import 'package:fish_farm/Shared/Componets/components.dart';
import 'package:fish_farm/Shared/Style/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Add_Mortality.dart';
import 'Add_Tank.dart';

class Add_Home_Screen extends StatelessWidget {
  const Add_Home_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: defaultAppBar(context: context,
        title: 'Add',
          backGroundColor: defaultColor,
            elevation: 0.0
        ),
      ) ,
      backgroundColor: defaultColor,
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            defaultButton(buttonName: 'AddTank', onTap: (){
               navigateTo(context, widget: AddTank_Screen());
            }),
            SizedBox(
              height: 30,
            ),
            defaultButton(buttonName: 'AddMortality', onTap: (){
              navigateTo(context, widget: AddMortality_Screen());
            }),
          ],
        ),
      ),
    );
  }
}
