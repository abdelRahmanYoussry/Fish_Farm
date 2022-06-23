
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_farm/Shared/FishFarmLoginCubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Models/ProfileModel.dart';


class FishFarmLoginCubit extends Cubit<FishFarmLoginStates>{
  FishFarmLoginCubit(initialState) : super(FishFarmLoginInitialState());
  static FishFarmLoginCubit get(context)=>BlocProvider.of(context);

FishFarmUserModel? model;
  void userLogin({
  required String email,
  required String password
}){
    emit(FishFarmLoginLoadingState());
 FirebaseAuth.instance.signInWithEmailAndPassword(
     email: email,
     password: password).then((value)
 {

   print(value.user!.uid);
   emit(FishFarmLoginSuccessState(value.user!.uid));
 }
 ).catchError((error)
 {
   emit(FishFarmLoginErrorState(error.toString()));

 });
  }


IconData suffix=Icons.visibility_outlined;
 bool isPassword=true;
  void changePasswordVisibility()
  {
   isPassword=!isPassword;
   suffix=isPassword ? Icons.visibility_outlined:Icons.visibility_off;
   emit(FishFarmLoginPasswordVisibility());
  }
}