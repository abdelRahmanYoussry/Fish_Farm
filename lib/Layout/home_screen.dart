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
  // var formKey=GlobalKey<FormState>();
  // var nameController=TextEditingController();
  // var phoneController=TextEditingController();
  // var emailController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FishFarmCubit, FishFarmStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var profileModel = FishFarmCubit.get(context).userModel;
        var editProfileImage=FishFarmCubit.get(context).profileImageFile;
        // nameController.text=profileModel!.name!;
        // phoneController.text=profileModel.phone!;
        // emailController.text=profileModel.email!;
        // nameController.text=profileModel!.name!;
        // phoneController.text=profileModel.phone!;
        return ConditionalBuilder(
          condition: profileModel != null,
          fallback: (context) =>
              CircularProgressIndicator(
                color: defaultColor,
              ),
          builder: (context) =>
              Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    actions: [
                      InkWell(
                        child: profileCircleAvatar(
                            imageProvider:NetworkImage('${profileModel!.image}'),
                            radius: 30,
                            backgroundColor: Colors.yellowAccent,
                        ),
                        onTap: () {
                          // nameController.text=profileModel.name!;
                          // phoneController.text=profileModel.phone!;
                          // emailController.text=profileModel.email!;
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
                                  fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),)),
                                backgroundColor: Colors.transparent,
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      profileCircleAvatar(
                                          radius: 40,
                                          imageProvider:
                                          editProfileImage== null? NetworkImage(
                                              '${profileModel.image}'):FileImage(editProfileImage )as ImageProvider  ,
                                          backgroundColor: Colors.yellowAccent,

                                          ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text('${profileModel.name}',
                                          style:TextStyle(
                                            color: Colors.white,
                                              fontSize: 24,fontWeight: FontWeight.bold
                                          ) ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text('${profileModel.phone}',
                                          style:TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,fontWeight: FontWeight.bold
                                          ) ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text('${profileModel.email}',
                                          style:TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,fontWeight: FontWeight.bold
                                          ) ),
                                      SizedBox(
                                        height: 20,
                                      ),

                                      circleDefaultButton(
                                        textColor: Colors.black,
                                          buttonBackGroundColor:Colors.white ,
                                          radius: 20,
                                          width: 160,
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
                                          textColor: Colors.black,
                                          buttonBackGroundColor:Colors.white ,
                                          radius: 20,
                                          width: 160,
                                          backGroundColor: Colors.white,
                                          onTap: () {
                                            FishFarmCubit.get(context).loginOut(context);  },
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
                  body: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/image/EelTank.png'),
                            fit: BoxFit.cover
                        )
                    ),
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 20
                              ,
                            ),
                            Container(
                              width: 500, height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/image/logo.png')
                                ),
                              ),
                            ),
                            Text('Eel Farm',
                              style: TextStyle(color: Colors.yellowAccent,
                                  fontSize: 20),),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30
                                  , left: 10),
                              child: Row(
                                children: [
                                  mainWidgetHomeScreen(
                                      imageName: 'assets/image/report.svg',
                                      title: 'Reports',
                                      onTap: (){
                                        navigateTo(context, widget: ReportScreen());
                                      }),
                                  SizedBox(
                                      width: 70
                                  ),
                                mainWidgetHomeScreen(
                                    imageName: 'assets/image/airCreaft.svg',
                                    title: 'plane View',
                                    onTap: (){
                                  navigateTo(context, widget: PlaneViewScreen());
                                })
                              //     InkWell(
                              //   onTap: (){
                              //   },
                              //   child: Container(
                              //     width: 160,
                              //     height: 160,
                              //     decoration: BoxDecoration(
                              //       gradient: LinearGradient(
                              //         colors: [
                              //           Colors.white.withOpacity(0.1),
                              //           Colors.white.withOpacity(0.1)
                              //           // Colors.blue.shade200
                              //         ],),
                              //       borderRadius: BorderRadius.only(
                              //         topLeft: Radius.circular(10),
                              //         bottomLeft: Radius.circular(10),
                              //         bottomRight: Radius.circular(10),
                              //         topRight: Radius.circular(10),
                              //       ),
                              //       boxShadow: [
                              //         BoxShadow(
                              //             offset: Offset(5, 5),
                              //             blurRadius: 50,
                              //             color: Colors.white.withOpacity(0.0))
                              //       ],
                              //     ),
                              //     child: Padding(
                              //       padding: const EdgeInsets.all(0.0),
                              //       child: Column(
                              //         mainAxisSize: MainAxisSize.max,
                              //         children: [
                              //           textField(text: 'Plane View', fontSize: 18,color: Colors.white),
                              //          Icon(Icons.airplanemode_on,color: Colors.white,size: 130,)
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // )
                                  // newReportContainer(
                                  //     title: 'Plane View',
                                  //     subTitle: 'All Tanks Quantity , Weight and more... ',
                                  //     myIcon: Icon(Icons.airplanemode_active),
                                  //     onTap: () {
                                  //       navigateTo(
                                  //           context, widget: PlaneViewScreen());
                                  //     })
                                ],
                              ),
                            ),
                            SizedBox(
                                width: double.infinity,
                                height: 30
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30
                                  , left: 10),
                              child: Row(
                                children: [
                                  newReportContainer(
                                      onTap: () {},
                                      context: context,
                                      myIcon: Icon(Icons.compare_arrows),
                                      subTitle: 'Photos , Videos and more... ',
                                      title: 'Project Life Time'
                                  ),
                                  SizedBox(
                                      width: 30
                                  ),
                                  newReportContainer(
                                      title: 'contact us',
                                      subTitle: 'Your Feedback Is very Important to us ',
                                      myIcon: Icon(Icons.contact_mail),
                                      onTap: () {})
                                ],


                              ),
                            ),
                            SizedBox(
                                width: double.infinity,
                                height: 30
                            ),
                            if(profileModel.isAdmin==true)
                            newReportContainer(
                                onTap: () {
                                  navigateTo(context, widget: Add_Home_Screen());
                                },
                                context: context,
                                myIcon: Icon(Icons.add),
                                subTitle: 'Add Tank,Mortality, Feed and More',
                                title: 'Add(only Admins)'
                            ),
                          ],
                        ),
                      ],
                    ),
                  )

              ),
        );
      },
    );
  }
}


