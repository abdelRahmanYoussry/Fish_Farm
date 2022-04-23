class FishFarmUserModel{
  late String ?name;
  late String? email;
  late String ?phone;
  late String? uid;
  late String ?image;
  bool? isAdmin;

  FishFarmUserModel({
    this.name,
    this.email,
    this.phone,
    this.uid,
    this.image,
    this.isAdmin,
  });

  FishFarmUserModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    uid=json['uid'];
    image=json['image'];
    isAdmin=json['isAdmin'];
  }

  Map<String,dynamic>toMap() {
    return{
      'name':name,
      'email':email,
      'phone':phone,
      'uid':uid,
      'image':image,
      'isAdmin':isAdmin,
    };

  }
}