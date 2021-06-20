import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallary/layout/cubit/cubit.dart';
import 'package:gallary/layout/cubit/state.dart';
import 'package:gallary/shared/components.dart';


class UserScreen extends StatelessWidget {
  var searchController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  GlobalKey<FormState> formKey = GlobalKey();
  final enNameController = TextEditingController();
  final arNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final roleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
          GalleryCubit.get(context).listUser();
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
          GalleryCubit.get(context).listUser();
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
          GalleryCubit.get(context).listUser();
        }
      },
      builder: (context, state) {
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'inputData';
                      }
                      return null;
                    },
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (value) {},
                    onChanged: (value) {
                      print(value);
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
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white),
                    child: ConditionalBuilder(
                        condition: state is! GalleryListUserLoading ,
                        builder: (context)=> Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: 15.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: Text(
                                        'Id',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 24.0),
                                      )),
                                  Expanded(
                                      child: Text(
                                        'Arabic Name',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 24.0),
                                      )),
                                  Expanded(
                                      child: Text(
                                        'English Name',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 24.0),
                                      )),
                                  Expanded(
                                      child: Text(
                                        'Email',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 24.0),
                                      )),
                                  Expanded(
                                      child: Text(
                                        '             Delete    ',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 24.0),
                                      )),
                                  Expanded(
                                      child: Text(
                                        '            Update       ',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 24.0),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) => customerTable(
                                  GalleryCubit.get(context).viewUser[index],
                                  context,
                                ),
                                separatorBuilder: (context, index) => Divider(
                                  height: 2,
                                ),
                                itemCount:
                                GalleryCubit.get(context).viewUser.length),
                          ],
                        ),
                      fallback: (context)=> Center(child: CircularProgressIndicator(),),
                    )
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget customerTable(model, context) => Column(
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
            Expanded(child: Text('${model['id']}')),
            Expanded(child: Text('     ${model['name']['ar']}')),
            Expanded(child: Text('     ${model['name']['en']}')),
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
                      if (GalleryCubit.get(context).isBottomSheetShownnn) {
                        if (formKey.currentState!.validate()) {}
                      } else {
                        scaffoldKey.currentState!.showBottomSheet(
                              (context) => Container(
                            color: Colors.indigo.shade900,
                            padding: EdgeInsets.all(
                              20.0,
                            ),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  defaultTextField(
                                     textAlign: TextAlign.end,
                                      validatorText: 'الاسم عربى',
                                      hint: 'الاسم عربى',
                                      type: TextInputType.name,
                                      function: arNameController),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  defaultTextField(
                                      validatorText: 'Enter Your EnglishName',
                                      hint: 'EnglishName',
                                      type: TextInputType.name,
                                      function: enNameController),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  defaultTextField(
                                      validatorText: 'Enter Your Email',
                                      hint: 'Email',
                                      type: TextInputType.number,
                                      function: emailController),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  defaultTextField(
                                      validatorText: 'Enter Your Password',
                                      hint: 'Password',
                                      type: TextInputType.number,
                                      function: passwordController),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  defaultTextField(
                                      validatorText: 'Enter Your passwordConfirm',
                                      hint: 'passwordConfirm',
                                      type: TextInputType.number,
                                      function: passwordConfirmController),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 80),
                                    child : FlatButton(
                                      color: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(120)
                                      ),
                                      onPressed: (){
                                        if(formKey.currentState!.validate()){
                                          GalleryCubit.get(context).updateUser(
                                              password: passwordController.text,
                                              passwordConfirmation: passwordConfirmController.text,
                                              id: '${model['id']}',
                                              departmentId:'${model['department_id']}' ,
                                              email: emailController.text,
                                              enName: enNameController.text,
                                              arName: arNameController.text
                                          );
                                        }
                                        Navigator.pop(context);
                                      },
                                      child: Text('Update',style: TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          elevation: 20.0,
                        )
                            .closed
                            .then((value) {
                          GalleryCubit.get(context).changeBottomSheetStateee(
                            isShow: false,
                            icon: Icons.edit,
                          );
                        });

                        GalleryCubit.get(context).changeBottomSheetStateee(
                          isShow: true,
                          icon: Icons.add,
                        );
                      }
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
}
