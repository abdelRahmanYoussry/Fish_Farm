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
    var profileModel = FishFarmCubit.get(context).userModel;
    nameController.text=profileModel!.name!;
    phoneController.text=profileModel.phone!;
    emailController.text=profileModel.email!;
    bool isAdmin=profileModel.isAdmin!;
    var mediaQueryData = MediaQuery.of(context);
    return BlocConsumer<FishFarmCubit, FishFarmStates>(
      listener: (context, state) {
         if(state is FishFarmUpdateUserProfileImageSuccessState)
        showToast(text: 'Your Profile Image Has Been Changed', state: ToastState.Success);
      },
      builder: (context, state) {
        var editProfileImage=FishFarmCubit.get(context).profileImageFile;

        return Scaffold(
          // extendBody: true,
            backgroundColor: defaultColor.withOpacity(0.5),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: defaultAppBar(
               navigateAndFinishWidget: HomeScreen(),
                  elevation: 0.0,
                  centerTitle: true,
                   backGroundColor: Colors.transparent,
                  context: context,
                  title: 'Edit profile'),
            ),
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0,right: 20,left: 20),
                  child: Column(
                    children: [
                      if(state is GetUserDataLoadingState )
                        SizedBox(
                          height: 10,
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
                          CircleAvatar(
                              backgroundColor: Colors.yellowAccent,
                              radius: 18,
                              child: IconButton(
                                color: Colors.black,
                                onPressed: (){
                                  FishFarmCubit.get(context).pickAProfileImage();
                                },
                                icon:Icon(Icons.photo_camera),
                                iconSize: 22,
                              )

                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if(editProfileImage !=null&&state is FishFarmEditUserProfileImageSuccessState)
                      Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              FishFarmCubit.get(context).uploadProfileImage(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  isAdmin: isAdmin
                              );
                            await FishFarmCubit.get(context).getUserData();
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height/24,
                              width: MediaQuery.of(context).size.width/2.2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.image,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text('Change Profile Image ',
                                    style: TextStyle(color: Colors.black,fontSize: 14),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.yellowAccent[400],
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
                          textInputFormat:"[a-zA-Z0-9, ]",
                          onSubmit: (value){
                            FishFarmCubit.get(context).updateUser(
                              email: emailController.text,
                              name: nameController.text,
                              phone: phoneController.text,
                                isAdmin: isAdmin
                            );
                          },
                          onChanged: (value){

                          },
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
                          onSubmit: (value){
                            FishFarmCubit.get(context).updateUser(
                              email: emailController.text,
                              name: nameController.text,
                              phone: phoneController.text,
                                isAdmin: isAdmin
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
                                isAdmin: isAdmin
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
            )
        );
      },
    );
  }
}
