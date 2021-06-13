class RegisterModel{
  String? message;
  UserModel? user;

  RegisterModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    user = UserModel.fromJson(json['user']);
  }
}
class UserModel{
  Name? name;
  String? email;
  int? id;
  UserModel.fromJson(Map<String, dynamic> json){
    email = json['token'];
    id = json['id'];
    name = Name.fromJson(json['name']);
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

