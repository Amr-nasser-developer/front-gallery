import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void finishNavigate({context, widget}) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

void defaultNavigate({context, widget}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

Widget defaultTextField({
  label,
  suffixText,
  String? validatorText,
  bool obscure = false,
  String? hint,
  String? p,
  String? c,
  IconData? iconData,
  TextInputType? type,
  TextEditingController? function,
  textAlign = TextAlign.start,
  int max = 1
}) =>
    TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return validatorText;
        } else {
          return null;
        }
      },
      onSaved: (value) {
        print(value);
      },
      controller: function,
      maxLines: max,
      textAlign: textAlign,
      cursorColor: Colors.orangeAccent,
      obscureText: obscure,
      keyboardType: type,
      decoration: InputDecoration(
        prefixIcon: Icon(
          iconData,
          color: Colors.black,
        ),
        hintText: hint,
        labelText: label,
        hintStyle: TextStyle(color: Colors.black38),
        fillColor: Colors.white,
        filled: true,
        suffixText: suffixText,
        suffixStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
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

Widget buildHome(
        {@required String? name, @required IconData? iconData, function}) =>
    GestureDetector(
      onTap: function,
      child: Container(
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.pink,
              child: Icon(
                iconData,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Text(
                '${name}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_sharp,
              color: Colors.white,
            )
          ],
        ),
      ),
    );

Widget dropButton({value ,function, items, hint})=> Container(
  height: 55.0,
  alignment: AlignmentDirectional.center,
  padding: const EdgeInsets.symmetric(horizontal: 40.0),
  decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(20.0),
      color: Colors.white
  ),
  child: DropdownButton<String>(
    menuMaxHeight: 120.0,
    hint: hint,
    value: value,
    icon: const Icon(Icons.arrow_downward,color: Colors.black38,size: 20,),
    isExpanded: true,
    iconSize: 24,
    elevation: 16,
    style: const TextStyle(
        color: Colors.black
    ),
    onChanged: function,
    items: items.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  ),
);

