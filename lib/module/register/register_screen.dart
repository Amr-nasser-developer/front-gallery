import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallary/module/login/login_screen.dart';
import 'package:gallary/module/register/cubit/cubit.dart';
import 'package:gallary/shared/components.dart';
import 'cubit/state.dart';

class RegisterPage extends StatelessWidget{
  final GlobalKey<FormState> _globalKey = GlobalKey();

  final enNameController = TextEditingController();
  final arNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final roleController = TextEditingController();
  final menuController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context)=> GalleryCubit(),
      child: BlocConsumer<GalleryCubit, GalleryStates>(
        listener: (context, state){
          if(state is GalleryRegisterSuccess){
            // print('success');
            finishNavigate(context: context, widget: LoginPage(email: emailController.text,password: passwordController.text,));
          }
          if(state is GalleryRegisterLoading){
            print('Loading');
          }
          if(state is GalleryRegisterError){
            print(state.error);
            Fluttertoast.showToast(
                msg: 'This Email Already Use',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        },
        builder: (context, state){
          return Scaffold(
              backgroundColor: Colors.orangeAccent,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Form(
                  key: _globalKey,
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Container(
                          height: height*0.2,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Image(image: AssetImage('assets/image/iconsBuy.png')),
                              Positioned(
                                  bottom: 0,
                                  child: Text('Buy it' , style: TextStyle(fontFamily: 'pacifico' , fontSize: 25),)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height*0.02,
                      ),
                      defaultTextField(
                          function: arNameController ,
                          validatorText: 'Enter Your ArabicName',
                          hint: 'ArabicName',
                          type: TextInputType.name
                      ),
                      SizedBox(
                        height: height*0.02,
                      ),
                      defaultTextField(
                          validatorText: 'Enter Your EnglishName',
                          hint: 'EnglishName',
                          type: TextInputType.name,
                          function: enNameController
                      ),
                      SizedBox(
                        height: height*0.02,
                      ),
                      defaultTextField(
                          validatorText: 'Enter Your Email',
                          hint: 'Email',
                          function: emailController,
                          type: TextInputType.emailAddress
                      ),
                      SizedBox(
                        height: height*0.02,
                      ),
                      defaultTextField(
                          p: passwordController.text,
                          validatorText: 'Enter Your Password',
                          hint: 'Password',
                          type: TextInputType.visiblePassword,
                          function: passwordController
                      ),
                      SizedBox(
                        height: height*0.02,
                      ),
                      defaultTextField(
                          c: passwordConfirmController.text,
                          validatorText: 'Enter Your ConfirmPassword',
                          function: passwordConfirmController,
                          hint: 'ConfirmPassword',
                          type: TextInputType.visiblePassword
                      ),
                      SizedBox(
                        height: height*0.02,
                      ),
                      // Container(
                      //   height: 55.0,
                      //   alignment: AlignmentDirectional.center,
                      //   padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      //   decoration: BoxDecoration(
                      //       border: Border.all(color: Colors.white),
                      //       borderRadius: BorderRadius.circular(20.0),
                      //       color: Colors.pink
                      //   ),
                      //   child: DropdownButton<String>(
                      //     value: GalleryCubit.get(context).dropdownValue,
                      //     icon: const Icon(Icons.arrow_downward,color: Colors.white,),
                      //     isExpanded: true,
                      //     iconSize: 24,
                      //     elevation: 16,
                      //     style: const TextStyle(
                      //         color: Colors.black
                      //     ),
                      //     // underline: Container(
                      //     //   height: 2,
                      //     //   color: Colors.white,
                      //     // ),
                      //     onChanged: (String? newValue) {
                      //       GalleryCubit.get(context).changeMenu(newValue);
                      //     },
                      //     items: <String>['Admin', 'User']
                      //         .map<DropdownMenuItem<String>>((String value) {
                      //       return DropdownMenuItem<String>(
                      //         value: value,
                      //         child: Text(value),
                      //       );
                      //     }).toList(),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: height*0.05,
                      // ),
                      ConditionalBuilder(
                          condition: state is! GalleryRegisterLoading
                          , builder: (context)=> Padding(
                        padding: EdgeInsets.symmetric(horizontal: 80),
                        child : FlatButton(
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(120)
                          ),
                          onPressed: (){
                            if(_globalKey.currentState!.validate()){
                              GalleryCubit.get(context).postApi(
                                arName: arNameController.text ,
                                email: emailController.text,
                                password: passwordController.text,
                                enName: enNameController.text,
                                passwordConfirmation: passwordConfirmController.text ,
                              );
                            }
                          },
                          child: Text('Register',style: TextStyle(color: Colors.white),),
                        ),
                      ),
                        fallback: (context)=> Center(child: CircularProgressIndicator(),),
                      ),
                    ],
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}