abstract class FishFarmStates {}
class InitialState extends FishFarmStates{}
class ChangeNavBar0 extends FishFarmStates{}
class ChangeNavBar1 extends FishFarmStates{}
class ChangeNavBar2 extends FishFarmStates{}

class TankNameChangedSuccess extends FishFarmStates{}

class ProcessMonthlyReportChanged extends FishFarmStates{}

class SupplyMonthlyReportChanged extends FishFarmStates{}

class ChangeIconEnable extends FishFarmStates{}

class GetUserDataLoadingState extends FishFarmStates{}
class GetUserDataSuccessState extends FishFarmStates{}
class GetUserDataErrorState extends FishFarmStates{
  final String error;
  GetUserDataErrorState(this.error);
}

class FishFarmLogoutSuccessState extends FishFarmStates{}
class FishFarmLogoutErrorState extends FishFarmStates{
  final String error;
  FishFarmLogoutErrorState(this.error);
}

class FishFarmEditUserProfileImageSuccessState extends FishFarmStates{}
class FishFarmEditUserProfileImageErrorState extends FishFarmStates{

}

class UpdateUserDataLoadingState extends FishFarmStates{}
class UpdateUserDataSuccessState extends FishFarmStates{}
class UpdateUserDataErrorState extends FishFarmStates{
  final String error;
  UpdateUserDataErrorState(this.error);
}

class FishFarmUpdateUserProfileImageSuccessState extends FishFarmStates{}
class FishFarmUpdateUserProfileImageErrorState extends FishFarmStates{
  final String error;
  FishFarmUpdateUserProfileImageErrorState(this.error);
}

class CreateTankLoadingState extends FishFarmStates{}
class CreateTankSuccessState extends FishFarmStates{}
class CreateTankErrorState extends FishFarmStates{
  final String error;
  CreateTankErrorState(this.error);
}

class AddMortalityLoadingState extends FishFarmStates{}
class AddMortalitySuccessState extends FishFarmStates{}
class AddMortalityErrorState extends FishFarmStates{
  final String error;
  AddMortalityErrorState(this.error);
}

class AddTanksMortalityLoadingState extends FishFarmStates{}
class AddTanksMortalitySuccessState extends FishFarmStates{}
class AddTanksMortalityErrorState extends FishFarmStates{
  final String error;
  AddTanksMortalityErrorState(this.error);
}

class GetTanksDataLoadingState extends FishFarmStates{}
class GetTanksDataSuccessState extends FishFarmStates{}
class GetTanksDataErrorState extends FishFarmStates{
  final String error;
  GetTanksDataErrorState(this.error);
}

class GetDailyTankLoadingState extends FishFarmStates{}
class GetDailyTankSuccessState extends FishFarmStates{}
class GetDailyTankErrorState extends FishFarmStates{
  final String error;
  GetDailyTankErrorState(this.error);
}
class CreateFeedLoadingState extends FishFarmStates{}
class CreateFeedSuccessState extends FishFarmStates{}
class CreateFeedErrorState extends FishFarmStates{
  final String error;
  CreateFeedErrorState(this.error);
}

class GetFeedTypeDataLoadingState extends FishFarmStates{}
class GetFeedTypeDataSuccessState extends FishFarmStates{}
class GetFeedTypeDataErrorState extends FishFarmStates{
  final String error;
  GetFeedTypeDataErrorState(this.error);
}

class AddFeedLoadingState extends FishFarmStates{}
class AddFeedSuccessState extends FishFarmStates{}
class AddFeedErrorState extends FishFarmStates{
  final String error;
  AddFeedErrorState(this.error);
}

class AddToDailyReportLoadingState extends FishFarmStates{}
class AddToDailyReportSuccessState extends FishFarmStates{}
class AddToDailyReportErrorState extends FishFarmStates{
  final String error;
  AddToDailyReportErrorState(this.error);}

class AddToMonthlyReportLoadingState extends FishFarmStates{}
class AddToMonthlyReportSuccessState extends FishFarmStates{}
class AddToMonthlyReportErrorState extends FishFarmStates{
  final String error;
  AddToMonthlyReportErrorState(this.error);}