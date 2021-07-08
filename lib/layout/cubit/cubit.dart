import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/layout/cubit/state.dart';
import 'package:gallary/model/creat_customer_model.dart';
import 'package:gallary/model/login_model.dart';
import 'package:gallary/shared/network/remote/dio_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';


class GalleryCubit extends Cubit<GalleryStates> {
  GalleryCubit() : super(GalleryIntial());

  static GalleryCubit get(context) => BlocProvider.of(context);
  String? message = '';


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
      emit(GalleryCreateCustomerSuccess());
    }).catchError((e){
      print(e.toString());
    });
  }
  int currentPageCustomer = 1;
  int totalPageCustomer = 0;
  List<dynamic> customer = [];
  getCustomer({bool CreateCustomerSuccess = false}){
    if(CreateCustomerSuccess == true){
      currentPageCustomer = 1;
    }
     emit(GalleryGetCustomerLoading());
    DioHelper.getData(
        url: 'dashboard/v1/customers',
      query: {
          'page' : currentPageCustomer,
        'limit' : 100
      }
    ).then((value){
      emit(GalleryGetCustomerSuccess());
      customer = value.data['customers']['data'];
      currentPageCustomer++;
      totalPageCustomer = value.data['customers']['last_page'];
    }).catchError((e){
      print(e.toString());
      emit(GalleryGetCustomerError(e.toString()));
    });
  }
  listCustomerMore(){
    emit(GalleryListCustomerMoreLoading());
    DioHelper.getData(
      query: {
        'page' : currentPageCustomer
      },
      url: 'dashboard/v1/customers',
    ).then((value){
      emit(GalleryListCustomerMoreSuccess());
      customer.addAll(value.data['customers']['data']);
      currentPageCustomer+=1;
    }).catchError((e){
      print(e.toString());
      emit(GalleryListCustomerMoreError(e.toString()));
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


  int currentPageTask = 1;
  int totalPageTask = 0;
  List<dynamic> task = [];
  listTask({bool CreateCustomerSuccess = false}){
    if(CreateCustomerSuccess == true){
      currentPageTask = 1;
    }
    emit(GalleryListTaskLoading());
    DioHelper.getData(
        url: 'dashboard/v1/tasks',
        query: {
          'page' : currentPageTask,
          'limit' : 100
        }
    ).then((value){
      emit(GalleryListTaskSuccess());
      task = value.data['tasks']['data'];
      currentPageTask++;
      totalPageTask = value.data['tasks']['last_page'];
    }).catchError((e){
      print(e.toString());
      emit(GalleryListTaskError(e.toString()));
    });
  }
  listTaskMore(){
    emit(GalleryListTaskMoreLoading());
    DioHelper.getData(
      query: {
        'page' : currentPageTask
      },
      url: 'dashboard/v1/tasks',
    ).then((value){
      emit(GalleryListTaskMoreSuccess());
      task.addAll(value.data['tasks']['data']);
      currentPageTask+=1;
    }).catchError((e){
      print(e.toString());
      emit(GalleryListTaskMoreError(e.toString()));
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


  int currentPageProduct = 1;
  int totalPageProduct = 0;
  List<dynamic> viewProduct = [];
  listProduct({bool CreateProductSuccess = false}){
  if(CreateProductSuccess == true){
  currentPageProduct = 1;
  }
     emit(GalleryListProductLoading());
    DioHelper.getData(
      query: {
        'page' : currentPageProduct,
        'limit' : 100
      },
      url: 'dashboard/v1/products',
    ).then((value){
        emit(GalleryListProductSuccess());
        viewProduct = value.data['product']['data'];
        currentPageProduct++;
        totalPageProduct = value.data['product']['last_page'];
    }).catchError((e){
      print(e.toString());
      emit(GalleryListProductError(e.toString()));
    });
  }
  listProductMore(){
    emit(GalleryListProductMoreLoading());
    DioHelper.getData(
      query: {
        'page' : currentPageProduct
      },
      url: 'dashboard/v1/products',
    ).then((value){
      emit(GalleryListProductMoreSuccess());
      viewProduct.addAll(value.data['product']['data']);
      currentPageProduct ++;
    }).catchError((e){
      print(e.toString());
      emit(GalleryListProductMoreError(e.toString()));
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
          'ar' : ar,
          'en' : en,
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
  int currentPageUser = 1;
  int totalPageUser = 0;
  List<dynamic> viewUser = [];
  listUser({bool CreateUserSuccess = false}){
    if(CreateUserSuccess == true){
      currentPageUser = 1;
    }
    emit(GalleryListUserLoading());
    DioHelper.getData(
      query: {
        'page' : currentPageUser,
        'limit' : 100
      },
      url: 'dashboard/v1/user',
    ).then((value){
      viewUser = value.data['users']['data'];
      currentPageUser++;
      totalPageUser =  value.data['users']['last_page'];
      emit(GalleryListUserSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryListUserError(e.toString()));
    });
  }
  listUserMore(){
    emit(GalleryListUserMoreLoading());
    DioHelper.getData(
      query: {
        'page' : currentPageUser
      },
      url: 'dashboard/v1/user',
    ).then((value){
      viewUser.addAll(value.data['users']['data']);
      currentPageUser++;
      emit(GalleryListUserMoreSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryListUserMoreError(e.toString()));
    });
  }
  postApi({enName, arName, email, password, passwordConfirmation, role, avatar, department_id}) {
    emit(GalleryRegisterLoading());
    DioHelper.postData(url: 'dashboard/v1/user', data: {
      'name': {
        'en': enName,
        'ar': arName
      },
      'role' : '$role',
      'email': '$email',
      'password': '$password',
      'password_confirmation': '$passwordConfirmation',
      'department_id': department_id,
      'avatar' : avatar
    }).then((value) {
      print(value);
      emit(GalleryRegisterSuccess());
    }).catchError((e) {
      print(e.toString());
      emit(GalleryRegisterError(e.toString()));
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
        'department_id' : 5,
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

  int currentPageDepartment = 1;
  int totalPageDepartment = 0;
  List<dynamic> viewDepartment = [];
  listDepartment({bool CreateDepartmentSuccess = false}){
    if(CreateDepartmentSuccess == true){
      currentPageDepartment = 1;
    }
    emit(GalleryListDepartmentLoading());
    DioHelper.getData(
      query: {
        'page' : currentPageDepartment,
        'limit' : 100
      },
      url: 'dashboard/v1/departments',
    ).then((value){
      viewDepartment = value.data['data']['data'];
      currentPageDepartment++;
      totalPageDepartment = value.data['data']['last_page'];
      emit(GalleryListDepartmentSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryListDepartmentError(e.toString()));
    });
  }
  listDepartmentMore(){
    emit(GalleryListDepartmentMoreLoading());
    DioHelper.getData(
      query: {
        'page' : currentPageDepartment
      },
      url: 'dashboard/v1/departments',
    ).then((value){
      viewDepartment.addAll(value.data['data']['data']);
      currentPageDepartment++;
      emit(GalleryListDepartmentMoreSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryListDepartmentMoreError(e.toString()));
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

  List<dynamic> viewType = [];
  var viewTypeName ;
  listType(){
    emit(GalleryListTypeLoading());
    DioHelper.getData(
      url: 'dashboard/v1/types',
      query: {
        'limit' : 100
      }
    ).then((value){
      viewType = value.data['types']['data'];
      print(viewType);
      emit(GalleryListTypeSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryListTypeError(e.toString()));
    });
  }
  deleteType({id}){
    emit(GalleryDeleteTypeLoading());
    DioHelper.postData(
      data: {
        'id' : id
      },
      url: 'dashboard/v1/types/$id/delete',
    ).then((value){
      emit(GalleryDeleteTypeSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryDeleteTypeError(e.toString()));
    });
  }
  createType({ar , en }){
    emit(GalleryCreateTypeLoading());
    DioHelper.postData(
      data: {
        'name' : {
          'ar' : ar,
          'en' : en,
        },
      },
      url: 'dashboard/v1/types',
    ).then((value){
      emit(GalleryCreateTypeSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryCreateTypeError(e.toString()));
    });
  }
  updateType({enName, arName,id}){
    emit(GalleryUpdateTypeLoading());
    DioHelper.postData(
      data: {
        'name' : {
          'ar' : arName,
          'en' : enName,
        },
      },
      url: 'dashboard/v1/types/$id/update',
    ).then((value){
      emit(GalleryUpdateTypeSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryUpdateTypeError(e.toString()));
    });
  }

  List<dynamic> viewInVoice = [];
  int currentPageInvoice = 1;
  int currentTotalPageInvoice = 1;
  listInVoice({bool CreateInvoiceSuccess = false}){
    if(CreateInvoiceSuccess == true){
      currentPageInvoice = 1;
    }
    emit(GalleryListInVoiceLoading());
    DioHelper.getData(
      url: 'dashboard/v1/invoices',
      query: {
        'page' : currentPageInvoice,
        'limit' : 100
      }
    ).then((value){
      viewInVoice = value.data['invoices']['data'];
      currentTotalPageInvoice = value.data['invoices']['last_page'];
      currentPageInvoice++;
      print(viewInVoice);
      emit(GalleryListInVoiceSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryListInVoiceError(e.toString()));
    });
  }
  listInvoiceMore(){
    emit(GalleryListInVoiceMoreLoading());
    DioHelper.getData(
      query: {
        'page' : currentPageInvoice
      },
      url: 'dashboard/v1/invoices',
    ).then((value){
      viewInVoice.addAll(value.data['invoices']['data']);
      currentPageInvoice++;
      emit(GalleryListInVoiceMoreSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryListInVoiceMoreError(e.toString()));
    });
  }
  createInVoice({customer_id , item, size, width, high, type_id}){
    emit(GalleryCreateInVoiceLoading());
    DioHelper.postData(
      data: {
       'customer_id' : customer_id,
        'item' :item,
        'size' : size,
        'dimentions' : {
          'dimentions[0]' : width,
          'dimentions[1]' : high,
        },
         // 'dimentions[0]' : width,
         // 'dimentions[1]' : high,
        'type_id' : type_id,
      },
      url: 'dashboard/v1/invoices',
    ).then((value){
      emit(GalleryCreateInVoiceSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryCreateInVoiceError(e.toString()));
    });
  }
  updateInVoice({customer_id , item, size, width, high, type_id,id}){
    emit(GalleryUpdateInVoiceLoading());
    DioHelper.postData(
      data: {
        'customer_id' : customer_id,
        'item' :item,
        'size' : size,
        'dimentions[0]' : width,
        'dimentions[1]' : high,
        'type_id' : type_id,
      },
      url: 'dashboard/v1/invoices/$id/update',
    ).then((value){
      emit(GalleryUpdateInVoiceSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryUpdateInVoiceError(e.toString()));
    });
  }


  List<dynamic>FillInvoice = [];
  var invoiceId ;
  listFillInVoice({inVoiceId}){
    emit(GalleryListFillInVoiceLoading());
    DioHelper.getData(
      url: 'dashboard/v1/invoice/details/$inVoiceId',
    ).then((value){
      FillInvoice = value.data['invoice_details']['data'];
      print(FillInvoice);
      emit(GalleryListFillInVoiceSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryListFillInVoiceError(e.toString()));
    });
  }
  postFillInVoice({invoice , department_id}){
    emit(GalleryPostFillInVoiceLoading());
    DioHelper.postData(
      data: {
        'department_id' :department_id,
      },
      url: 'dashboard/v1/tasks/send/$invoice',
    ).then((value){
      emit(GalleryPostFillInVoiceSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryPostFillInVoiceError(e.toString()));
    });
  }

  createFillInVoice({product_id , description, inVoiceId}){
    emit(GalleryCreateFillInVoiceLoading());
    DioHelper.postData(
      data: {
        'product_id' : product_id,
        'description' :description,
      },
      url: 'dashboard/v1/invoice/new/details/$inVoiceId',
    ).then((value){
      emit(GalleryCreateFillInVoiceSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryCreateFillInVoiceError(e.toString()));
    });
  }


  List<dynamic> viewCalculation = [];
  listCalculation (){
    emit(GalleryListCalculationLoading());
    DioHelper.getData(
      url: 'dashboard/v1/calculation',
    ).then((value){
      viewCalculation = value.data['calculation']['data'];
      print(viewCalculation);
      emit(GalleryListCalculationSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryListCalculationError(e.toString()));
    });
  }
  createCalculation({cut, type_id}){
    emit(GalleryCreateCalculationLoading());
    DioHelper.postData(
      data: {
        'cut' : cut,
        'type_id' : type_id,
      },
      url: 'dashboard/v1/calculation',
    ).then((value){
      emit(GalleryCreateCalculationSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryCreateCalculationError(e.toString()));
    });
  }
  updateCalculation({cut, type_id, id}){
    emit(GalleryUpdateCalculationLoading());
    DioHelper.postData(
      data: {
        'cut' : cut,
        'type_id' : type_id,
      },
      url: 'dashboard/v1/calculation/$id/update',
    ).then((value){
      emit(GalleryUpdateCalculationSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryUpdateCalculationError(e.toString()));
    });
  }
  deleteCalculation({id}){
    emit(GalleryDeleteCalculationLoading());
    DioHelper.postData(
      data: {
        'id' : id
      },
      url: 'dashboard/v1/calculation/$id/delete',
    ).then((value){
      emit(GalleryDeleteCalculationSuccess());
    }).catchError((e){
      print(e.toString());
      emit(GalleryDeleteCalculationError(e.toString()));
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

  final List<String> items = <String>['Admin', 'User'];
  String? selectedItem;
  dropdownButton(string){
    selectedItem = string;
    emit(GalleryMenuBar());
  }
  final List<String> itemsInvoice = <String>['original', 'custom'];
  String? selectedItemInvoice;


   List<String> available = <String>['Yes', 'No'];
   String? selectedAvailable;
  dropdownButtonAvailable(string){
    selectedAvailable = string;
    emit(GalleryMenuAvailableBar());
  }

  // var responses;
  var image;
  PickedFile? tempImage;
  getImage() async {
    tempImage = await ImagePicker().getImage(source: ImageSource.gallery);
      if (tempImage == null) return null;
      image = File(tempImage!.path);
      print(image);
      uploadFile(image);
      emit(ImageLoadingState());
   }
  var imageName ;
  Future uploadFile(File file) async {
    String name = file.path.split('/').last;
    print(name);
    var data = FormData.fromMap({"thumb": await MultipartFile.fromFile(
      file.path,
      filename: name,
    )});
    emit(GalleryUploadImageLoading());
    Dio dio = new Dio(
        BaseOptions(
            headers:{
              'Accept':'application/json',
              // 'Content-Type':'multipart/form-data'
            }
        )
    );
    await dio
        .post("http://18.221.253.60:83/api/imageUpload", data: data)
        .then((response) {
          emit(GalleryUploadImageSuccess());
          imageName = response.data['image']['image_name'];
          print('imageName : ${imageName}');
      print(response);
    }).catchError((error){
      emit(GalleryUploadImageError(error));
      print(error);
    });
  }
  String? mySelection;
}
