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
          body: reportsScreens[currentIndex],
          bottomNavigationBar:Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
            decoration: BoxDecoration(
            color: Colors.transparent,
            backgroundBlendMode: BlendMode.clear,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),

            ),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
        ),
        height: MediaQuery.of(context).size.height * 0.085,
        child: ClipRRect(
        borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.0),
        topRight: Radius.circular(18.0),
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        child: BottomNavigationBar(
        backgroundColor:Colors.yellow.shade500,
        // Color(0xFFF0B50F),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontSize: 12),
        items:bottomNavBarList,
        currentIndex: currentIndex,
        // selectedIconTheme: IconThemeData(color: Colors.black),
        selectedItemColor: Colors.black,
        onTap: (index){
        cubit.changeNavBar(index);
        },
        ),

            // BottomNavigationBar(
            //   backgroundColor: Colors.yellowAccent,
            //   items:bottomNavBarList,
            //   currentIndex:currentIndex,
            //   onTap: (index){
            //    cubit.changeNavBar(index);
            //   },
            // ),
        )),
          ));
      },
    );
  }
}

