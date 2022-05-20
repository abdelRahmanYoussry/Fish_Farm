import 'dart:ffi';
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
import '../../Models/FeedTypeModel.dart';
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
  FishFarmUserModel?userModel;
  TankModel?tankModel;
  MortalityTanksModel? mortalityModel;
  DailyModel? dailyModel;
  MonthlyModel? monthlyModel;
  FeedTypeModel?feedTypeModel;
  void changeNavBar(int index)
  {
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

  void getUserData()
  {
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


  Future<void> loginOut(context) async
  {
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

  void createTank({
    required String tankName,
    required int tankTotalCount,
    int tankTotalMortality=0,
    required double tankTotalWeight,
    double tankTotalFeed=0,
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
    FeedTypeModel createFeedModel = FeedTypeModel(
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

  void addMortalityToTanks({
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
      //update total mortality in tanks collection
      FirebaseFirestore.instance.collection('Tanks')
          .doc(tankName)
          .update({'totalMortality': totalTankMortality});
      //update total remaining in tanks collection
      FirebaseFirestore.instance.collection('Tanks')
          .doc(tankName)
          .update({'remaining': remaining});
      //update daily mortality in tanks collection and mortality collection
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


  Future <void> getTotalSelectedTankData({required String tankName}) async
  {
    emit(GetTotalTankDataLoadingState());
    await FirebaseFirestore.instance.collection('Tanks')
        .doc(tankName)
        .get()
        .then((value) {
    tankModel=TankModel.fromJson(value.data()!);
   // print(tankModel!.totalMortality);
      emit(GetTotalTankDataSuccessState());
    })
        .catchError((error) {
      emit(GetTotalTankDataErrorState(error.toString()));
    });
  }




  List<TankModel>allTankModelList = [];
  List<String>tanksIdList = [];

  void getAllTankData() {
    emit(GetAllTanksDataLoadingState());
    FirebaseFirestore.instance.collection('Tanks')
        .get()
        .then((value) {
          allTankModelList.clear();
          tanksIdList.clear();
      value.docs.forEach((element) {
        allTankModelList.add(TankModel.fromJson(element.data()));
        tanksIdList.add(element.id);
      });
      emit(GetAllTanksDataSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(GetAllTanksDataErrorState(error));
    });
  }

  List<FeedTypeModel>allCreateFeedModelList = [];
  List<String>feedIdList = [];
  void getAllFeedTypesData() {
    emit(GetAllFeedTypeDataLoadingState());
    FirebaseFirestore.instance.collection('Feed')
        .get()
        .then((value) {
      allCreateFeedModelList.clear();
      feedIdList.clear();
      value.docs.forEach((element) {
        allCreateFeedModelList.add(FeedTypeModel.fromJson(element.data()));
        feedIdList.add(element.id);
      });
      emit(GetAllFeedTypeDataSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(GetAllFeedTypeDataErrorState(error));
    });
  }


  void addFeedToTanks({
    required String tankName,
    required String datetime,
    required String feedName,
    required String feedDatetime,
    required double feedWeight,
    num? totalFeed,
    num? dailyTotalFeed,
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
          //add feed in total tanks collection
      FirebaseFirestore.instance.collection('Tanks')
          .doc(tankName)
          .update({'totalFeed': totalFeed});
      //add daily feed in tanks collection
      FirebaseFirestore.instance.collection('Tanks')
      .doc(tankName)
      .collection('Feed')
      .doc(feedDatetime)
      .set({'TotalFeedDaily':dailyTotalFeed});
      emit(AddFeedSuccessState());
    })
        .catchError((error) {
      emit(AddFeedErrorState(error));
    });
  }

  void addToDailyReport({
    required String tankName,
    required String day,
     String? month,
     int? dailyMortality,
     num ?dailyFeed,
     String?feedType,
     int ?remainingPsc,
  }){
    DailyModel dailyModel=DailyModel(
      dailyMortality: dailyMortality,
      tankName: tankName,
      dailyFeed: dailyFeed,
      day: day,
      feedType: feedType,
      remainingPsc: remainingPsc
    );
    emit(AddToDailyReportLoadingState());
  FirebaseFirestore.instance
  .collection('DailyReport')
  .doc(day)
  .collection(tankName)
  .doc('Daily')
  .set(dailyModel.toMap())
  .then((value) {
    FirebaseFirestore.instance
        .collection('MonthlyReport')
        .doc(month)
        .collection(tankName)
        .doc('Monthly')
        .collection(day)
        .doc('Daily')
        .set(dailyModel.toMap())
        .then((value) {
      emit(AddToMonthlyReportSuccessState());
    })
        .catchError((error){
      emit(AddToMonthlyReportErrorState(error.toString()));
    });
    emit(AddToDailyReportSuccessState());

  }).catchError((error){
    emit(AddToDailyReportErrorState(error));
  });
  }

  Future <void> getDailyReportData({
    required String tankName,
    required String selectedDay,
  }) async {
    emit(GetDailyTankLoadingState());
    await FirebaseFirestore.instance.collection('DailyReport')
        .doc(selectedDay)
        .collection(tankName)
        .doc('Daily')
        .get()
        .then((value) {
          if(value.data()==null){
        dailyModel=DailyModel(
              dailyFeed: 0,
                day: selectedDay,
                tankName: tankName,
              dailyMortality: 0,
              remainingPsc: tankModel!.remaining
            );
          }  else
             dailyModel= DailyModel.fromJson(value.data()!);

      emit(GetDailyTankSuccessState());
    })
        .catchError((error) {
      emit(GetDailyTankErrorState(error.toString()));
    });
  }

  int ?tankDailyMortality;
  Future <void> getDailyMortalityInTankCollection({
    required String tankName,
    required String selectedDay,
  }) async {
    emit(GetDailyMortalityInTankCollectionLoadingState());
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
      // print(tankDailyMortality);
      emit(GetDailyMortalityInTankCollectionSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(GetDailyMortalityInTankCollectionErrorState(error.toString()));
    });
  }

  // // num ?tankDailyFeed;
  // Future <void> getTanksDailyFeed({
  //   required String tankName,
  //   required String selectedDay,
  // }) async {
  //   emit(GetDailyTankLoadingState());
  //   await FirebaseFirestore.instance.collection('Tanks')
  //       .doc(tankName)
  //       .collection('Feed')
  //       .doc(selectedDay)
  //       .get()
  //       .then((value) {
  //     tankDailyFeed=0;
  //     if(value.data()==null){
  //       tankDailyFeed=0;
  //     }
  //     tankDailyFeed=value.data()!['TotalFeedDaily'];
  //     print(tankDailyFeed);
  //     emit(GetDailyTankSuccessState());
  //   })
  //       .catchError((error) {
  //     print(error.toString());
  //     emit(GetDailyTankErrorState(error.toString()));
  //   });
  // }


  Future <void> getMonthlySelectedTankData({
    required String tankName,
    required String selectedMonth,
  }) async {
    emit(GetMonthlyTankLoadingState());
    await FirebaseFirestore.instance
        .collection('MonthlyReport')
        .doc(selectedMonth)
        .collection(tankName)
        .doc('Monthly')
        .get()
        .then((value) {
          if(value.data()==null)
            {
              monthlyModel=MonthlyModel(
                tankName: tankName,
                totalMortality: 0,
                totalFeed: 0,
                pcsRemaining: tankModel!.remaining,
                month: selectedMonth
              );
            }
          monthlyModel=MonthlyModel.fromJson(value.data()!);
      emit(GetMonthlyTankSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(GetMonthlyTankErrorState(error.toString()));
    });
  }

// int monthlyMortality=0;
  void addToMonthlyReport({
    required String tankName,
    required String month,
     String? day,
    int totalMortality=0,
    num totalFeed=0,
    required int pcsRemaining,
  })   {
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
      emit(AddToMonthlyReportErrorState(error.toString()));
    });
  }

    Future <void> getRemainingOfSelectedFeed({
      required String feedType }) async
    {
    emit(GetFeedTypeDataLoadingState());
  await  FirebaseFirestore.instance
        .collection('Feed')
        .doc(feedType)
        .get()
        .then((value) {
            feedTypeModel=FeedTypeModel.fromJson(value.data()!);
            emit(GetFeedTypeDataSuccessState());
              print(feedTypeModel!.remainingFeed);
    })
        .catchError((error){
      emit(GetFeedTypeDataErrorState(error));

    });

}

  void updateRemainingFeed({required String feedType,required num remainingFeed}){
    emit(UpdateFeedLoadingState());
   FeedTypeModel updateFeedTypeModel=FeedTypeModel(
     totalPurchasedFeed: feedTypeModel!.totalPurchasedFeed,
     purchasedDate: feedTypeModel!.purchasedDate,
     feedName: feedTypeModel!.feedName,
     remainingFeed: remainingFeed,
   );
  FirebaseFirestore.instance
  .collection('Feed')
  .doc(feedType)
  .update(updateFeedTypeModel.toMap())
  .then((value) {
    emit(UpdateFeedSuccessState());

  })
  .catchError((error){
    emit(UpdateFeedErrorState(error));
  });

}

  void deleteTank({required String tankName,}){
    emit(DeleteTankLoadingState());
    FirebaseFirestore.instance
    .collection('Tanks')
    .doc(tankName)
    .delete()
    .then((value) {
      emit(DeleteTankSuccessState());
    })
    .catchError((error){
      emit(DeleteTankErrorState(error));
    });
    
}

 void editTankData({
   required String tankName,
   required String day,
   required String month,
   required String feedType,
   required num dailyFeedWeight,
   required int dailyMortalityCount,
   required int dailyRemainingPsc,
   required num monthlyFeedWeight,
   required int monthlyMortalityCount,
   required int monthlyRemainingPsc,
   required int totalMortalityCount,
   required num totalFeedWeight,
   required int totalRemainingPsc,
   required num remainingFeed,
 }){
    emit(EditTanksDataLoadingState());
    //1 Edit DailyReport Collection
    FirebaseFirestore.instance
    .collection('DailyReport')
    .doc(day)
    .collection(tankName)
    .doc('Daily')
    .update({'dailyMortality':dailyMortalityCount,'dailyFeed':dailyFeedWeight,'remainingPsc':dailyRemainingPsc})
    .then((value) {
      //2 Edit MonthlyReport Collection
      FirebaseFirestore.instance
      .collection('MonthlyReport')
      .doc(month)
      .collection(tankName)
      .doc('Monthly')
      .update({'totalMortality':monthlyMortalityCount,'totalFeed':monthlyFeedWeight,'pcsRemaining':monthlyRemainingPsc});
      //3 Edit Tanks Collection Total & Daily
      FirebaseFirestore.instance
      .collection('Tanks')
      .doc(tankName)
      .update({'totalMortality':totalMortalityCount,'totalFeed':totalFeedWeight,'remaining':totalRemainingPsc});
      FirebaseFirestore.instance
          .collection('Tanks')
          .doc(tankName)
          .collection('Mortality')
          .doc(day)
          .update({'TotalDayMortality':dailyMortalityCount});
      FirebaseFirestore.instance
          .collection('Tanks')
          .doc(tankName)
          .collection('Feed')
          .doc(day)
          .update({'TotalFeedDaily':dailyFeedWeight});
      //edit Remaining feed
      FirebaseFirestore.instance
      .collection('Feed')
      .doc(feedType)
      .update({'remainingFeed':remainingFeed});
      //edit in daily inside monthly collection
      FirebaseFirestore.instance
      .collection('MonthlyReport')
      .doc(month)
      .collection(tankName)
      .doc('Monthly')
      .collection(day)
      .doc('Daily')
      .update({'dailyMortality':dailyMortalityCount,'dailyFeed':dailyFeedWeight,'remainingPsc':dailyRemainingPsc});
      emit(EditTanksDataSuccessState());

    })
    .catchError((error){
      emit(EditTanksDataErrorState(error));
    });
    
 }

 // Future <void> getRemaining({
 //  required  String tankName,})async{
 //   FirebaseFirestore.instance
 //   .collection('Tanks')
 //   .doc(tankName)
 //   .get()
 //   .then((value) {
 //     print(value.data()!['remaining']);
 //     //tankModel=TankModel.fromJson(value.data()!);
 //   })
 //   .catchError((error){});
 //
 //
 // }

}
