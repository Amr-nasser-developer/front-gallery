import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/layout/cubit/state.dart';
import 'package:gallary/model/creat_customer_model.dart';
import 'package:gallary/model/login_model.dart';
import 'package:gallary/shared/network/remote/dio_helper.dart';

class GalleryCubit extends Cubit<GalleryStates> {
  GalleryCubit() : super(GalleryIntial());
  static GalleryCubit get(context) => BlocProvider.of(context);
  String? message = '';
  postApi({enName, arName, email, password, passwordConfirmation, }) {
    emit(GalleryRegisterLoading());
    DioHelper.postData(url: 'register', data: {
      'name': {
        'en': enName,
        'ar': arName
      },
      'role' : 'admin',
      'email': '$email',
      'password': '$password',
      'password_confirmation': '$passwordConfirmation',
      'department_id': '5',
    }).then((value) {
      print(value);
      emit(GalleryRegisterSuccess());
    }).catchError((e) {
      print(e.toString());
      emit(GalleryRegisterError(e.toString()));
    });
  }

  LoginModel? loginModel;
  postLogin({email , password}) {
    emit(GalleryLoginLoading());
    DioHelper.postData(url: 'login', data: {
      'email': '$email',
      'password': '$password',
    }).then((value) {
      print(value);
      loginModel = LoginModel.fromJson(value.data);
      emit(GalleryLoginSuccess(loginModel!));
    }).catchError((e) {
      print(e.toString());
      emit(GalleryLoginError(e));
    });
  }

  CreateCustomer? _createCustomer;
  void createCustomer({enName, arName, phone}){
    emit(GalleryCreateCustomerSuccess());
    DioHelper.postData(
        url: 'dashboard/v1/customers',
        data: {
          'name': {
            'en': enName,
            'ar': arName
          },
          'phone' : phone,
        },
    ).then((value){
      _createCustomer = CreateCustomer.fromJson(value.data);
      print(_createCustomer);
      emit(GalleryCreateCustomerSuccess());
    }).catchError((e){
      print(e.toString());
    });
  }

  List<dynamic> customer = [];
   getCustomer(){
     emit(GalleryGetCustomerLoading());
    DioHelper.getData(
        url: 'dashboard/v1/customers',
    ).then((value){
      customer = value.data['customers']['data'];
      emit(GalleryGetCustomerSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryGetCustomerError(e.toString()));
    });
  }

  deleteCustomer({id}){
    emit(GalleryDeleteCustomerLoading());
    DioHelper.postData(
      data: {
        'id' : id
      },
        url: 'dashboard/v1/customers/$id/delete',
    ).then((value){
      emit(GalleryDeleteCustomerSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryDeleteCustomerError(e.toString()));
    });
  }

  updateCustomer({enName, arName, phone, id}){
    emit(GalleryUpdateCustomerLoading());
    DioHelper.postData(
      data: {
        'name': {
          'en': enName,
          'ar': arName,

        },
        'phone' : phone
      },
      url: 'dashboard/v1/customers/$id/update',
    ).then((value){
      emit(GalleryUpdateCustomerSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryUpdateCustomerError(e.toString().characters.string));
    });
  }



  String dropdownValue = 'Admin';
  void changeMenu(String? newValue){
    dropdownValue = newValue!;
    emit(GalleryMenuBar());
  }

  bool isPassword = true;
  void showPassword(){
    isPassword = !isPassword;
    emit(GalleryLoginShowPassword());
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    @required bool? isShow,
    @required IconData? icon,
  }) {
    isBottomSheetShown = isShow!;
    fabIcon = icon!;
    emit(AppChangeBottomSheetState());
  }

  bool isBottomSheetShownn = false;
  IconData fabIconn = Icons.edit;

  void changeBottomSheetStatee({
    @required bool? isShow,
    @required IconData? icon,
  }) {
    isBottomSheetShownn = isShow!;
    fabIconn = icon!;
    emit(AppChangeBottomSheetStatee());
  }

  bool isBottomSheetShownnn = false;
  IconData fabIconnn = Icons.edit;

  void changeBottomSheetStateee({
    @required bool? isShow,
    @required IconData? icon,
  }) {
    isBottomSheetShownnn = isShow!;
    fabIconnn = icon!;
    emit(AppChangeBottomSheetStateee());
  }

  List<dynamic> viewProduct = [];
  listProduct(){
    emit(GalleryListProductLoading());
    DioHelper.getData(
      url: 'dashboard/v1/products',
    ).then((value){
      viewProduct = value.data['product']['data'];
      print(viewProduct);
      emit(GalleryListProductSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryListProductError(e.toString()));
    });
  }
  createProduct({ar , en , cost, availabilty, thumb }){
    emit(GalleryCreateProductLoading());
    DioHelper.postData(
      data: {
        'name' : {
          'ar' : ar,
          'en' : en,
        },
        'cost' : cost,
        'availabilty': availabilty,
        'thumb' : thumb
      },
      url: 'dashboard/v1/products',
    ).then((value){
      emit(GalleryCreateProductSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryCreateProductError(e.toString()));
    });
  }
  updateProduct({ar , en , cost, availabilty, thumb,id }){
    emit(GalleryUpdateProductLoading());
    DioHelper.postData(
      data: {
        'name' : {
          "'ar'" : ar,
          "'en'" : en,
        },
        'cost' : cost,
        'availabilty': availabilty,
        'thumb' : thumb
      },
      url: 'dashboard/v1/products/$id/update',
    ).then((value){
      emit(GalleryUpdateProductSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryUpdateProductError(e.toString()));
    });
  }
  deleteProduct({id}){
    emit(GalleryDeleteProductLoading());
    DioHelper.postData(
      data: {
        'id' : id
      },
      url: 'dashboard/v1/products/$id/delete',
    ).then((value){
      emit(GalleryDeleteProductSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryDeleteProductError(e.toString()));
    });
  }
 String id = '';
  List<dynamic> viewUser = [];
  listUser(){
    emit(GalleryListUserLoading());
    DioHelper.getData(
      url: 'dashboard/v1/user',
    ).then((value){
      viewUser = value.data['users']['data'];
      id = value.data['users']['data']['id'];
      print(viewUser);
      emit(GalleryListUserSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryListUserError(e.toString()));
    });
  }
  updateUser({enName, arName, email, password, passwordConfirmation, role,id,departmentId}){
    emit(GalleryUpdateUserLoading());
    DioHelper.postData(
      data: {
        'name': {
          'en': enName,
          'ar': arName,

        },
        'department_id' : departmentId,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'role': role,
      },
      url: 'dashboard/v1/user/$id/update',
    ).then((value){
      emit(GalleryUpdateUserSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryUpdateUserError(e.toString().characters.string));
    });
  }

  deleteUser({id}){
    emit(GalleryDeleteUserLoading());
    DioHelper.postData(
      data: {
        'id' : id
      },
      url: 'dashboard/v1/user/$id/delete',
    ).then((value){
      emit(GalleryDeleteUserSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryDeleteUserError(e.toString()));
    });
  }

  List<dynamic> viewDepartment = [];
  listDepartment(){
    emit(GalleryListDepartmentLoading());
    DioHelper.getData(
      url: 'dashboard/v1/departments',
    ).then((value){
      viewDepartment = value.data['data']['data'];
      print(viewDepartment);
      emit(GalleryListDepartmentSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryListDepartmentError(e.toString()));
    });
  }

  deleteDepartment({id}){
    emit(GalleryDeleteDepartmentLoading());
    DioHelper.postData(
      data: {
        'id' : id
      },
      url: 'dashboard/v1/departments/$id/delete',
    ).then((value){
      emit(GalleryDeleteDepartmentSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryDeleteDepartmentError(e.toString()));
    });
  }

  createDepartment({ar , en }){
    emit(GalleryCreateDepartmentLoading());
    DioHelper.postData(
      data: {
        'name' : {
          'ar' : ar,
          'en' : en,
        },
      },
      url: 'dashboard/v1/departments',
    ).then((value){
      emit(GalleryCreateDepartmentSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryCreateDepartmentError(e.toString()));
    });
  }
  updateDepartment({enName, arName,id}){
    emit(GalleryUpdateDepartmentLoading());
    DioHelper.postData(
      data: {
        'name' : {
          'ar' : arName,
          'en' : enName,
        },
      },
      url: 'dashboard/v1/departments/$id/update',
    ).then((value){
      emit(GalleryUpdateDepartmentSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryUpdateDepartmentError(e.toString()));
    });
  }

  List<dynamic> searchD = [];
  var searchDepartmentController = TextEditingController();
  searchDepartment( search){
    emit(GallerySearchDepartmentLoading());
    DioHelper.getData(
        url: 'dashboard/datatable/department?q=$search',
        query: {
          'q' : '$search'
        }
    ).then((value){
      searchD = value.data['departments']['data'];
      emit(GallerySearchDepartmentSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GallerySearchDepartmentError(e));
    });
  }
  List<dynamic> searchC = [];
  var searchCustomerController = TextEditingController();
  searchCustomer(search){
    emit(GallerySearchCustomerLoading());
    DioHelper.getData(
        url: 'dashboard/datatable/customers?q=$search',
        query: {
          'q' : '$search'
        }
    ).then((value){
      searchC = value.data['customers']['data'];
      emit(GallerySearchCustomerSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GallerySearchCustomerError(e));
    });
  }
  List<dynamic> searchY = [];
  var searchUserController = TextEditingController();
  searchUser(search){
    emit(GallerySearchUserLoading());
    DioHelper.getData(
        url: 'dashboard/datatable/users?q=$search',
        query: {
          'q' : '$search'
        }
    ).then((value){
      searchY = value.data['users']['data'];
      emit(GallerySearchUserSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GallerySearchUserError(e));
    });
  }
  List<dynamic> searchP = [];
  var searchProductController = TextEditingController();
  searchProduct(search){
    emit(GallerySearchProductLoading());
    DioHelper.getData(
        url: 'dashboard/datatable/products?q=$search',
        query: {
          'q' : '$search'
        }
    ).then((value){
      searchP = value.data['products']['data'];
      emit(GallerySearchProductSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GallerySearchProductError(e));
    });
  }

}
