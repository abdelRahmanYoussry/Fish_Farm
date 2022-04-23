
abstract class FishFarmLoginStates{}
class FishFarmLoginInitialState extends FishFarmLoginStates{}
class FishFarmLoginLoadingState extends FishFarmLoginStates{}
class FishFarmLoginSuccessState extends FishFarmLoginStates
{
final String uid;
FishFarmLoginSuccessState(this.uid);
}
class FishFarmLoginErrorState extends FishFarmLoginStates{
  final String error;
  FishFarmLoginErrorState(this.error);
}

class FishFarmLoginPasswordVisibility extends FishFarmLoginStates{}


