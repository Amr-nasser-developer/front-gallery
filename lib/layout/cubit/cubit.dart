import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/layout/cubit/state.dart';
import 'package:gallary/model/creat_customer_model.dart';
import 'package:gallary/model/list_customer_model.dart';
import 'package:gallary/model/login_model.dart';
import 'package:gallary/model/register_model.dart';
import 'package:gallary/shared/network/remote/dio_helper.dart';

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
      token: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMjEuMjUzLjYwOjgzXC9hcGlcL2xvZ2luIiwiaWF0IjoxNjIzNjE0NDIwLCJuYmYiOjE2MjM2MTQ0MjAsImp0aSI6ImNwQXNRS2d0SFBvZHVqZXAiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.jJ9q9sVTwym0o4kjD6yaMgpnlByaiwnn7KhzOSxnqFo'
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
        token: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMjEuMjUzLjYwOjgzXC9hcGlcL2xvZ2luIiwiaWF0IjoxNjIzNjE0NDIwLCJuYmYiOjE2MjM2MTQ0MjAsImp0aSI6ImNwQXNRS2d0SFBvZHVqZXAiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.jJ9q9sVTwym0o4kjD6yaMgpnlByaiwnn7KhzOSxnqFo'
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
        token: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMjEuMjUzLjYwOjgzXC9hcGlcL2xvZ2luIiwiaWF0IjoxNjIzNjE0NDIwLCJuYmYiOjE2MjM2MTQ0MjAsImp0aSI6ImNwQXNRS2d0SFBvZHVqZXAiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.jJ9q9sVTwym0o4kjD6yaMgpnlByaiwnn7KhzOSxnqFo'
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
}
