import 'package:flutter/cupertino.dart';
import 'package:gallary/model/login_model.dart';

abstract class GalleryStates{}
class GalleryIntial extends GalleryStates{}
class GalleryRegisterLoading extends GalleryStates{}
class GalleryRegisterSuccess extends GalleryStates{}
class GalleryRegisterError extends GalleryStates{
  final error;
  GalleryRegisterError(this.error);
}

class GalleryLoginLoading extends GalleryStates{}
class GalleryLoginSuccess extends GalleryStates{
  final LoginModel loginModel;
  GalleryLoginSuccess(this.loginModel);
}

class GalleryLoginShowPassword extends GalleryStates{}
class GalleryLoginError extends GalleryStates{
  final error;
  GalleryLoginError(this.error);
}
class GalleryCreateCustomerLoading extends GalleryStates{}
class GalleryCreateCustomerSuccess extends GalleryStates{}
class GalleryCreateCustomerError extends GalleryStates{
  final error;
  GalleryCreateCustomerError(this.error);
}
class GalleryGetCustomerLoading extends GalleryStates{}
class GalleryGetCustomerSuccess extends GalleryStates{}
class GalleryGetCustomerError extends GalleryStates{
  final error;
  GalleryGetCustomerError(this.error);
}

class GalleryDeleteCustomerLoading extends GalleryStates{}
class GalleryDeleteCustomerSuccess extends GalleryStates{}
class GalleryDeleteCustomerError extends GalleryStates{
  final error;
  GalleryDeleteCustomerError(this.error);
}

class GalleryMenuBar extends GalleryStates{}
class AppChangeBottomSheetState extends GalleryStates{}

