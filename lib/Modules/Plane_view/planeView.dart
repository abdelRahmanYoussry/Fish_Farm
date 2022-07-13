import 'package:fish_farm/Shared/AppCubit/Cubit.dart';
import 'package:fish_farm/Shared/AppCubit/States.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaneViewScreen extends StatelessWidget {
  const PlaneViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    return BlocConsumer<FishFarmCubit, FishFarmStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.deepPurple,
          appBar: AppBar(
            title: Text('Quick View'),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            leading: IconButton(icon: Icon(Icons.arrow_back_ios),
            onPressed: (){Navigator.pop(context);},
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  child: GridView.builder(
                    itemCount: FishFarmCubit.get(context).allTankModelList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 40,
                    ),
                     shrinkWrap:true ,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => CircleAvatar(
                      backgroundColor: Colors.yellow,
                       child: CircleAvatar(
                           backgroundColor: Colors.white,
                         radius: mediaQueryData.size.width/5,
                         child:
                         Padding(
                           padding: const EdgeInsets.only(left:20.0,right: 10,top: 10,bottom: 5),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Align(
                                 child: Text(FishFarmCubit.get(context).tanksIdList[index],style: TextStyle(
                                   fontSize: 14,fontWeight: FontWeight.bold
                                 )),
                                 alignment: Alignment.center,
                               ),
                               SizedBox(
                                 height: 5,
                               ),
                              Text('Eel Size: '+FishFarmCubit.get(context).allTankModelList[index].avgPsc.toString()+' Kg',
                                style:Theme.of(context).textTheme.caption!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ) ,),
                               SizedBox(
                                 height: 5,
                               ),
                               Text('Weight: '+FishFarmCubit.get(context).allTankModelList[index].weight.toString()+' Kg',
                                 style:Theme.of(context).textTheme.caption!.copyWith(
                                   fontWeight: FontWeight.bold,
                                 )  ,),
                               SizedBox(
                                 height: 5,
                               ),
                               Text('Mor: '+FishFarmCubit.get(context).allTankModelList[index].totalMortality.toString()+' Pcs',
                                   style:Theme.of(context).textTheme.caption!.copyWith(
                                     fontWeight: FontWeight.bold,
                                   )
                               ),
                               SizedBox(
                                 height: 5,
                               ),
                               Text('Rem: '+FishFarmCubit.get(context).allTankModelList[index].remaining.toString()+' Pcs',
                                   style:Theme.of(context).textTheme.caption!.copyWith(
                                     fontWeight: FontWeight.bold,
                                   ) ),
                               SizedBox(
                                 height: 5,
                               ),

                               Text('Feed: '+FishFarmCubit.get(context).allTankModelList[index].totalFeed.toString()+' Kg',
                                   style:Theme.of(context).textTheme.caption!.copyWith(
                                     fontWeight: FontWeight.bold,
                                   ) ),
                             ],
                           ),
                         )
                       )
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
    }
}