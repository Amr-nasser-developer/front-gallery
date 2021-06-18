import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/layout/cubit/state.dart';
import 'package:gallary/model/creat_customer_model.dart';
import 'package:gallary/model/login_model.dart';
import 'package:gallary/model/register_model.dart';
import 'package:gallary/shared/network/remote/dio_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:convert';

class GalleryCubit extends Cubit<GalleryStates> {
  GalleryCubit() : super(GalleryIntial());

  RegisterModel? registerModel;
  static GalleryCubit get(context) => BlocProvider.of(context);
  postApi({enName, arName, email, password, passwordConfirmation, }) {
    emit(GalleryRegisterLoading());
    DioHelper.postData(url: 'register', data: {
      'name': {
        'en': enName,
        'ar': arName
      },
      'email': '$email',
      'password': '$password',
      'password_confirmation': '$passwordConfirmation',
      // 'role': '$role',
      'department_id': '2'
    }).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      print(value);
      emit(GalleryRegisterSuccess());
    }).catchError((e) {
      print(e.toString());
      emit(GalleryRegisterError(e));
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

  // ListCustomer? listCustomer;
  List<dynamic> customer = [];
   getCustomer(){
     emit(GalleryGetCustomerLoading());
    DioHelper.getData(
        url: 'dashboard/v1/customers',
    ).then((value){
      // listCustomer = ListCustomer.fromJson(value.data);
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
          "'ar'" : ar,
          "'en'" : en,
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

}
