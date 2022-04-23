

abstract class FishFarmRegisterStates{
}
class FishFarmRegisterInitialState extends FishFarmRegisterStates{}
class FishFarmRegisterLoadingState extends FishFarmRegisterStates{}
class FishFarmRegisterSuccessState extends FishFarmRegisterStates{}
class FishFarmRegisterErrorState extends FishFarmRegisterStates{
  final String error;
  FishFarmRegisterErrorState(this.error);
}
class FishFarmCreateUserSuccessState extends FishFarmRegisterStates{}

class FishFarmCreateUserErrorState extends FishFarmRegisterStates{
  final String error;
  FishFarmCreateUserErrorState(this.error);
}
class FishFarmRegisterPasswordVisibility extends FishFarmRegisterStates{}