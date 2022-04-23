import 'package:fish_farm/Shared/PlaneViewCubit/planeViewCubit.dart';
import 'package:fish_farm/Shared/PlaneViewCubit/planeViewCubit.dart';
import 'package:fish_farm/Shared/Componets/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Shared/PlaneViewCubit/PlaneViewStates.dart';

class PlaneViewScreen extends StatelessWidget {
  const PlaneViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlaneViewCubit, PlaneViewStates>(
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
                    itemCount: PlaneViewCubit.get(context).planeListNew.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 20,
                    ),
                     shrinkWrap:true ,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10,top: 10,),
                      child: CircleAvatar(
                        backgroundColor: Colors.yellow,
                         child: CircleAvatar(
                             backgroundColor: Colors.white,
                           radius: 82,
                           child:
                           Padding(
                             padding: const EdgeInsets.only(left: 25.0,right: 8,top: 10,bottom: 5),
                             child: Container(
                               width: double.infinity,
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Padding(
                                     padding: const EdgeInsets.only(left: 40.0),
                                     child: Text(PlaneViewCubit.get(context).planeListNew[index]['Id']),
                                   ),
                                   SizedBox(
                                     height: 5,
                                   ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text('Size: Glass Eel'),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                   Text('Mor: 12000 Pc'),
                                   SizedBox(
                                     height: 5,
                                   ),
                                   Text('Rem: 12000 Pc'),
                                   SizedBox(
                                     height: 5,
                                   ),
                                   Text('Weight: 83 Kg'),
                                   SizedBox(
                                     height: 5,
                                   ),
                                   Padding(
                               padding: const EdgeInsets.only(left: 10.0),
                               child: Text('Feed: 5.3 Kg'),
                             ),
                                 ],
                               ),
                             ),
                           )
                         )
                      ),
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