import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallary/layout/cubit/cubit.dart';
import 'package:gallary/layout/cubit/state.dart';
import 'package:gallary/shared/components.dart';


class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  ScrollController controller = ScrollController();
  BuildContext? blocContext;
  final enNameController = TextEditingController();
  final arNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final roleController = TextEditingController();
  GlobalKey<dynamic> dropBottonKeyRole = GlobalKey();
  String? _mySelectionRole;
  String? _mySelectionDepartment;
  GlobalKey<dynamic> dropBottonKeyDepartment = GlobalKey();
  // @override
  // void initState()
  // {
  //   super.initState();
  //
  //   controller.addListener(()
  //   {
  //     if (controller.offset >= controller.position.maxScrollExtent &&
  //         !controller.position.outOfRange)
  //     {
  //       print('bottom bottom');
  //
  //       if(GalleryCubit.get(blocContext).currentPageUser <= GalleryCubit.get(blocContext).totalPageUser)
  //         GalleryCubit.get(blocContext).listUserMore();
  //     }
  //   });
  // }
  var searchController = TextEditingController();
  List<dynamic> role = ['admin' , 'user'];
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<FormState> formKeyCreate = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<GalleryCubit, GalleryStates>(
      listener: (context, state) {
        if (state is GalleryDeleteUserSuccess) {
          Fluttertoast.showToast(
              msg: 'Delete User Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          GalleryCubit.get(context).listUser(CreateUserSuccess: true);
        }
        if (state is GalleryRegisterSuccess) {
          Fluttertoast.showToast(
              msg: 'Delete User Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          GalleryCubit.get(context).listUser(CreateUserSuccess: true);
        }
        if (state is GalleryUpdateUserSuccess) {
          Fluttertoast.showToast(
              msg: 'Update User Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          GalleryCubit.get(context).listUser(CreateUserSuccess: true);
        }
        if (state is GalleryCreateUserSuccess) {
          Fluttertoast.showToast(
              msg: 'Create User Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          GalleryCubit.get(context).listUser(CreateUserSuccess: true);
        }
      },
      builder: (context, state) {
        blocContext = context;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title:Text('Users',style: TextStyle(
                fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),),
            backgroundColor: Colors.indigo.shade900,
          ),
          body: SingleChildScrollView(
            reverse: false,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    style: TextStyle(
                        color: Colors.white
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'inputData';
                      }
                      return null;
                    },
                    controller: GalleryCubit.get(context).searchUserController,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (value) {},
                    onChanged: (value) {
                      GalleryCubit.get(context).searchUser(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Search',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    width: width * 0.99,
                      height: height * 0.5,
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SingleChildScrollView(
                          child: Conditional.single(
                            context : context,
                            conditionBuilder: (context)=> state is! GallerySearchUserSuccess ,
                            widgetBuilder: (context)=> SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(start: 15.0),
                                      child: Container(
                                        width: width * 0.72,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: Text(
                                                  'Arabic\nName',
                                                  style: TextStyle(
                                                      color: Colors.black,fontWeight: FontWeight.bold),
                                                )),
                                            Expanded(
                                                child: Text(
                                                  'English\nName',
                                                  style: TextStyle(
                                                      color: Colors.black,fontWeight: FontWeight.bold),
                                                )),
                                            Expanded(
                                                child: Text(
                                                  'Email',
                                                  style: TextStyle(
                                                      color: Colors.black,fontWeight: FontWeight.bold),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    SingleChildScrollView(
                                      child: Container(
                                        height: height * 0.50,
                                        width: width * 1.2,
                                        child: ListView.separated(
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) => customerTable(
                                              GalleryCubit.get(context).viewUser[index],
                                              context,
                                              width,
                                              height
                                            ),
                                            separatorBuilder: (context, index) => Divider(
                                              height: 2,
                                            ),
                                            itemCount:
                                            GalleryCubit.get(context).viewUser.length),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Stack(
                                      alignment: Alignment.center,
                                      children:
                                      [
                                        Container(),
                                        if(state is! GalleryListUserMoreLoading && GalleryCubit.get(context).currentPageUser <= GalleryCubit.get(context).totalPageUser)
                                          MaterialButton(
                                            height: 40.0,
                                            color: Colors.white,
                                            onPressed: ()
                                            {
                                              if(GalleryCubit.get(context).currentPageUser <= GalleryCubit.get(context).totalPageUser)
                                                GalleryCubit.get(context).listUserMore();
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'Load More',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Icon(
                                                  Icons.arrow_downward,
                                                  size: 16.0,
                                                  color: Colors.black,
                                                ),
                                              ],
                                            ),
                                          ),
                                        if(state is GalleryListUserMoreLoading)
                                          CircularProgressIndicator(),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            fallbackBuilder: (context)=> SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(start: 15.0),
                                      child: Container(
                                        width: width * 0.72,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                child: Text(
                                                  'Arabic\nName',
                                                  style: TextStyle(
                                                      color: Colors.black,fontWeight: FontWeight.bold ),
                                                )),
                                            Expanded(
                                                child: Text(
                                                  'English\nName',
                                                  style: TextStyle(
                                                      color: Colors.black,fontWeight: FontWeight.bold ),
                                                )),
                                            Expanded(
                                                child: Text(
                                                  'Email',
                                                  style: TextStyle(
                                                      color: Colors.black,fontWeight: FontWeight.bold),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    SingleChildScrollView(
                                      child: Container(
                                        height: height*0.50,
                                        width: width * 1.2,
                                        child: ListView.separated(
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) => customerTable(
                                              GalleryCubit.get(context).searchY[index],
                                              context,
                                              width,
                                              height,
                                            ),
                                            separatorBuilder: (context, index) => Divider(
                                              height: 2,
                                            ),
                                            itemCount:
                                            GalleryCubit.get(context).searchY.length),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Stack(
                                      alignment: Alignment.center,
                                      children:
                                      [
                                        Container(),
                                        if(state is! GalleryListUserMoreLoading && GalleryCubit.get(context).currentPageUser <= GalleryCubit.get(context).totalPageUser)
                                          MaterialButton(
                                            height: 40.0,
                                            color: Colors.white,
                                            onPressed: ()
                                            {
                                              if(GalleryCubit.get(context).currentPageUser <= GalleryCubit.get(context).totalPageUser)
                                                GalleryCubit.get(context).listUserMore();
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'Load More',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Icon(
                                                  Icons.arrow_downward,
                                                  size: 16.0,
                                                  color: Colors.black,
                                                ),
                                              ],
                                            ),
                                          ),
                                        if(state is GalleryListUserMoreLoading)
                                          CircularProgressIndicator(),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                  ],
                                ),
                              )
                            ),
                          ),
                        ),
                      )
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: Form(
            key: formKeyCreate,
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: (){
                _showDialogCreateUser(
                    context: context,
                    text: 'Add User',
                    height: height,
                    width: width,
                    function: (){
                      if(formKeyCreate.currentState!.validate()){
                        GalleryCubit.get(context).postApi(
                          arName: arNameController.text,
                          email: emailController.text,
                          enName: enNameController.text,
                          password: passwordController.text,
                          passwordConfirmation: passwordConfirmController.text,
                          role: _mySelectionRole
                        );
                        arNameController.clear();
                        emailController.clear();
                        enNameController.clear();
                        passwordController.clear();
                        passwordConfirmController.clear();
                        Navigator.pop(context);
                      }
                    }
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget customerTable(model, context ,width , height, ) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        alignment: Alignment.center,
        padding: EdgeInsetsDirectional.only(start: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Text('${model['name']['ar']}')),
            Expanded(child: Text('${model['name']['en']}',)),
            Expanded(child: Text('${model['email']}')),
            Expanded(
                child: IconButton(
                    onPressed: () {
                      GalleryCubit.get(context)
                          .deleteUser(id: model['id']);
                    },
                    icon: Icon(Icons.delete))),
            Expanded(
              child: CircleAvatar(
                child: IconButton(
                    onPressed: () {
                      _showDialogCreateUser(
                          context: context,
                          text: 'Update User',
                          user: model,
                          height: height,
                          width: width,
                          function: (){
                              GalleryCubit.get(context).updateUser(
                                id: '${model['id']}',
                                  arName: arNameController.text,
                                  email: emailController.text,
                                  enName: enNameController.text,
                                  password: passwordController.text,
                                  passwordConfirmation: passwordConfirmController.text,
                                  role: _mySelectionRole
                              );
                              arNameController.clear();
                              emailController.clear();
                              enNameController.clear();
                              passwordController.clear();
                              passwordConfirmController.clear();
                              Navigator.pop(context);
                          }
                      );
                    },
                    icon: Icon(
                      Icons.update,
                      size: 16.0,
                    )),
                radius: 16.0,
              ),
            ),
          ],
        ),
      )
    ],
  );

  Future _showDialogCreateUser({context, text, function, width , height, user}) async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            width: width * 0.25,
            child: AlertDialog(
              title: Text('User'),
              content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Column(mainAxisSize: MainAxisSize.min, children: <
                      Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Column(
                        children: [
                          defaultTextField(
                              function: arNameController,
                              validatorText: 'الاسم عربى',
                              hint: 'ArabicName',
                              type: TextInputType.name),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          defaultTextField(
                              validatorText: 'Enter Your EnglishName',
                              hint: 'EnglishName',
                              type: TextInputType.name,
                              function: enNameController),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          defaultTextField(
                              validatorText: 'Enter Your Email',
                              hint: 'Email',
                              function: emailController,
                              type: TextInputType.emailAddress),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          defaultTextField(
                              p: passwordController.text,
                              validatorText: 'Enter Your Password',
                              hint: 'Password',
                              type: TextInputType.visiblePassword,
                              function: passwordController),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          defaultTextField(
                              c: passwordConfirmController.text,
                              validatorText: 'Enter Your ConfirmPassword',
                              function: passwordConfirmController,
                              hint: 'ConfirmPassword',
                              type: TextInputType.visiblePassword),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Container(
                            height: 55.0,
                            alignment: AlignmentDirectional.center,
                            padding:
                            const EdgeInsets.symmetric(horizontal: 40.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white),
                            child: DropdownButton(
                              hint: Text('Role'),
                              menuMaxHeight: 140.0,
                              key: dropBottonKeyRole,
                              isExpanded: true,
                              items: role.map((item) {
                                return new DropdownMenuItem(
                                  child:
                                  new Text(item.toString()),
                                  value: item.toString(),
                                );
                              }).toList(),
                              onChanged: (String? Val) {
                                setState(() {
                                  _mySelectionRole = Val;
                                });
                              },
                              value: _mySelectionRole,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            height: 55.0,
                            alignment: AlignmentDirectional.center,
                            padding: const EdgeInsets.symmetric(horizontal: 40.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white),
                            child: DropdownButton(
                              hint: Text('Type'),
                              menuMaxHeight: 140.0,
                              key: dropBottonKeyDepartment,
                              isExpanded: true,
                              items:
                              GalleryCubit.get(context).viewDepartment.map((item) {
                                return new DropdownMenuItem(
                                  child: new Text(item['name']['en']),
                                  value: item['id'].toString(),
                                );
                              }).toList(),
                              onChanged: (String? newVal) {
                                setState(() {
                                  _mySelectionDepartment = newVal;
                                });
                              },
                              value: _mySelectionDepartment,
                            ),
                          ),
                          // FlatButton(
                          //   color: Colors.black,
                          //   shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(120)),
                          //   onPressed: (){
                          //     GalleryCubit.get(context).getImage();
                          //   },
                          //   child: Text(
                          //     'Choose Image',
                          //     style: TextStyle(color: Colors.white),
                          //   ),
                          // ),
                          SizedBox(height: 10,),
                          FlatButton(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(120)),
                            onPressed: function,
                            child: Text(
                              text,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    FlatButton(
                        child: Text('cancel'),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ]);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
