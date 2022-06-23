import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fish_farm/Modules/Login&Register/login/fishFarm_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Layout/home_screen.dart';
import '../../../Shared/Componets/components.dart';
import '../../../Shared/FishFarmRegisterCubit/cubit.dart';
import '../../../Shared/FishFarmRegisterCubit/state.dart';
import '../../../Shared/Style/style.dart';



class FishFarmRegisterScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var emailControl=TextEditingController();
  var phoneControl=TextEditingController();
  var nameControl=TextEditingController();
  var passwordControl=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> FishFarmRegisterCubit(FishFarmRegisterInitialState),
      child: BlocConsumer<FishFarmRegisterCubit,FishFarmRegisterStates>(
        listener: (context,state)
        {
          if(state is FishFarmCreateUserSuccessState)
          {
            showToast(text: 'Register Has been Completed', state: ToastState.Success);
          navigateAndFinish(context, FishFarmLoginScreen());
          }
         else if(state is FishFarmCreateUserErrorState)
          {
            showToast(text: state.error, state: ToastState.Error);
          }
        },
        builder: (context,state){
          return Scaffold(
            backgroundColor: defaultColor,
              appBar: AppBar(
                backgroundColor:defaultColor,
              ),
              body:  SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 500, height: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/image/logo.png'),
                              ),
                            ),
                          ),
                          Text('Register now communicate with Eels World ',
                            style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          defaultFormText(
                              textInputFormat:"[a-zA-Z0-9]",
                              control: nameControl,
                              onTap: (){},
                              onChanged: (value){print(value);},
                              onSubmit: (){},
                              type: TextInputType.name,
                              validator: (value)
                              {
                                if(value.isEmpty)
                                  return 'Name Can not be Empty';
                                else
                                  return null;
                              },
                              label: 'Name',
                              prefix: Icons.person),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormText(
                              textInputFormat:"[a-zA-Z0-9,@ .]",
                              control: emailControl,
                              onTap: (){},
                              onChanged: (value){print(value);},
                              onSubmit: (){},
                              type: TextInputType.emailAddress,
                              validator: (value)
                              {
                                if(value.isEmpty)
                                  return 'Email Can not be Empty';
                                else
                                  return null;
                              },
                              label: 'Email',
                              prefix: Icons.email),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormText(
                              textInputFormat:"[a-zA-Z0-9]",
                              control: passwordControl,
                              type: TextInputType.visiblePassword,
                              onTap: (){},
                              onChanged: (value){print(value);},
                              onSubmit: (value) {},
                              validator: (value)
                              {
                                if(value.isEmpty)
                                  return 'Password is to Short';
                                else
                                  return null;
                              },
                              isPassword: FishFarmRegisterCubit.get(context).isPassword,
                              label: 'Password',
                              prefix: Icons.lock,
                              suffix: FishFarmRegisterCubit.get(context).suffix,
                              suffixClicked: (){
                                FishFarmRegisterCubit.get(context).changePasswordVisibility();
                              }
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormText(
                              textInputFormat:"[0-9]",
                              control: phoneControl,
                              onTap: (){},
                              onChanged: (value){print(value);},
                              onSubmit: (){},
                              type: TextInputType.phone,
                              validator: (value)
                              {
                                if(value.isEmpty)
                                  return 'Phone Can not be Empty';
                                else
                                  return null;
                              },
                              label: 'phone',
                              prefix: Icons.phone),
                          SizedBox(
                            height: 15,
                          ),
                          ConditionalBuilder(
                            condition: state is! FishFarmRegisterLoadingState,
                            builder:(context)=>Center(
                              child: defaultButton(
                                onTap: (){
                                  if(formKey.currentState!.validate())
                                  {
                                    FishFarmRegisterCubit.get(context).userRegister(
                                        email: emailControl.text,
                                        password: passwordControl.text,
                                        phone: phoneControl.text,
                                        name: nameControl.text);
                                  }
                                },
                                  buttonName: 'Sign Up'
                              ),
                            ),
                            fallback:(context)=>
                                Center(child: CircularProgressIndicator()) ,

                          ),

                        ]),
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}
