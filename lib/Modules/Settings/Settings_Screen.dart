import 'package:fish_farm/Layout/home_screen.dart';
import 'package:fish_farm/Shared/AppCubit/Cubit.dart';
import 'package:fish_farm/Shared/AppCubit/States.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Shared/Componets/components.dart';
import '../../Shared/Style/style.dart';

class EditProfile_Screen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  var emailController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FishFarmCubit, FishFarmStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var profileModel = FishFarmCubit.get(context).userModel;
        var editProfileImage=FishFarmCubit.get(context).profileImageFile;
        nameController.text=profileModel!.name!;
        phoneController.text=profileModel.phone!;
        emailController.text=profileModel.email!;
        return Scaffold(
          // extendBody: true,
            extendBodyBehindAppBar: true,
            backgroundColor: defaultColor.withOpacity(0.3),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: defaultAppBar(
                navigateToWidget:HomeScreen() ,
                // navigateAndFinishWidget:HomeScreen(),
                  elevation: 0.0,
                  centerTitle: true,
                   backGroundColor: Colors.transparent,
                  context: context,
                  title: 'Edit profile'),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              decoration:BoxDecoration(
                  image: DecorationImage(
                      image:AssetImage('assets/image/farmoutsideblue.png'),
                      fit: BoxFit.fill
                  )
              ),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 80.0,right: 20,left: 20),
                    child: Container(
                      width: double.infinity,
                      // decoration: BoxDecoration(
                      //   image: DecorationImage(
                      //     image:AssetImage('assets/image/farmoutsideblue.png'),
                      //     fit: BoxFit.cover
                      //   )
                      // ),
                      child: Column(
                        children: [
                          if(state is GetUserDataLoadingState )
                            SizedBox(
                              height: 30,
                            ),
                          if(state is GetUserDataLoadingState )
                            LinearProgressIndicator(
                              color: Colors.yellowAccent,
                            ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              profileCircleAvatar(
                                radius: 60,
                                imageProvider:
                                editProfileImage== null? NetworkImage(
                                    '${profileModel.image}'):FileImage(editProfileImage )as ImageProvider  ,
                                backgroundColor: Colors.yellowAccent

                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                    backgroundColor: Colors.yellowAccent,
                                    radius: 18,
                                    child: Center(
                                      child: IconButton(
                                        color: Colors.black,
                                        onPressed: (){
                                          FishFarmCubit.get(context).pickAProfileImage();
                                        },
                                        icon:Icon(Icons.photo_camera),
                                        iconSize: 22,
                                      ),
                                    )

                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          if(editProfileImage !=null&&state is FishFarmEditUserProfileImageSuccessState)
                          Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  FishFarmCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text);
                                },
                                child: Container(
                                  height: 40,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.person,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text('Upload Profile ',
                                            style: TextStyle(color: Colors.white,fontSize: 20),
                                          ),
                                        ],
                                      ),
                                      if(state is UpdateUserDataLoadingState)
                                        SizedBox(
                                          height: 10,
                                        ),
                                      if(state is UpdateUserDataLoadingState)
                                        LinearProgressIndicator(),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey[400],
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          defaultFormText(
                              textInputFormat:"[a-zA-Z0-9]",
                              onSubmit: (){
                                FishFarmCubit.get(context).updateUser(
                                  email: emailController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              },
                              onChanged: (value){},
                              onTap: (){},
                              control: nameController,
                              type: TextInputType.name
                              , validator: (value){
                            if(value.isEmpty)
                              return 'Name Cant be Empty' ;
                            return null;
                          },
                              label: 'Name',
                              prefix: Icons.person),
                          SizedBox(
                            height: 20,
                          ),
                          defaultFormText(
                              textInputFormat:"[0-9]",
                              onSubmit: (){
                                FishFarmCubit.get(context).updateUser(
                                  email: emailController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              },
                              onChanged: (value){},
                              onTap: (){},
                              control: phoneController,
                              type: TextInputType.phone
                              , validator: (value){
                            if(value.isEmpty)
                              return 'Phone Cant be Empty' ;
                            return null;
                          },
                              label: 'Phone',
                              prefix: Icons.phone),
                          SizedBox(
                            height: 20,
                          ),
                          // defaultFormText(
                          //   onSubmit: (){
                          //     FishFarmCubit.get(context).updateUser(
                          //       email: emailController.text,
                          //       name: nameController.text,
                          //       phone: phoneController.text,
                          //     );
                          //   },
                          //     onChanged: (value){},
                          //     onTap: (){},
                          //     control: emailController,
                          //     type: TextInputType.emailAddress
                          //     , validator: (value){
                          //   if(value.isEmpty)
                          //     return 'email Cant be Empty' ;
                          //   return null;
                          // },
                          //     label: 'email',
                          //     prefix: Icons.email),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          circleDefaultButton(
                              buttonBackGroundColor:Colors.blueGrey ,
                              radius: 20,
                              width: 160,
                              backGroundColor: Colors.yellowAccent,
                              onTap: () {
                                if(formKey.currentState!.validate()){
                                  FishFarmCubit.get(context).updateUser(
                                    email: emailController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                  );
                                  FocusScope.of(context).unfocus();
                                }


                              },
                              text: 'Update'
                          )


                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
        );
      },
    );
  }
}
