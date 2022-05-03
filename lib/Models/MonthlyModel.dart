class MonthlyModel{
  late String ?tankName;
  late String ?month;
  late int ?totalMortality;
  late int ?totalFeed;
  late int ?pcsRemaining;
  //make a comment
  MonthlyModel({
    this.tankName,
    this.totalMortality,
    this.pcsRemaining,
    this.month,
    this.totalFeed,
    //make a comment
  });
  MonthlyModel.fromJson(Map<String,dynamic>json){
    tankName=json['tankName'];
    totalMortality=json['totalMortality'];
    pcsRemaining=json['pcsRemaining'];
    month=json['month'];
    totalFeed=json['totalFeed'];
    //make a comment

  }
  Map<String,dynamic>toMap() {
    return{
      'tankName':tankName,
      'month':month,
      'totalMortality':totalMortality,
      'totalFeed':totalFeed,
      'pcsRemaining':pcsRemaining,
    };

  }
}