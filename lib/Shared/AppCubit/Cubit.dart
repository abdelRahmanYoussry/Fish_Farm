import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:fish_farm/Models/MortalityModel.dart';
import 'package:fish_farm/Models/ProfileModel.dart';
import 'package:fish_farm/Modules/Login&Register/login/fishFarm_login.dart';
import 'package:fish_farm/Modules/Reports/Monthly_Report/Monthly_Reports_Layout.dart';
import 'package:fish_farm/Modules/Reports/Daily_Report/dailyRepotrs_view.dart';
import 'package:fish_farm/Modules/Reports/Stock_Report/StockReports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../Models/TankModel.dart';
import '../Componets/components.dart';
import '../Componets/constans.dart';
import '../Network/local/cash_helper.dart';
import 'States.dart';

class FishFarmCubit extends Cubit<FishFarmStates> {
  FishFarmCubit(initialState) : super(initialState);

  static FishFarmCubit get(context) => BlocProvider.of(context);
  bool isEnable = false;

  void changeNavBar(int index) {
    currentIndex = index;
    if (currentIndex == 0) {
      emit(ChangeNavBar0());
    }
    else if (currentIndex == 1) {
      emit(ChangeNavBar1());
    }
    else
      emit(ChangeNavBar2());
  }

  FishFarmUserModel?userModel;
  TankModel?tankModel;
  MortalityModel? mortalityModel;

  void getUserData() {
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      userModel = FishFarmUserModel.fromJson(value.data()!);
      emit(GetUserDataSuccessState());
    })
        .catchError((error) {
      print(error);
      emit(GetUserDataErrorState(error));
    });
  }


  Future<void> loginOut(context) async {
    // await FirebaseFirestore.instance.clearPersistence();
    await FirebaseAuth.instance.signOut().then((value) {
      CashHelper.removeData(key: 'uid').then((value) {
        if (value)
          navigateAndFinish(context, FishFarmLogin());
      });

      emit(FishFarmLogoutSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(FishFarmLogoutErrorState(error));
    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String email,
    String ?image,
  }) {
    // emit(UpdateUserDataLoadingState());
    FishFarmUserModel modelMap = FishFarmUserModel(
      name: name,
      phone: phone,
      image: image ?? userModel!.image,
      email: email,
      uid: userModel!.uid,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .update(modelMap.toMap())
        .then((value) {
      getUserData();
      // emit(UpdateUserDataSuccessState());
    })
        .catchError((error) {
      emit(UpdateUserDataErrorState(error.toString()));
    });
  }

//   void updateUserEmail({
//     required String email,
// }){
// FirebaseAuth.instance.signInWithEmailAndPassword(email: email,
//     password: password)
// }

// Pick an image
  File? profileImageFile;
  var picker = ImagePicker();

  Future pickAProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImageFile = File(pickedFile.path);
      print(pickedFile.path.toString());
      emit(FishFarmEditUserProfileImageSuccessState());
    } else {
      print('No Image Selected');
      emit(FishFarmEditUserProfileImageErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String email,
  }) {
    emit(UpdateUserDataLoadingState());
    firebase_storage.FirebaseStorage.instance.ref()
        .child('users/${Uri.file(profileImageFile!.path)
        .pathSegments
        .last}')
        .putFile(profileImageFile!).then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(name: name, phone: phone, email: email,
          image: value,);
        emit(FishFarmUpdateUserProfileImageSuccessState());
      }).catchError((error) {
        emit(FishFarmUpdateUserProfileImageErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(FishFarmUpdateUserProfileImageErrorState(error.toString()));
    });
  }

  Widget dropDownReports<listName>({
    required Text hint,
    required className,
    required listName,
    required objectOFClass,
    required items,
  }) {
    return DropdownButtonFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder()
        ),
        iconSize: 30,
        iconEnabledColor: Colors.blue,
        hint: hint,
        isExpanded: true,
        icon: Icon(Icons.anchor),
        value: objectOFClass,
        //TheObjectOfTheClass
        onChanged: (value) {
          objectOFClass = value; //TheObjectOfTheClass=value
          //emitTheState
        },
        items: items);
  }

  void functionChangeTankNumMonthlyReport(value) {
    objectOfAllTanksName = value;
    emit(TankNameChangedSuccess());
  }

  void functionChangeProcessMonthlyReport(value) {
    tankProcessMonthlyReportSelectedUser = value;
    emit(ProcessMonthlyReportChanged());
  }

  void functionChangeSupplyMonthlyReport(value) {
    suppliesSelectedUser = value;
    emit(SupplyMonthlyReportChanged());
  }

  void functionShowButtons() {
    if (isEnable == true) {
      print('is enable=true');
      emit(ChangeIconEnable());
    }
    else {
      print('is enable=false');
    }
  }

  void createTank({
    required String tankName,
    required int tankTotalCount,
    int? tankTotalMortality,
    required double tankTotalWeight,
    int ?tankTotalFeed,
    required int tankTotalRemaining,
    required double tankAvgPsc,
  }) {
    TankModel tankModel = TankModel(
      name: tankName,
      psc: tankTotalCount,
      totalFeed: tankTotalFeed,
      totalMortality: tankTotalMortality,
      weight: tankTotalWeight,
      avgPsc: tankAvgPsc,
      remaining: tankTotalRemaining,
    );
    emit(CreateTankLoadingState());
    FirebaseFirestore.instance
        .collection('Tanks')
        .doc(tankName)
        .set(tankModel.toMap())
        .then((value) {
      emit(CreateTankSuccessState());
    })
        .catchError((error) {
      emit(CreateTankErrorState(error));
    });
  }


  void addMortality({
    required String tankName,
    required String datetime,
    String ?username,
    required String mortalityDatetime,
    required int mortalityCount,
    int? totalMortality,
    int? remaining,
  }) {
    MortalityModel mortalityModel = MortalityModel(
      remaining: remaining,
      totalMortality: totalMortality,
      dateTime: datetime,
      mortalityCount: mortalityCount,
      mortalityDate: mortalityDatetime,
      tankName: tankName,
      userName: userModel!.name,
    );
    emit(AddMortalityLoadingState());
    FirebaseFirestore.instance.collection('Tanks')
        .doc(tankName)
        .collection('Mortality')
        .doc(mortalityDatetime)
        .collection(userModel!.name!)
        .add(mortalityModel.toMap())
        .then((value) {
      FirebaseFirestore.instance.collection('Tanks')
          .doc(tankName)
          .update({'totalMortality': totalMortality});
      FirebaseFirestore.instance.collection('Tanks')
          .doc(tankName)
          .update({'remaining': remaining});
      emit(AddMortalitySuccessState());
    })
        .catchError((error) {
      emit(AddMortalityErrorState(error));
    });
  }

  List<TankModel>tankModelList = [];
  int ?tankTotalMortality;
  int ?tankTotalPscCount;

  Future <void> getSelectedTankData({required String tankName}) async {
    emit(GetTanksDataLoadingState());
    await FirebaseFirestore.instance.collection('Tanks')
        .doc(tankName)
        .get()
        .then((value) {
      tankTotalMortality = 0;
      tankModelList.clear();
      print(value.data());
      tankModelList.add(TankModel.fromJson(value.data()!));
      tankTotalMortality = tankModelList[0].totalMortality;
      tankTotalPscCount = tankModelList[0].remaining;
      // print(tankModelList[0].totalMortality);

      emit(GetTanksDataSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(GetTanksDataErrorState(error));
    });
  }

  List<TankModel>allTankModelList = [];
  List<String>tanksId = [];

  void getAllTankData() {
    emit(GetTanksDataLoadingState());
    FirebaseFirestore.instance.collection('Tanks')
        .get()
        .then((value) {
          allTankModelList.clear();
          tanksId.clear();
      value.docs.forEach((element) {
        allTankModelList.add(TankModel.fromJson(element.data()));
        tanksId.add(element.id);
      });
      print(tanksId.length);
      print(allTankModelList.length);
      // print(allTankModelList);
      //  print(allTankModelList[25].name);
      emit(GetTanksDataSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(GetTanksDataErrorState(error));
    });
  }


}
