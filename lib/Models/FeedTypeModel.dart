class FeedTypeModel{
  late String ?feedName;
  late num ?totalPurchasedFeed;
  late num ?remainingFeed;
  late String ?purchasedDate;
  FeedTypeModel({
    this.feedName,
    this.purchasedDate,
    this.totalPurchasedFeed,
    this.remainingFeed
  });
  FeedTypeModel.fromJson(Map<String,dynamic>json){
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