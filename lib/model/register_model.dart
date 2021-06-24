class RegisterModel{
  String? message;
  Error? errors;
  UserModel? user;
  RegisterModel.fromJson(Map<String, dynamic> json){
    errors = Error.fromJson(json['errors']) ;
    message = json['message'];
    user = UserModel.fromJson(json['user']);
  }
}
class Error{
  List<String>? email = [];
  List<String>? password = [];
  Error.fromJson(Map<String, dynamic>json){
    email = ["The email has already been taken."];
    password = ["The password confirmation does not match."];
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

