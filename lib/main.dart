import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fish_farm/Modules/OnBoarding/OnBoarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'Layout/home_screen.dart';
import 'Modules/Login&Register/login/fishFarm_login.dart';
import 'Shared/AppCubit/BlocObserver.dart';
import 'Shared/AppCubit/Cubit.dart';
import 'Shared/AppCubit/States.dart';
import 'Shared/Componets/constans.dart';
import 'Shared/Network/local/cash_helper.dart';
import 'Shared/PlaneViewCubit/PlaneViewStates.dart';
import 'Shared/PlaneViewCubit/planeViewCubit.dart';
import 'package:flutter/services.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CashHelper.init();
  Widget widget;
  uid=CashHelper.getData(key: 'uid');
  print(uid);
  bool? onBoarding=CashHelper.getData(key: 'onBoarding');
  if(onBoarding!=null){
    if(uid!=null){
      widget=HomeScreen();

    }else widget=FishFarmLoginScreen();
  }else{
    widget=OnBoardingScreen();
  }
  // if(uid!=null){
  //   widget=HomeScreen();
  // }else{
  //   widget=FishFarmLoginScreen();
  // }
  runApp(FishFarm(
    startScreen:widget
  ));
}
class FishFarm extends StatelessWidget {
 Widget? startScreen;
 FishFarm({this.startScreen});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>FishFarmCubit(InitialState())..getUserData()),
        BlocProvider(create: (context)=>PlaneViewCubit(PlaneViewInitialState())..sortGridView()),],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.light
            ),
            elevation: 0.00,
            titleTextStyle:
            TextStyle(
              fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold
            )
          ),
            bottomNavigationBarTheme:
            BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
                selectedLabelStyle:TextStyle(
                    fontWeight: FontWeight.bold
                ) ,
              selectedItemColor: Colors.white,
            selectedIconTheme: IconThemeData(
               size: 35,
            )
        ),
        ),
        debugShowCheckedModeBanner: false,

        home: startScreen,
      ),
    );
  }
}

