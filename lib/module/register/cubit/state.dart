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
class GalleryMenuBar extends GalleryStates{}

