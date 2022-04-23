import 'package:fish_farm/Shared/AppCubit/Cubit.dart';
import 'package:fish_farm/Shared/AppCubit/States.dart';

import 'package:fish_farm/Shared/Componets/components.dart';
import 'package:fish_farm/Shared/Componets/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  BlocConsumer<FishFarmCubit,FishFarmStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=FishFarmCubit.get(context);
        return Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            centerTitle: true,
           elevation: 0.0,
            backgroundColor: Colors.transparent,
            // title: Text('Reports ',
            //   style:TextStyle(fontSize: 30) ,),
          ),
          body: reportsScreens[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white.withOpacity(0.5),
            items:bottomNavBarList,
            currentIndex:currentIndex,
            onTap: (index){
             cubit.changeNavBar(index);
            },
          ),
        );
      },
    );
  }
}

