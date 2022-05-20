class DailyModel{
  late String ?tankName;
  late String ?day;
  late String ?feedType;
  late int ?dailyMortality;
  late num ?dailyFeed;
  late int ?remainingPsc;
  //make a comment
  DailyModel({
    this.tankName,
    this.dailyMortality,
    this.remainingPsc,
    this.day,
    this.dailyFeed,
    this.feedType
    //make a comment
  });
  DailyModel.fromJson(Map<String,dynamic>json){
    tankName=json['tankName'];
    dailyMortality=json['dailyMortality'];
    remainingPsc=json['remainingPsc'];
    day=json['day'];
    dailyFeed=json['dailyFeed'];
    feedType=json['feedType'];
    //make a comment

  }
  Map<String,dynamic>toMap() {
    return{
      'tankName':tankName,
      'day':day,
      'dailyMortality':dailyMortality,
      'dailyFeed':dailyFeed,
      'remainingPsc':remainingPsc,
      'feedType':feedType
    };

  }
}