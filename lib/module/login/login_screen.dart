import 'dart:math';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallary/layout/cubit/cubit.dart';
import 'package:gallary/layout/cubit/state.dart';
import 'package:gallary/layout/home.dart';
import 'package:gallary/module/register/register_screen.dart';
import 'package:gallary/shared/components.dart';
import 'package:gallary/shared/network/local/cash.dart';
import 'admin_login_screen.dart';


class LoginPage extends StatelessWidget{
  final String? email;
  final String? password;
  LoginPage({this.email, this.password});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _globalKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if(email != null && password != null){
      emailController.text = email!;
      passwordController.text = password!;
    }
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
        create: (BuildContext context)=> GalleryCubit(),
      child: BlocConsumer<GalleryCubit, GalleryStates>(
          listener: (context, state){
            if(state is GalleryLoginSuccess){
              CashHelper.setData(key: 'token', value: GalleryCubit.get(context).loginModel!.data!.token);
              finishNavigate(context: context,widget: HomePage());
            }
            if(state is GalleryLoginError){
              Fluttertoast.showToast(
                  msg: 'Your Email or Your Password Is Incorrect',
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
                backgroundColor: Colors.indigo.shade900,
                appBar: AppBar(
                  title: Text(
                    'Login User',
                    style: TextStyle(
                        fontSize: 24.0, fontWeight: FontWeight.bold ,color: Colors.white),
                  ),
                backgroundColor: Colors.indigo.shade900 ,
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Form(
                    key: _globalKey,
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: Container(
                            height: height*0.2,
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Image(image: AssetImage('assets/image/iconsBuy.png')),
                                SizedBox(height:15.0 ,),
                                Positioned(
                                    bottom: 0,
                                    child: Text('Buy it' , style: TextStyle(fontFamily: 'pacifico' , fontSize: 25),)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.1,
                        ),
                        TextFormField(
                          validator: (value) {
                            if(value!.isEmpty){
                              return'Please Valid Your Email';
                            }else{
                              return null;
                            }
                          },
                          onSaved: (value){
                            print(value);
                          },
                          cursorColor: Colors.orangeAccent,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          controller: emailController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email,color: Colors.black,),
                            hintText: 'Enter Your Email',

                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height*0.02,
                        ),
                        TextFormField(
                          validator: (value) {
                            if(value!.isEmpty){
                              return'Please Valid Your Password';
                            }else{
                              return null;
                            }
                          },
                          onSaved: (value){
                            print(value);
                          },
                          cursorColor: Colors.orangeAccent,
                          controller: passwordController,
                          obscureText: GalleryCubit.get(context).isPassword,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock,color: Colors.black,),
                            suffixIcon: GalleryCubit.get(context).isPassword? IconButton(
                               icon:Icon (Icons.visibility_outlined,color: Colors.black,), onPressed: (){
                              GalleryCubit.get(context).showPassword();
                            },): IconButton(onPressed: (){GalleryCubit.get(context).showPassword();}, icon:Icon(Icons.visibility_off_sharp),color: Colors.black,),
                            hintText: 'Enter Your Password',
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height*0.05,
                        ),

                        ConditionalBuilder(
                          condition: state is! GalleryLoginLoading
                          , builder: (context)=> Padding(
                          padding: EdgeInsets.symmetric(horizontal: 80),
                          child : FlatButton(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(120)
                            ),
                            onPressed: (){
                              if(_globalKey.currentState!.validate()){
                                GalleryCubit.get(context).postLogin(
                                    email: emailController.text,
                                    password: passwordController.text
                                );
                              }
                            },
                            child: Text('Login',style: TextStyle(color: Colors.white),),
                          ),
                        ),
                          fallback: (context)=> Center(child: CircularProgressIndicator(),),
                        ),

                        SizedBox(
                          height: height*0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Dont have an acount ?',style: TextStyle(color: Colors.white,fontSize: 16),),
                            GestureDetector(
                              child: FlatButton(child: Text('Signup',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterPage()));},
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height*0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                                onTap: (){defaultNavigate(context: context, widget: AdminLoginPage());},
                                child: Text('are you Admin',style: TextStyle(color: Colors.white),

                                )),
                            Text('are you User',style: TextStyle(color: Colors.indigo.shade900),)
                          ],
                        )
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