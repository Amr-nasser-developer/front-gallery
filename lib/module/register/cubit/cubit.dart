import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/model/login_model.dart';
import 'package:gallary/model/register_model.dart';
import 'package:gallary/module/register/cubit/state.dart';
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
}
