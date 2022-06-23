import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fish_farm/Layout/reports_screen.dart';
import 'package:fish_farm/Shared/AppCubit/Cubit.dart';
import 'package:fish_farm/Shared/AppCubit/States.dart';
import 'package:fish_farm/Shared/Style/Icons.dart';
import 'package:fish_farm/Shared/Componets/components.dart';
import 'package:fish_farm/Shared/Style/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Modules/Admin/Add_Layout.dart';
import '../Modules/Plane_view/planeView.dart';
import '../Modules/Settings/Settings_Screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    return BlocConsumer<FishFarmCubit, FishFarmStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        // FishFarmCubit.get(context).getUserData();
        var profileModel = FishFarmCubit.get(context).userModel;
        var editProfileImage=FishFarmCubit.get(context).profileImageFile;
        // FishFarmCubit.get(context).getUserData();
        return ConditionalBuilder(
          condition: profileModel != null,
          fallback: (context) =>
              CircularProgressIndicator(
                color: defaultColor,
              ),
          builder: (context) =>
              WillPopScope(
                onWillPop:()=> _onWillPop(context),
                child: Scaffold(
                  backgroundColor: Colors.cyan,
                    extendBodyBehindAppBar: true,
                    appBar: AppBar(
                      actions: [
                        InkWell(
                          child: profileCircleAvatar(
                              imageProvider:NetworkImage('${profileModel!.image}'),
                              radius: 25,
                              backgroundColor: Colors.yellowAccent,
                          ),
                          onTap: () {
                            showDialog(
                              useSafeArea:true ,
                                context: context,
                                builder: (context)=>SimpleDialog(
                                  elevation: 0.8,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(20),
                                        right: Radius.circular(20),
                                      )
                                  ),
                                  title: Center(child: Text('Profile Info',style: TextStyle(
                                    fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    color: Colors.white
                                  ),)),
                                  backgroundColor: Colors.transparent,
                                  children: [
                                    Column(
                                      children: [
                                        profileCircleAvatar(
                                            radius: 40,
                                            imageProvider:
                                            editProfileImage== null? NetworkImage(
                                                '${profileModel.image}'):FileImage(editProfileImage )as ImageProvider  ,
                                            backgroundColor: Colors.yellowAccent,
                                            ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text('${profileModel.name}',
                                            style:TextStyle(
                                              color: Colors.white,
                                                fontSize: 16,fontWeight: FontWeight.bold
                                            ) ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text('${profileModel.phone}',
                                            style:TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,fontWeight: FontWeight.bold
                                            ) ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text('${profileModel.email}',
                                            style:TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,fontWeight: FontWeight.bold
                                            ) ),
                                        SizedBox(
                                          height: 10,
                                        ),

                                        circleDefaultButton(
                                          textColor: Colors.white,
                                            buttonBackGroundColor:defaultColor ,
                                            radius: 30,
                                            width: 100,
                                            backGroundColor: Colors.white,
                                            onTap: () {
                                             Navigator.pop(context);
                                              navigateTo(context, widget: EditProfile_Screen()) ;

                                              },
                                            text: 'Edit'
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        circleDefaultButton(
                                            textColor: Colors.white,
                                            buttonBackGroundColor:Colors.red ,
                                            radius: 20,
                                            width: 100,
                                            backGroundColor: Colors.white,
                                            onTap: () {
                                              FishFarmCubit.get(context).loginOut(context);
                                              },
                                            text: 'Log Out'
                                        ),

                                      ],
                                    ),
                                  ],
                                ));
                          },
                        )
                      ],
                      elevation: 0.00,
                      backgroundColor: Colors.transparent,
                    ),
                    body: ListView(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: mediaQueryData.size.width/1.7, height: mediaQueryData.size.height/6,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/image/logo.png')
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20
                                  , left: 20,right: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: mainWidgetHomeScreen(
                                        imageName: 'assets/image/report.svg',
                                        title: 'Reports',
                                        onTap: (){
                                          navigateTo(context, widget: ReportScreen());
                                          FishFarmCubit.get(context).getAllTankData();
                                          FishFarmCubit.get(context).getAllFeedTypesData();
                                        }),
                                  ),
                                  SizedBox(
                                      width: 70
                                  ),
                                Expanded(
                                  child: mainWidgetHomeScreen(
                                      imageName: 'assets/image/airCreaft.svg',
                                      title: 'plane View',
                                      onTap: (){
                                    navigateTo(context, widget: PlaneViewScreen());
                                  }),
                                )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20
                                  , left: 20,right: 20,bottom: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: newReportContainer(
                                        onTap: () {
                                          FishFarmCubit.get(context).getUserAdmin();
                                        },
                                        context: context,
                                        myIcon: Icon(Icons.compare_arrows),
                                        subTitle: 'Photos , Videos and more... ',
                                        title: 'About Us'
                                    ),
                                  ),
                                  SizedBox(
                                      width: 70
                                  ),
                                  Expanded(
                                    child: newReportContainer(
                                        title: 'contact us',
                                        subTitle: 'Your Feedback Is very Important to us ',
                                        myIcon: Icon(Icons.contact_mail),
                                        onTap: () {}),
                                  )
                                ],


                              ),
                            ),
                            if(profileModel.isAdmin==true)
                            Flexible(
                              fit: FlexFit.loose,
                              child: newReportContainer(
                                  onTap: () {
                                    navigateTo(context, widget: Add_Home_Screen());
                                  },
                                  context: context,
                                  myIcon: Icon(Icons.add),
                                  subTitle: 'Add Tank,Feed,Mortality,and More',
                                  title: 'Add(only Admins)'
                              ),
                            ),
                          ],
                        ),
                      ],
                    )

                ),
              ),
        );
      },
    );
  }
  Future<bool> _onWillPop(context) async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

}


