class DailyModel{
  late String ?tankName;
  late String ?day;
  late int ?totalMortality;
  late int ?totalFeed;
  late int ?pcsRemaining;
  //make a comment
  DailyModel({
    this.tankName,
    this.totalMortality,
    this.pcsRemaining,
    this.day,
    this.totalFeed,
    //make a comment
  });
  DailyModel.fromJson(Map<String,dynamic>json){
    tankName=json['tankName'];
    totalMortality=json['totalMortality'];
    pcsRemaining=json['pcsRemaining'];
    day=json['day'];
    totalFeed=json['totalFeed'];
    //make a comment

  }
  Map<String,dynamic>toMap() {
    return{
      'tankName':tankName,
      'day':day,
      'totalMortality':totalMortality,
      'totalFeed':totalFeed,
      'pcsRemaining':pcsRemaining,
    };

  }
}