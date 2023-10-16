class DeliveryUser {
  late String uid = "",
      name = "",
      email = "",
      password = "",
      imgUrl = "",
      birth = "",
      phoneNumber = "",
      gender = "";

  Map<String, dynamic> map = {'home': '', 'company': ''};
  late Address ads = Address.fromJson(map);

  DeliveryUser.fromJson(Map<String, dynamic> json)
      : uid = json['uid'] ?? "",
        name = json['name'] ?? "",
        email = json['email'] ?? "",
        password = json['password'] ?? "",
        imgUrl = json['imgUrl'] ?? "",
        birth = json['birth'] ?? "",
        phoneNumber = json['phoneNumber'] ?? "",
        gender = json['gender'] ?? "",
        ads =
            Address.fromJson(Map<String, dynamic>.from(json['address'] as Map));

  DeliveryUser(String uid, String name, String birth, String email,
      String password, String gender, String phoneNumber, String imgUrl) {
    this.uid = uid;
    this.name = name;
    this.birth = birth;
    this.email = email;
    this.password = password;
    this.gender = gender;
    this.phoneNumber = phoneNumber;
    this.imgUrl = imgUrl;
  }
}

class Address {
  late String company = "", home = "";

  Address.fromJson(Map<String, dynamic> json)
      : company = json['company'] ?? "",
        home = json['home'] ?? "";
}
