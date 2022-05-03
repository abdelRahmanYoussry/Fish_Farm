class CreateFeedModel{
  late String ?feedName;
  late double ?totalPurchasedFeed;
  late double ?remainingFeed;
  late String ?purchasedDate;
  CreateFeedModel({
    this.feedName,
    this.purchasedDate,
    this.totalPurchasedFeed,
    this.remainingFeed
  });
  CreateFeedModel.fromJson(Map<String,dynamic>json){
    feedName=json['feedName'];
    totalPurchasedFeed=json['totalPurchasedFeed'];
    purchasedDate=json['purchasedDate'];
    remainingFeed=json['remainingFeed'];
  }
  Map<String,dynamic>toMap() {
    return{
      'feedName':feedName,
      'totalPurchasedFeed':totalPurchasedFeed,
      'purchasedDate':purchasedDate,
      'remainingFeed':remainingFeed,
    };

  }
}