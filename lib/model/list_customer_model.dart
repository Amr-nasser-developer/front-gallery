class ListCustomer{
  Customer? customer;
  ListCustomer.fromJson(Map<String, dynamic>json){
    customer = Customer.fromJson(json['customers']);
  }
}

class Customer{
  int? currentPage;
  List<DataModel> data = [];

  Customer.fromJson(Map<String, dynamic>json){
    currentPage = json['current_page'];
    json['data'].forEach((element){
      data.add(DataModel.fromJson(element));
    });
  }
}

class DataModel{
  int? id;
  String? phone;
  Name? name;
  DataModel.fromJson(Map<String, dynamic>json){
    id = json['id'];
    phone = json['phone'];
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