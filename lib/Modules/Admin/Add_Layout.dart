import 'package:fish_farm/Shared/AppCubit/Cubit.dart';
import 'package:fish_farm/Shared/Componets/components.dart';
import 'package:fish_farm/Shared/Style/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Add_Feed.dart';
import 'Add_Mortality.dart';
import 'Create_Tank.dart';
import 'Create_Feed.dart';
import 'Delete_Tank.dart';
import 'EditDaily.dart';

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
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              defaultButton(buttonName: 'CreateTank', onTap: (){
                 navigateTo(context, widget: CreateTank_Screen());
              }),
              SizedBox(
                height: 30,
              ),
              defaultButton(buttonName: 'AddMortality', onTap: (){
                FishFarmCubit.get(context).getAllTankData();
                FishFarmCubit.get(context).dailyModel=null;
                FishFarmCubit.get(context).monthlyModel=null;
                navigateTo(context, widget: AddMortality_Screen());
              }),
              SizedBox(
                height: 30,
              ),
              defaultButton(buttonName: 'CreateFeed', onTap: (){
                navigateTo(context, widget: CreateFeed_Screen());
              }),
              SizedBox(
                height: 30,
              ),
              defaultButton(buttonName: 'AddFeed', onTap: (){
                FishFarmCubit.get(context).getAllTankData();
                FishFarmCubit.get(context).getAllFeedTypesData();
                FishFarmCubit.get(context).dailyModel=null;
                FishFarmCubit.get(context).monthlyModel=null;
                navigateTo(context, widget: AddFeed_Screen());
              }),
              SizedBox(
                height: 30,
              ),
              defaultButton(buttonName: 'DeleteTank', onTap: (){
                FishFarmCubit.get(context).getAllTankData();
                // FishFarmCubit.get(context).getAllFeedTypesData();
                navigateTo(context, widget: DeleteTank_Screen());
              }),
              SizedBox(
                height: 30,
              ),
              defaultButton(buttonName: 'EditDaily', onTap: (){
                FishFarmCubit.get(context).getAllTankData();
                FishFarmCubit.get(context).dailyModel=null;
                // FishFarmCubit.get(context).getAllFeedTypesData();
                navigateTo(context, widget: EditDaily_Screen());

              }),
            ],
          ),
        ),
      ),
    );
  }
}
