import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Layout/home_screen.dart';
import '../../../Shared/AppCubit/Cubit.dart';
import '../../../Shared/Componets/components.dart';
import '../../../Shared/Componets/constans.dart';
import '../../../Shared/FishFarmLoginCubit/cubit.dart';
import '../../../Shared/FishFarmLoginCubit/state.dart';
import '../../../Shared/Network/local/cash_helper.dart';
import '../../../Shared/Style/style.dart';
import '../Register/FishFarmRegisterScreen.dart';



class FishFarmLogin extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var emailControl=TextEditingController();
  var passwordControl=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>FishFarmLoginCubit(FishFarmLoginInitialState),
      child: BlocConsumer<FishFarmLoginCubit,FishFarmLoginStates>(
        listener: (context,state){
          if (state is FishFarmLoginErrorState)
          showToast(text: state.error.toString(), state: ToastState.Error);
          if (state is FishFarmLoginSuccessState)
          {
            showToast(text: state.toString(), state: ToastState.Success);
            CashHelper.saveData(
                key: 'uid',
                value:state.uid
            ).then((value) {
              print(state.uid+' this is uid');
              uid=state.uid;
              // FishFarmCubit.get(context).getUserData();
              navigateAndFinish(context, HomeScreen());
            });
          }
        },
        builder: (context,state){
          return Scaffold(
            backgroundColor: defaultColor,
              appBar: AppBar(
                backgroundColor: defaultColor,
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Login',
                              style: Theme.of(context).textTheme.headline2!.
                              copyWith(color: Colors.white
                              ),
                            ),
                            Text('Login now to Communicate with Eels World',
                              style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            defaultFormText(
                                textInputFormat:"[a-zA-Z0-9-@.]",
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
                                onSubmit: (value)
                                {
                                  if(formKey.currentState!.validate())
                                  {
                                    // FishFarmLoginCubit.get(context).userLogin(
                                    //     email: emailControl.text,
                                    //     password: passwordControl.text);
                                  }

                                },
                                validator: (value)
                                {
                                  if(value.isEmpty)
                                    return 'Password is to Short';
                                  else
                                    return null;
                                },
                                isPassword: FishFarmLoginCubit.get(context).isPassword,
                                label: 'Password',
                                prefix: Icons.lock,
                                suffix: FishFarmLoginCubit.get(context).suffix,
                                suffixClicked: (){
                                  FishFarmLoginCubit.get(context).changePasswordVisibility();
                                }
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            ConditionalBuilder(
                              condition: state is! FishFarmLoginLoadingState,
                              builder:(context)=>Center(
                                child: defaultButton(
                                  onTap: (){
                                    if(formKey.currentState!.validate()) {
                                      FishFarmLoginCubit.get(context).userLogin(
                                          email: emailControl.text,
                                          password: passwordControl.text);

                                      // if(uid!=FishFarmCubit.get(context).userModel!.uid){
                                      //   FishFarmLoginCubit.get(context).userLogin(
                                      //       email: emailControl.text,
                                      //       password: passwordControl.text);
                                      //
                                      // }
                                      // else
                                      //   // FishFarmCubit.get(context).getUserData();
                                      // // FishFarmCubit.get(context).getPost();

                                    }
                                  }, buttonName: 'Login',),
                              ),
                              fallback:(context)=>Center(child: CircularProgressIndicator()) ,

                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't Have an Account?",style: TextStyle(fontSize:15 ,
                                    color: Colors.white),),
                                defaultTextButton(
                                  textColor: Colors.yellowAccent,
                                    onTap: (){navigateTo(context,  widget: FishFarmRegisterScreen());},
                                    text: 'Register')
                              ],),
                          ]),
                    ),
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}
