import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'PlaneViewStates.dart';

class PlaneViewCubit extends Cubit<PlaneViewStates>{
  PlaneViewCubit(PlaneViewStates initialState) : super(initialState);

static PlaneViewCubit get(context)=>BlocProvider.of(context);
  List<Map> planeListAll=
  [{'Id':'A1', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
    'Weight':'83 Kg', 'Feed':'5.6 Kg'}, {'Id':'A2', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
    'Weight':'83 Kg', 'Feed':'5.6 Kg'}, {'Id':'A3', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
    'Weight':'83 Kg', 'Feed':'5.6 Kg'}, {'Id':'A4', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
    'Weight':'83 Kg', 'Feed':'5.6 Kg'}, {'Id':'A5', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
    'Weight':'83 Kg', 'Feed':'5.6 Kg'},
    {'Id':'A6', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
      'Weight':'83 Kg', 'Feed':'5.6 Kg'}, {'Id':'A7', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
    'Weight':'83 Kg', 'Feed':'5.6 Kg'}, {'Id':'A8', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
    'Weight':'83 Kg', 'Feed':'5.6 Kg'}, {'Id':'B1', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
    'Weight':'83 Kg', 'Feed':'5.6 Kg'}, {'Id':'B2', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
    'Weight':'83 Kg', 'Feed':'5.6 Kg'}, {'Id':'B3', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
    'Weight':'83 Kg', 'Feed':'5.6 Kg'},
    {'Id':'B4', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
      'Weight':'83 Kg', 'Feed':'5.6 Kg'}, {'Id':'B5', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
    'Weight':'83 Kg', 'Feed':'5.6 Kg'}, {'Id':'B6', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
    'Weight':'83 Kg', 'Feed':'5.6 Kg'}, {'Id':'B7', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
    'Weight':'83 Kg', 'Feed':'5.6 Kg'}, {'Id':'B8', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
    'Weight':'83 Kg', 'Feed':'5.6 Kg'}, {'Id':'C1', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
    'Weight':'83 Kg', 'Feed':'5.6 Kg'},
    {'Id':'C2', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
      'Weight':'83 Kg', 'Feed':'5.6 Kg'}, {'Id':'C3', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
    'Weight':'83 Kg', 'Feed':'5.6 Kg'}, {'Id':'C4', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
    'Weight':'83 Kg', 'Feed':'5.6 Kg'}, {'Id':'C5', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
    'Weight':'83 Kg', 'Feed':'5.6 Kg'}, {'Id':'C6', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
    'Weight':'83 Kg', 'Feed':'5.6 Kg'}, {'Id':'C7', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
    'Weight':'83 Kg', 'Feed':'5.6 Kg'},
    {'Id':'C8', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
      'Weight':'83 Kg', 'Feed':'5.6 Kg'}, {'Id':'D1', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
    'Weight':'83 Kg', 'Feed':'5.6 Kg'}, {'Id':'D2', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
    'Weight':'83 Kg', 'Feed':'5.6 Kg'}, {'Id':'D3', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
    'Weight':'83 Kg', 'Feed':'5.6 Kg'}, {'Id':'D4', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
    'Weight':'83 Kg', 'Feed':'5.6 Kg'}, {'Id':'D5', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
    'Weight':'83 Kg', 'Feed':'5.6 Kg'},
    {'Id':'D6', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
      'Weight':'83 Kg', 'Feed':'5.6 Kg'}, {'Id':'D7', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
    'Weight':'83 Kg', 'Feed':'5.6 Kg'}, {'Id':'D8', 'Size':'Croco', 'Mor':'1 pc', 'Rem':'110999 pc',
    'Weight':'83 Kg', 'Feed':'5.6 Kg'}];
  List<Map> planeListFirst=[];
  List<Map> planeListSecond=[];
  List<Map> planeListNew=[];
  int indexOfFirstList=0;
  int indexOfSecondList=0;
void sortGridView(){

  for(var x=0;x<planeListAll.length/2;x++)
  {
    planeListFirst.add(planeListAll[x]);
  }
  for(var x=planeListAll.length/2;x<planeListAll.length;x++)
  {
    planeListSecond.add(planeListAll[x.toInt()]);
  }
  for(var i=0;i<planeListAll.length;i++){
    if(indexOfFirstList==indexOfSecondList){
      planeListNew.add(planeListSecond[indexOfSecondList]);
      indexOfSecondList++;
    }
    else
      {
        planeListNew.add(planeListFirst[indexOfFirstList]);
        indexOfFirstList++;
      }

  }
}

}




