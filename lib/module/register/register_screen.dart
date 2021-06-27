import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallary/layout/cubit/cubit.dart';
import 'package:gallary/layout/cubit/state.dart';
import 'package:gallary/module/login/login_screen.dart';
import 'package:gallary/shared/components.dart';

class RegisterPage extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final enNameController = TextEditingController();
  final arNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context) => GalleryCubit(),
      child: BlocConsumer<GalleryCubit, GalleryStates>(
        listener: (context, state) {
          if (state is GalleryRegisterSuccess) {
            finishNavigate(
                context: context,
                widget: LoginPage(
                  email: emailController.text,
                  password: passwordController.text,
                ));
          }
        },
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.indigo.shade900,
              appBar: AppBar(
                title: Text(
                  'Register',
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                backgroundColor: Colors.indigo.shade900,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Form(
                  key: _globalKey,
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Container(
                          height: height * 0.2,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Image(
                                  image:
                                      AssetImage('assets/image/iconsBuy.png')),
                              SizedBox(
                                height: 15.0,
                              ),
                              Positioned(
                                  bottom: 0,
                                  child: Text(
                                    'Buy it',
                                    style: TextStyle(
                                        fontFamily: 'pacifico', fontSize: 25),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      defaultTextField(
                          textAlign: TextAlign.end,
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
                      dropButton(
                        hint: Text('Role'),
                        function: (String? newValue){
                          GalleryCubit.get(context).dropdownButton(newValue);
                        } ,
                        items: GalleryCubit.get(context).items,
                        value: GalleryCubit.get(context).selectedItem,
                      ),

                      SizedBox(
                        height: height*0.05,
                      ),
                      ConditionalBuilder(
                        condition: state is! GalleryRegisterLoading,
                        builder: (context) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 80),
                          child: FlatButton(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(120)),
                            onPressed: () {
                              if (passwordController.text !=
                                  passwordConfirmController.text) {
                                Fluttertoast.showToast(
                                    msg: 'The password dosen\'t match',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 3,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                              if (_globalKey.currentState!.validate()) {
                                GalleryCubit.get(context).postApi(
                                  // role: roleController.text,
                                  arName: arNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  enName: enNameController.text,
                                  passwordConfirmation: passwordConfirmController.text,
                                  role: GalleryCubit.get(context).selectedItem
                                );
                                print(GalleryCubit.get(context).selectedItem);
                              }
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
