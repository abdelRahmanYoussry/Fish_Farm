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

// class AddMortalityLoadingState extends FishFarmStates{}
// class AddMortalitySuccessState extends FishFarmStates{}
// class AddMortalityErrorState extends FishFarmStates{
//   final String error;
//   AddMortalityErrorState(this.error);
// }

class AddTanksMortalityLoadingState extends FishFarmStates{}
class AddTanksMortalitySuccessState extends FishFarmStates{}
class AddTanksMortalityErrorState extends FishFarmStates{
  final String error;
  AddTanksMortalityErrorState(this.error);
}

class GetTotalTankDataLoadingState extends FishFarmStates{}
class GetTotalTankDataSuccessState extends FishFarmStates{}
class GetTotalTankDataErrorState extends FishFarmStates{
  final String error;
  GetTotalTankDataErrorState(this.error);
}

class GetAllTanksDataLoadingState extends FishFarmStates{}
class GetAllTanksDataSuccessState extends FishFarmStates{}
class GetAllTanksDataErrorState extends FishFarmStates{
  final String error;
  GetAllTanksDataErrorState(this.error);
}

class GetDailyTankLoadingState extends FishFarmStates{}
class GetDailyTankSuccessState extends FishFarmStates{}
class GetDailyTankErrorState extends FishFarmStates{
  final String error;
  GetDailyTankErrorState(this.error);
}

class GetMonthlyTankLoadingState extends FishFarmStates{}
class GetMonthlyTankSuccessState extends FishFarmStates{}
class GetMonthlyTankErrorState extends FishFarmStates{
  final String error;
  GetMonthlyTankErrorState(this.error);
}

class GetMonthlyDataByDaysLoadingState extends FishFarmStates{}
class GetMonthlyDataByDaysSuccessState extends FishFarmStates{}
class GetMonthlyDataByDaysErrorState extends FishFarmStates{
  final String error;
  GetMonthlyDataByDaysErrorState(this.error);
}

class GetDailyMortalityInTankCollectionLoadingState extends FishFarmStates{}
class GetDailyMortalityInTankCollectionSuccessState extends FishFarmStates{}
class GetDailyMortalityInTankCollectionErrorState extends FishFarmStates{
  final String error;
  GetDailyMortalityInTankCollectionErrorState(this.error);
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

class GetAllFeedTypeDataLoadingState extends FishFarmStates{}
class GetAllFeedTypeDataSuccessState extends FishFarmStates{}
class GetAllFeedTypeDataErrorState extends FishFarmStates{
  final String error;
  GetAllFeedTypeDataErrorState(this.error);
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

class UpdateFeedLoadingState extends FishFarmStates{}
class UpdateFeedSuccessState extends FishFarmStates{}
class UpdateFeedErrorState extends FishFarmStates{
  final String error;
  UpdateFeedErrorState(this.error);
}

class DeleteTankLoadingState extends FishFarmStates{}
class DeleteTankSuccessState extends FishFarmStates{}
class DeleteTankErrorState extends FishFarmStates{
  final String error;
  DeleteTankErrorState(this.error);
}


class EditMortalityDataLoadingState extends FishFarmStates{}
class EditMortalityDataSuccessState extends FishFarmStates{}
class EditMortalityDataErrorState extends FishFarmStates{
  final String error;
  EditMortalityDataErrorState(this.error);
}

class EditFeedDataLoadingState extends FishFarmStates{}
class EditFeedDataSuccessState extends FishFarmStates{}
class EditFeedDataErrorState extends FishFarmStates{
  final String error;
  EditFeedDataErrorState(this.error);
}
class GetIdDailyMortalityLoadingState extends FishFarmStates{}
class GetIdDailyMortalitySuccessState extends FishFarmStates{}
class GetIdDailyMortalityErrorState extends FishFarmStates{
  final String error;
  GetIdDailyMortalityErrorState(this.error);
}
class GetIdDailyFeedLoadingState extends FishFarmStates{}
class GetIdDailyFeedSuccessState extends FishFarmStates{}
class GetIdDailyFeedErrorState extends FishFarmStates{
  final String error;
  GetIdDailyFeedErrorState(this.error);
}

class GetAllFeedLoadingState extends FishFarmStates{}
class GetAllFeedSuccessState extends FishFarmStates{}
class GetAllFeedErrorState extends FishFarmStates{
  final String error;
  GetAllFeedErrorState(this.error);
}