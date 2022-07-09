
import 'package:fish_farm/Modules/Login&Register/Register/FishFarmRegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Shared/Componets/components.dart';
import '../../Shared/Network/local/cash_helper.dart';
import '../../Shared/Style/style.dart';
import '../Login&Register/login/fishFarm_login.dart';

class OnBoardingModel{
  final String image;
  final String title;
  final String body;
  OnBoardingModel( {
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {

  const OnBoardingScreen({Key? key,}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _OnBoardingScreen();
  }
}

class _OnBoardingScreen extends State<OnBoardingScreen>{
  var boardController=PageController();
List<OnBoardingModel> boardList=[
  OnBoardingModel(
      image: 'assets/image/onboarding.png',
      title: 'Welcome ',
      body: 'Agromar one of the largest companies in the world in breeding and exporting fish around the world, especially in sea eels. '),
  OnBoardingModel(
      image: 'assets/image/get in touch.png',
      title: 'Contact Us',
      body: 'No more complication, no delay in any information Just Sign in '),
  OnBoardingModel(
      image: 'assets/image/onboaring4.png',
      title: 'observation ',
      body: 'We can provide Easy Observation and clear vision'),
];
  bool isLast=false;
  void submit(){
    CashHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value)
        navigateAndFinish(context, FishFarmLoginScreen());
    });
  }
  @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context).size;
    return  Scaffold(
      backgroundColor: defaultColor,
      appBar: AppBar(
        toolbarHeight: mediaQuery.height/16,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),
            child: defaultButton(
              borderColor:Colors.yellowAccent,padding: 5
               ,buttonName:'Skip' , onTap: (){
                submit();
                ;},

            )
          )
        ],
      ),
      extendBodyBehindAppBar: false,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20.0,right: 20,left: 20),
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     const Text('Fish ',style: TextStyle(
            //         color: Colors.yellowAccent,fontSize: 32,fontWeight: FontWeight.bold
            //     ),),
            //     Text('Farm',style: TextStyle(
            //         color: Colors.yellowAccent,fontSize: 32,fontWeight: FontWeight.bold
            //     ),),
            //   ],
            // ),
            Expanded(child: PageView.builder(
              itemCount: boardList.length,
                controller:boardController ,
                onPageChanged: (int index){
                  if(index==boardList.length-1)
                  {
                    setState(() {
                      isLast=true;

                    });
                  }
                  else
                  {
                    setState(() {
                      isLast=false;
                    });
                  }
                },
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context,index)=>buildOnBoardingItem(boardList[index])),),
            const SizedBox(
              height: 20,
            ),
            SmoothPageIndicator(
                controller: boardController,
                effect:  const ExpandingDotsEffect(
                  activeDotColor: Colors.yellowAccent,
                   dotWidth: 20,
                  radius: 10,
                  dotHeight: 10
                ),
                count: boardList.length),
            Padding(
              padding: const EdgeInsets.only(top: 30.0,bottom: 10),
              child: defaultButton(
                  onTap: () {navigateTo(context, widget:  FishFarmLoginScreen()); }
                  ,buttonName: 'Get Started',),
            ) ,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Dont Have an account?',style: TextStyle(
                  color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16
                ),),
                TextButton(onPressed: (){
                  navigateTo(context, widget:  FishFarmRegisterScreen());
                }, child: Text(
                  'Register',style: TextStyle(
                  color: Colors.yellowAccent,fontSize: 16,fontWeight: FontWeight.bold
                ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget buildOnBoardingItem(OnBoardingModel model)=>Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  // mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Expanded(
      child: Image(
        image: AssetImage(model.image),),
    ),
    Text(model.title,
        style: const TextStyle(color: Colors.white,
          fontSize: 28,fontWeight: FontWeight.bold,
        ),textAlign: TextAlign.center),
    const SizedBox(
      height: 10,
    ),
    Text(model.body,
        style: const TextStyle(
            fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white
        ),textAlign: TextAlign.center),
  ],
);