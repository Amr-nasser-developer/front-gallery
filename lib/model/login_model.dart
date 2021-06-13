class LoginModel{
  String? message;
  Data? data;

  LoginModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    data = Data.fromJson(json['data']);
  }
}
class Data{
  UserModel? user;
  String? token;
  Data.fromJson(Map<String, dynamic> json){
    token = json['token'];
    user = UserModel.fromJson(json['user']);
  }
}

class UserModel {
  Name? name;
  String? email;
  int? id;

  UserModel.fromJson(Map<String, dynamic> json){
    name = Name.fromJson(json['name']);
    email = json['email'];
    id = json['id'];

  }
}

class Name{
  String? ar;
  String? en;

  Name.fromJson(Map<String, dynamic> json){
    ar = json['ar'];
    en = json['en'];
  }
}

