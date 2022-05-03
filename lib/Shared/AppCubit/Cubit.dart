import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:fish_farm/Models/DailyModel.dart';
import 'package:fish_farm/Models/MortalityTankModel.dart';
import 'package:fish_farm/Models/ProfileModel.dart';
import 'package:fish_farm/Modules/Login&Register/login/fishFarm_login.dart';
import 'package:fish_farm/Modules/Reports/Monthly_Report/Monthly_Reports_Layout.dart';
import 'package:fish_farm/Modules/Reports/Daily_Report/dailyRepotrs_view.dart';
import 'package:fish_farm/Modules/Reports/Stock_Report/StockReports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../Models/CreateFeedModel.dart';
import '../../Models/MonthlyModel.dart';
import '../../Models/MortalityModel.dart';
import '../../Models/TanksFeedModel.dart';
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
  MortalityTanksModel? mortalityModel;

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

  // Widget dropDownReports<listName>({
  //   required Text hint,
  //   required className,
  //   required listName,
  //   required objectOFClass,
  //   required items,
  // }) {
  //   return DropdownButtonFormField(
  //       decoration: InputDecoration(
  //           border: OutlineInputBorder()
  //       ),
  //       iconSize: 30,
  //       iconEnabledColor: Colors.blue,
  //       hint: hint,
  //       isExpanded: true,
  //       icon: Icon(Icons.anchor),
  //       value: objectOFClass,
  //       //TheObjectOfTheClass
  //       onChanged: (value) {
  //         objectOFClass = value; //TheObjectOfTheClass=value
  //         //emitTheState
  //       },
  //       items: items);
  // }

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

  void createFeed({
    required String feedName,
    required double purchasedFeedWeight,
    required double remainingFeedWeight,
    required String purchasedDate,
  }) {
    CreateFeedModel createFeedModel = CreateFeedModel(
      remainingFeed: remainingFeedWeight,
      feedName: feedName,
      purchasedDate: purchasedDate,
     totalPurchasedFeed: purchasedFeedWeight

    );
    emit(CreateFeedLoadingState());
    FirebaseFirestore.instance
        .collection('Feed')
        .doc(feedName)
        .set(createFeedModel.toMap())
        .then((value) {

      emit(CreateFeedSuccessState());
    })
        .catchError((error) {
      emit(CreateFeedErrorState(error));
    });
  }

  void addToTotalTanksMortality({
    required String tankName,
    required String datetime,
    String ?username,
    required String mortalityDatetime,
    required int mortalityCount,
    required int totalDailyMortality,
    int? totalTankMortality,
    int? remaining,
  }) {
    MortalityTanksModel mortalityTankModel = MortalityTanksModel(
      remaining: remaining,
      totalMortality: totalTankMortality,
      dateTime: datetime,
      mortalityCount: mortalityCount,
      mortalityDate: mortalityDatetime,
      tankName: tankName,
      userName: userModel!.name,
    );
    emit(AddTanksMortalityLoadingState());
    FirebaseFirestore.instance.collection('Tanks')
        .doc(tankName)
        .collection('Mortality')
        .doc(mortalityDatetime)
        .collection(userModel!.name!)
        .add(mortalityTankModel.toMap())
        .then((value) {
      FirebaseFirestore.instance.collection('Tanks')
          .doc(tankName)
          .update({'totalMortality': totalTankMortality});
      FirebaseFirestore.instance.collection('Tanks')
          .doc(tankName)
          .update({'remaining': remaining});
      FirebaseFirestore.instance.collection('Tanks')
          .doc(tankName)
          .collection('Mortality')
          .doc(mortalityDatetime)
          .set({'TotalDayMortality':totalDailyMortality});
      emit(AddTanksMortalitySuccessState());
    })
        .catchError((error) {
      emit(AddTanksMortalityErrorState(error));
    });
  }

  List<TankModel>tankModelList = [];
  int ?tankTotalMortality;
  int ?tankTotalPscRemaining;
  int ?tankTotalFeed;
  int ?tankTotalPsc;

  Future <void> getTotalSelectedTankData({required String tankName}) async
  {
    emit(GetTanksDataLoadingState());
    await FirebaseFirestore.instance.collection('Tanks')
        .doc(tankName)
        .get()
        .then((value) {
      tankTotalMortality = 0;
      tankTotalFeed = 0;
      tankModelList.clear();
      print(value.data());
      tankModelList.add(TankModel.fromJson(value.data()!));
      tankTotalFeed=tankModelList[0].totalFeed ;
      tankTotalMortality = tankModelList[0].totalMortality;
      tankTotalPscRemaining = tankModelList[0].remaining;
      tankTotalPsc=tankModelList[0].psc;

      emit(GetTanksDataSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(GetTanksDataErrorState(error.toString()));
    });
  }




  List<TankModel>allTankModelList = [];
  List<String>tanksIdList = [];

  void getAllTankData() {
    emit(GetTanksDataLoadingState());
    FirebaseFirestore.instance.collection('Tanks')
        .get()
        .then((value) {
          allTankModelList.clear();
          tanksIdList.clear();
      value.docs.forEach((element) {
        allTankModelList.add(TankModel.fromJson(element.data()));
        tanksIdList.add(element.id);
      });
      emit(GetTanksDataSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(GetTanksDataErrorState(error));
    });
  }

  List<CreateFeedModel>allCreateFeedModelList = [];
  List<String>feedIdList = [];
  void getAllFeedTypesData() {
    emit(GetFeedTypeDataLoadingState());
    FirebaseFirestore.instance.collection('Feed')
        .get()
        .then((value) {
      allCreateFeedModelList.clear();
      feedIdList.clear();
      value.docs.forEach((element) {
        allCreateFeedModelList.add(CreateFeedModel.fromJson(element.data()));
        feedIdList.add(element.id);
      });
      emit(GetFeedTypeDataSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(GetFeedTypeDataErrorState(error));
    });
  }


  void addDailyFeed({
    required String tankName,
    required String datetime,
    required String feedName,
    required String feedDatetime,
    required int feedWeight,
    int? totalFeed,
    int? remaining,
  }) {
    TanksFeedModel feedModel = TanksFeedModel(
      feedWeight: feedWeight.toDouble(),
      feedDate: feedDatetime,
      feedSize: feedName,
      totalRemainingFeed: remaining,
      totalFeed: totalFeed,
      dateTime: datetime,
      tankName: tankName,
      userName: userModel!.name,
    );
    emit(AddFeedLoadingState());
    FirebaseFirestore.instance.collection('Tanks')
        .doc(tankName)
        .collection('Feed')
        .doc(feedDatetime)
        .collection(userModel!.name!)
        .add(feedModel.toMap())
        .then((value) {
      FirebaseFirestore.instance.collection('Tanks')
          .doc(tankName)
          .update({'totalFeed': totalFeed});
      emit(AddFeedSuccessState());
    })
        .catchError((error) {
      emit(AddFeedErrorState(error));
    });
  }

  void addToDailyReport({
    required String tankName,
    required String day,
     int totalMortality=0,
     int totalFeed=0,
    required int pcsRemaining,
  }){
    DailyModel dailyModel=DailyModel(
      totalMortality: totalMortality,
      tankName: tankName,
      totalFeed: totalFeed,
      day: day,
      pcsRemaining: pcsRemaining
    );
    emit(AddToDailyReportLoadingState());
  FirebaseFirestore.instance
  .collection('DailyReport')
  .doc(day)
  .collection(tankName)
  .doc('Daily')
  .set(dailyModel.toMap())
  .then((value) {
    emit(AddToDailyReportSuccessState());

  }).catchError((error){
    emit(AddToDailyReportErrorState(error));
  });
  }

  int ?tankDailyMortality;
  int ?tankDailyFeed;
  Future <void> getDailySelectedTankData({
    required String tankName,
    required String selectedDay,
  }) async {
    emit(GetDailyTankLoadingState());
    await FirebaseFirestore.instance.collection('Tanks')
        .doc(tankName)
        .collection('Mortality')
        .doc(selectedDay)
        .get()
        .then((value) {
      tankDailyMortality=0;
      if(value.data()==null){
        tankDailyMortality=0;
      }
      tankDailyMortality=value.data()!['TotalDayMortality'];
      print(tankDailyMortality);
      emit(GetDailyTankSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(GetDailyTankErrorState(error.toString()));
    });
  }

int tankMonthlyMortality=0;
  Future <void> getMonthlySelectedTankData({
    required String tankName,
    required String selectedMonth,
  }) async {
    emit(GetDailyTankLoadingState());
    await FirebaseFirestore.instance
        .collection('MonthlyReport')
        .doc(selectedMonth)
        .collection(tankName)
        .doc('Monthly')
        .get()
        .then((value) {
      tankMonthlyMortality=0;
      if(value.data()==null){
        tankMonthlyMortality=0;
      }
      tankMonthlyMortality=value.data()!['totalMortality'];
      print(tankMonthlyMortality);
      emit(GetDailyTankSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(GetDailyTankErrorState(error.toString()));
    });
  }

// int monthlyMortality=0;
  void addToMonthlyReport({
    required String tankName,
    required String month,
    int totalMortality=0,
    int totalFeed=0,
    required int pcsRemaining,
  }){
    MonthlyModel monthlyModel=MonthlyModel(
        totalMortality: totalMortality,
        tankName: tankName,
        totalFeed: totalFeed,
        month: month,
        pcsRemaining: pcsRemaining
    );
    emit(AddToMonthlyReportLoadingState());
    FirebaseFirestore.instance
        .collection('MonthlyReport')
        .doc(month)
        .collection(tankName)
        .doc('Monthly')
        .set(monthlyModel.toMap())
        .then((value) {
      //make this in uique method
      // FirebaseFirestore.instance
      //     .collection('MonthlyReport')
      //     .doc(month)
      //     .collection(tankName)
      //     .doc('Monthly')
      //     .get()
      //     .then((value) {
      //       monthlyMortality=0;
      //       // print(value.data().toString());
      //       monthlyMortality=value.data()!['totalMortality']??0;
      //       print(monthlyMortality);
      // })
      //     .catchError((error){
      //   emit(AddToMonthlyReportErrorState(error));
      // });
      emit(AddToMonthlyReportSuccessState());
    }).catchError((error){
      emit(AddToMonthlyReportErrorState(error));
    });
  }



}
