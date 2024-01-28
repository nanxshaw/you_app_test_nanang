class UserModel {
  String? message;
  Data? data;

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? email;
  String? username;
  String? name;
  String? birthday;
  String? horoscope;
  String? zodiac;
  int? height;
  int? weight;
  List<String>? interests;

  Data(
      {this.email,
      this.username,
      this.name,
      this.birthday,
      this.horoscope,
      this.zodiac,
      this.height,
      this.weight,
      this.interests});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    username = json['username'];
    name = json['name'];
    birthday = json['birthday'];
    horoscope = json['horoscope'];
    zodiac = json['zodiac'];
    height = json['height'];
    weight = json['weight'];
    interests = json['interests'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['username'] = this.username;
    data['name'] = this.name;
    data['birthday'] = this.birthday;
    data['horoscope'] = this.horoscope;
    data['zodiac'] = this.zodiac;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['interests'] = this.interests;
    return data;
  }
}
