import 'dart:html';

import 'package:flutter/material.dart';

void finishNavigate({context, widget}) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

void defaultNavigate({context, widget}) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => widget));
}


Widget defaultTextField({String? validatorText , bool obscure = false, String? hint ,String? p ,String? c ,
  IconData? iconData, TextInputType? type, TextEditingController? function })=> TextFormField(
  validator: (value) {
    if(value!.isEmpty){
      return validatorText;
    }else if(p != c){
      return 'The password does not match';
    }
    else{
      return null;
    }
  },
  onSaved: (value){
    print(value);
  },
  controller: function,
  cursorColor: Colors.orangeAccent,
  obscureText: obscure,
  keyboardType: type,
  decoration: InputDecoration(
    prefixIcon: Icon(iconData,color: Colors.orangeAccent,),
    hintText: hint,
    hintStyle: TextStyle(color: Colors.white),
    fillColor: Colors.pink,
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
);
