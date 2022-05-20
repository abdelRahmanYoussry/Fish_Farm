class TanksFeedModel{
  late String ?tankName;
  late double ?feedWeight;
  late num ?totalFeed;
  late int ?totalRemainingFeed;
  late String ?userName;
  late String ?feedSize;
  late String ?feedDate;
  late String ?dateTime;
  //make a comment
  TanksFeedModel({
    this.tankName,
    this.userName,
    this.feedWeight,
    this.feedDate,
    this.totalFeed,
    this.dateTime,
    this.feedSize,
    this.totalRemainingFeed
    //make a comment
  });
  TanksFeedModel.fromJson(Map<String,dynamic>json){
    tankName=json['tankName'];
    userName=json['userName'];
    feedWeight=json['feedWeight'];
    totalFeed=json['totalFeed'];
    feedDate=json['feedDate'];
    dateTime=json['dateTime'];
    totalRemainingFeed=json['totalRemainingFeed'];
    feedSize=json['feedSize'];
    //make a comment

  }
  Map<String,dynamic>toMap() {
    return{
      'tankName':tankName,
      'userName':userName,
      'feedWeight':feedWeight,
      'totalFeed':totalFeed,
      'feedDate':feedDate,
      'dateTime':dateTime,
      'totalRemainingFeed':totalRemainingFeed,
      'feedSize':feedSize,

    };

  }
}