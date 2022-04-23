import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_farm/Shared/FishFarmRegisterCubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Models/ProfileModel.dart';


class FishFarmRegisterCubit extends Cubit<FishFarmRegisterStates>{
  FishFarmRegisterCubit(initialState) : super(FishFarmRegisterInitialState());
  static FishFarmRegisterCubit get(context)=>BlocProvider.of(context);

  void userRegister({
  required String email,
  required String password,
  required String name,
  required String phone
}){
    emit(FishFarmRegisterLoadingState());
FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password
).then((value) {
  emit(FishFarmRegisterSuccessState());
  print(value.user!.email);
  print(value.user!.uid);
  userCreate(
      email: email,
      name: name,
      phone: phone,
      uid: value.user!.uid);
}
).catchError((error){
  print(error.toString());
  emit(FishFarmRegisterErrorState(error.toString()));
});

  }

  void userCreate({
     String ?email,
    required String name,
    required String phone,
    String ?uid,
  })
  {
    FishFarmUserModel model=FishFarmUserModel(
        name: name,
        email: email,
        phone: phone,
        uid: uid,
        image: 'data:image/jpeg;base64,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',
        isAdmin: false);
    FirebaseFirestore.instance
    .collection('users')
    .doc(uid)
    .set(model.toMap())
    .then((value) {
      emit(FishFarmCreateUserSuccessState());
})
    .catchError((error){
      print(error.toString());
      emit(FishFarmCreateUserErrorState(error.toString()));
});
}
IconData suffix=Icons.visibility_outlined;
 bool isPassword=false;
  void changePasswordVisibility()
  {
   isPassword=!isPassword;
   suffix=isPassword ? Icons.visibility_outlined:Icons.visibility_off;
   emit(FishFarmRegisterPasswordVisibility());
  }
}