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
class GalleryListCustomerMoreLoading extends GalleryStates{}
class GalleryListCustomerMoreSuccess extends GalleryStates{}
class GalleryListCustomerMoreError extends GalleryStates{
  final error;
  GalleryListCustomerMoreError(this.error);
}

class GalleryDeleteCustomerLoading extends GalleryStates{}
class GalleryDeleteCustomerSuccess extends GalleryStates{}
class GalleryDeleteCustomerError extends GalleryStates{
  final error;
  GalleryDeleteCustomerError(this.error);
}
class GalleryUpdateCustomerLoading extends GalleryStates{}
class GalleryUpdateCustomerSuccess extends GalleryStates{}
class GalleryUpdateCustomerError extends GalleryStates{
  final error;
  GalleryUpdateCustomerError(this.error);
}

class GalleryListProductLoading extends GalleryStates{}
class GalleryListProductSuccess extends GalleryStates{}
class GalleryListProductError extends GalleryStates{
  final error;
  GalleryListProductError(this.error);
}
class GalleryListProductAgainLoading extends GalleryStates{}
class GalleryListProductAgainSuccess extends GalleryStates{}
class GalleryListProductAgainError extends GalleryStates{
  final error;
  GalleryListProductAgainError(this.error);
}
class GalleryListProductMoreLoading extends GalleryStates{}
class GalleryListProductMoreSuccess extends GalleryStates{}
class GalleryListProductMoreError extends GalleryStates{
  final error;
  GalleryListProductMoreError(this.error);
}
class GalleryCreateProductLoading extends GalleryStates{}
class GalleryCreateProductSuccess extends GalleryStates{}
class GalleryCreateProductError extends GalleryStates{
  final error;
  GalleryCreateProductError(this.error);
}
class GalleryDeleteProductLoading extends GalleryStates{}
class GalleryDeleteProductSuccess extends GalleryStates{}
class GalleryDeleteProductError extends GalleryStates{
  final error;
  GalleryDeleteProductError(this.error);
}
class GalleryUpdateProductLoading extends GalleryStates{}
class GalleryUpdateProductSuccess extends GalleryStates{}
class GalleryUpdateProductError extends GalleryStates{
  final error;
  GalleryUpdateProductError(this.error);
}
class GalleryListUserLoading extends GalleryStates{}
class GalleryListUserSuccess extends GalleryStates{}
class GalleryListUserError extends GalleryStates{
  final error;
  GalleryListUserError(this.error);
}
class GalleryListUserMoreLoading extends GalleryStates{}
class GalleryListUserMoreSuccess extends GalleryStates{}
class GalleryListUserMoreError extends GalleryStates{
  final error;
  GalleryListUserMoreError(this.error);
}
class GalleryCreateUserLoading extends GalleryStates{}
class GalleryCreateUserSuccess extends GalleryStates{}
class GalleryCreateUserError extends GalleryStates{
  final error;
  GalleryCreateUserError(this.error);
}
class GalleryUpdateUserLoading extends GalleryStates{}
class GalleryUpdateUserSuccess extends GalleryStates{}
class GalleryUpdateUserError extends GalleryStates{
  final error;
  GalleryUpdateUserError(this.error);
}
class GalleryDeleteUserLoading extends GalleryStates{}
class GalleryDeleteUserSuccess extends GalleryStates{}
class GalleryDeleteUserError extends GalleryStates{
  final error;
  GalleryDeleteUserError(this.error);
}
class GalleryListDepartmentLoading extends GalleryStates{}
class GalleryListDepartmentSuccess extends GalleryStates{}
class GalleryListDepartmentError extends GalleryStates{
  final error;
  GalleryListDepartmentError(this.error);
}
class GalleryListDepartmentMoreLoading extends GalleryStates{}
class GalleryListDepartmentMoreSuccess extends GalleryStates{}
class GalleryListDepartmentMoreError extends GalleryStates{
  final error;
  GalleryListDepartmentMoreError(this.error);
}

class GalleryListTaskLoading extends GalleryStates{}
class GalleryListTaskSuccess extends GalleryStates{}
class GalleryListTaskError extends GalleryStates{
  final error;
  GalleryListTaskError(this.error);
}
class GalleryListTaskMoreLoading extends GalleryStates{}
class GalleryListTaskMoreSuccess extends GalleryStates{}
class GalleryListTaskMoreError extends GalleryStates{
  final error;
  GalleryListTaskMoreError(this.error);
}

class GalleryListInVoiceMoreLoading extends GalleryStates{}
class GalleryListInVoiceMoreSuccess extends GalleryStates{}
class GalleryListInVoiceMoreError extends GalleryStates{
  final error;
  GalleryListInVoiceMoreError(this.error);
}
class GalleryCreateDepartmentLoading extends GalleryStates{}
class GalleryCreateDepartmentSuccess extends GalleryStates{}
class GalleryCreateDepartmentError extends GalleryStates{
  final error;
  GalleryCreateDepartmentError(this.error);
}
class GalleryUpdateDepartmentLoading extends GalleryStates{}
class GalleryUpdateDepartmentSuccess extends GalleryStates{}
class GalleryUpdateDepartmentError extends GalleryStates{
  final error;
  GalleryUpdateDepartmentError(this.error);
}
class GalleryDeleteDepartmentLoading extends GalleryStates{}
class GalleryDeleteDepartmentSuccess extends GalleryStates{}
class GalleryDeleteDepartmentError extends GalleryStates{
  final error;
  GalleryDeleteDepartmentError(this.error);
}
class GalleryListTypeLoading extends GalleryStates{}
class GalleryListTypeSuccess extends GalleryStates{}
class GalleryListTypeError extends GalleryStates{
  final error;
  GalleryListTypeError(this.error);
}
class GalleryCreateTypeLoading extends GalleryStates{}
class GalleryCreateTypeSuccess extends GalleryStates{}
class GalleryCreateTypeError extends GalleryStates{
  final error;
  GalleryCreateTypeError(this.error);
}
class GalleryUpdateTypeLoading extends GalleryStates{}
class GalleryUpdateTypeSuccess extends GalleryStates{}
class GalleryUpdateTypeError extends GalleryStates{
  final error;
  GalleryUpdateTypeError(this.error);
}
class GalleryDeleteTypeLoading extends GalleryStates{}
class GalleryDeleteTypeSuccess extends GalleryStates{}
class GalleryDeleteTypeError extends GalleryStates{
  final error;
  GalleryDeleteTypeError(this.error);
}

class GallerySearchTypeLoading extends GalleryStates{}
class GallerySearchTypeSuccess extends GalleryStates{}
class GallerySearchTypeError extends GalleryStates{
  final error;
  GallerySearchTypeError(this.error);
}

class GallerySearchDepartmentLoading extends GalleryStates{}
class GallerySearchDepartmentSuccess extends GalleryStates{}
class GallerySearchDepartmentError extends GalleryStates{
  final error;
  GallerySearchDepartmentError(this.error);
}
class GallerySearchCustomerLoading extends GalleryStates{}
class GallerySearchCustomerSuccess extends GalleryStates{}
class GallerySearchCustomerError extends GalleryStates{
  final error;
  GallerySearchCustomerError(this.error);
}
class GallerySearchUserLoading extends GalleryStates{}
class GallerySearchUserSuccess extends GalleryStates{}
class GallerySearchUserError extends GalleryStates{
  final error;
  GallerySearchUserError(this.error);
}
class GallerySearchProductLoading extends GalleryStates{}
class GallerySearchProductSuccess extends GalleryStates{}
class GallerySearchProductError extends GalleryStates{
  final error;
  GallerySearchProductError(this.error);
}

class GalleryUploadImageLoading extends GalleryStates{}
class GalleryUploadImageSuccess extends GalleryStates{}
class GalleryUploadImageError extends GalleryStates{
  final error;
  GalleryUploadImageError(this.error);
}
class GalleryUploadImageUserLoading extends GalleryStates{}
class GalleryUploadImageUserSuccess extends GalleryStates{}
class GalleryUploadImageUserError extends GalleryStates{
  final error;
  GalleryUploadImageUserError(this.error);
}

class GalleryListInVoiceLoading extends GalleryStates{}
class GalleryListInVoiceSuccess extends GalleryStates{}
class GalleryListInVoiceError extends GalleryStates{
  final error;
  GalleryListInVoiceError(this.error);
}
class GalleryCreateInVoiceLoading extends GalleryStates{}
class GalleryCreateInVoiceSuccess extends GalleryStates{}
class GalleryCreateInVoiceError extends GalleryStates{
  final error;
  GalleryCreateInVoiceError(this.error);
}
class GalleryListFillInVoiceLoading extends GalleryStates{}
class GalleryListFillInVoiceSuccess extends GalleryStates{}
class GalleryListFillInVoiceError extends GalleryStates{
  final error;
  GalleryListFillInVoiceError(this.error);
}
class GalleryCreateFillInVoiceLoading extends GalleryStates{}
class GalleryCreateFillInVoiceSuccess extends GalleryStates{}
class GalleryCreateFillInVoiceError extends GalleryStates{
  final error;
  GalleryCreateFillInVoiceError(this.error);
}
class GalleryPostFillInVoiceLoading extends GalleryStates{}
class GalleryPostFillInVoiceSuccess extends GalleryStates{}
class GalleryPostFillInVoiceError extends GalleryStates{
  final error;
  GalleryPostFillInVoiceError(this.error);
}
class GalleryUpdateInVoiceLoading extends GalleryStates{}
class GalleryUpdateInVoiceSuccess extends GalleryStates{}
class GalleryUpdateInVoiceError extends GalleryStates{
  final error;
  GalleryUpdateInVoiceError(this.error);
}
class GalleryListCalculationLoading extends GalleryStates{}
class GalleryListCalculationSuccess extends GalleryStates{}
class GalleryListCalculationError extends GalleryStates{
  final error;
  GalleryListCalculationError(this.error);
}
class GalleryCreateCalculationLoading extends GalleryStates{}
class GalleryCreateCalculationSuccess extends GalleryStates{}
class GalleryCreateCalculationError extends GalleryStates{
  final error;
  GalleryCreateCalculationError(this.error);
}
class GalleryUpdateCalculationLoading extends GalleryStates{}
class GalleryUpdateCalculationSuccess extends GalleryStates{}
class GalleryUpdateCalculationError extends GalleryStates{
  final error;
  GalleryUpdateCalculationError(this.error);
}
class GalleryDeleteCalculationLoading extends GalleryStates{}
class GalleryDeleteCalculationSuccess extends GalleryStates{}
class GalleryDeleteCalculationError extends GalleryStates{
  final error;
  GalleryDeleteCalculationError(this.error);
}

class GalleryMenuBar extends GalleryStates{}
class GalleryMenuAvailableBar extends GalleryStates{}
class AppChangeBottomSheetState extends GalleryStates{}
class AppChangeBottomSheetStatee extends GalleryStates{}
class AppChangeBottomSheetStateee extends GalleryStates{}
class ImageLoadingState extends GalleryStates{}
class ImageLoadingStateUser extends GalleryStates{}
class ImageLoadingErrorState extends GalleryStates{}




