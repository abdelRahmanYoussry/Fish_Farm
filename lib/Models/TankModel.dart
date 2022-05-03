class TankModel{
  late String ?name;
  late double? weight;
  late int ?psc;
  late int ?totalMortality;
  late int ?totalFeed;
  late int ?remaining;
  late double ?avgPsc;
  //make a comment
  TankModel({
    this.name,
    this.weight,
    this.psc,
    this.totalFeed,
    this.totalMortality,
    this.avgPsc,
    this.remaining
    //make a comment
  });
  TankModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    weight=json['weight'];
    psc=json['psc'];
    totalMortality=json['totalMortality'];
    totalFeed=json['totalFeed'] ;
    avgPsc=json['avgPsc'];
    remaining=json['remaining'];
    //make a comment

  }
  Map<String,dynamic>toMap() {
    return{
      'name':name,
      'weight':weight,
      'psc':psc,
      'totalMortality':totalMortality,
      'totalFeed':totalFeed,
      'avgPsc':avgPsc,
      'remaining':remaining,

    };

  }
}