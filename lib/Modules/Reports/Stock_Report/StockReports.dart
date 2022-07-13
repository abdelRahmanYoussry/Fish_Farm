import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fish_farm/Shared/AppCubit/Cubit.dart';
import 'package:fish_farm/Shared/AppCubit/Cubit.dart';
import 'package:fish_farm/Shared/Componets/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Shared/AppCubit/States.dart';
import '../../../Shared/Style/style.dart';

class StockReports extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FishFarmCubit.get(context).getAllFeedTypesData();

    return BlocConsumer<FishFarmCubit, FishFarmStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var feedModel = FishFarmCubit.get(context).feedTypeList;
        var feedNameModel = FishFarmCubit.get(context).feedIdList;
        return Scaffold(
          backgroundColor: defaultColor,
          appBar: defaultAppBar(
            context: context,
            title: 'Stock Report',
            backGroundColor: defaultColor,
            elevation: 0.0,
            centerTitle: true,
          ),

          body:ConditionalBuilder(
            condition:FishFarmCubit.get(context).feedTypeList.length>0 ,
            fallback: (context)=>CircularProgressIndicator(
              color: Colors.yellowAccent,
            ),
            builder: (context)=>Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount:FishFarmCubit.get(context).feedTypeList.length ,
                separatorBuilder:(context,index)=> Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: dividerWidget(),
                ),
                itemBuilder: (context,index)=> Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black87.withOpacity(0.2),
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(30),
                            right: Radius.circular(30),
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.all(5.0),
                            //   child: Text('Feed Name',style: TextStyle(
                            //       color: Colors.white,fontSize: 26
                            //   ),),
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(feedNameModel[index],style: TextStyle(
                                  color: Colors.white,fontSize: 26
                              ),),
                            ),
                            // Row(
                            //   children: [
                            //     Padding(
                            //       padding: const EdgeInsets.all(5.0),
                            //       child: Text('FeedName :',style: TextStyle(
                            //           color: Colors.white,fontSize: 20
                            //       ),),
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.all(5.0),
                            //       child: Text('',style: TextStyle(
                            //           color: Colors.white,fontSize: 20
                            //       ),),
                            //     ),
                            //
                            //   ],
                            // ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text('Received Weight(Kg) :',style: TextStyle(
                                      color: Colors.white,fontSize: 20
                                  ),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(feedModel[index].totalPurchasedFeed.toString(),style: TextStyle(
                                      color: Colors.white,fontSize: 20
                                  ),),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text('StorageDate :',style: TextStyle(
                                      color: Colors.white,fontSize: 20
                                  ),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(feedModel[index].purchasedDate.toString(),style: TextStyle(
                                      color: Colors.white,fontSize: 20
                                  ),),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text('Remaining Feed(Kg)  :',style: TextStyle(
                                      color: Colors.white,fontSize: 20
                                  ),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(feedModel[index].remainingFeed.toString(),style: TextStyle(
                                      color: Colors.white,fontSize: 20
                                  ),),
                                ),
                              ],
                            ),
                            // Row(
                            //   children: [
                            //     Padding(
                            //       padding: const EdgeInsets.all(5.0),
                            //       child: Text('Feed Type  :',
                            //         style: TextStyle(color: Colors.white,fontSize: 20
                            //         ),),
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.all(5.0),
                            //       child: Text('',
                            //         style: TextStyle(color: Colors.white,fontSize: 20
                            //         ),),
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   children: [
                            //     Padding(
                            //       padding: const EdgeInsets.all(5.0),
                            //       child: Text('Daily Feed Weight(Kg):',
                            //         style: TextStyle(color: Colors.white,fontSize: 20
                            //         ),),
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.all(5.0),
                            //       child: Text('',
                            //         style: TextStyle(color: Colors.white,fontSize: 20
                            //         ),),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        );
      },
    );
  }
}
