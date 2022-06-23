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
  emit(FishFarmRegisterErrorState(error.toString()));
  print(error.toString()+' Error2222222222222222');
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
        image: 'https://image.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg',
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