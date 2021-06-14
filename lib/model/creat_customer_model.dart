class CreateCustomer{
  bool? success;
  String? message;
  CreateCustomer.fromJson(Map<String, dynamic>json){
    success = json['success'];
    message = json['message'];
  }
}