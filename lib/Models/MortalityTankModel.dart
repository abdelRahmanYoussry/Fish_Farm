class MortalityTanksModel{
  late String ?tankName;
  late int ?mortalityCount;
  late int ?totalMortality;
  late int ?remaining;
  late String ?userName;
  late String ?mortalityDate;
  late String ?dateTime;
  //make a comment
  MortalityTanksModel({
    this.tankName,
    this.userName,
    this.mortalityCount,
    this.mortalityDate,
    this.totalMortality,
    this.dateTime,
    this.remaining
    //make a comment
  });
  MortalityTanksModel.fromJson(Map<String,dynamic>json){
    tankName=json['tankName'];
    userName=json['userName'];
    mortalityCount=json['mortalityCount'];
    totalMortality=json['totalMortality'];
    mortalityDate=json['mortalityDate'];
    dateTime=json['dateTime'];
    remaining=json['remaining'];
    //make a comment

  }
  Map<String,dynamic>toMap() {
    return{
      'tankName':tankName,
      'userName':userName,
      'mortalityCount':mortalityCount,
      'totalMortality':totalMortality,
      'mortalityDate':mortalityDate,
      'dateTime':dateTime,
      'remaining':remaining,

    };

  }
}