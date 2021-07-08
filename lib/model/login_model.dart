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
  List<Role> roles = [];
  UserModel.fromJson(Map<String, dynamic> json){
    name = Name.fromJson(json['name']);
    email = json['email'];
    id = json['id'];
    json['roles'].forEach((element){
      roles.add(Role.fromJson(element));
    });
  }
}
class Role{
  String? nameRole;
  String? guard_name;
  Role.fromJson(Map<String, dynamic> json){
    nameRole = json['name'];
    guard_name = json['guard_name'];
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

