import 'package:flutter/material.dart';
import 'package:gallary/module/login/login_screen.dart';
import 'package:gallary/module/register/register_screen.dart';
import 'package:gallary/shared/components.dart';

class AdminLoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AdminLoginPageState();
  }
}
class AdminLoginPageState extends State<AdminLoginPage>{
  final GlobalKey<FormState> _globalKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.indigo.shade900,
        appBar: AppBar(
          title: Text(
            'Login Admin',
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
                        SizedBox(height: 15.0,),
                        Positioned(
                            bottom: 0,
                            child: Text('Gallery' , style: TextStyle(fontFamily: 'pacifico' , fontSize: 25),)),
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
                  obscureText: false,
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
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock,color: Colors.black,),
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

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80),
                  child : FlatButton(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(120)
                    ),
                    onPressed: (){
                      _globalKey.currentState!.validate();
                    },
                    child: Text('Login',style: TextStyle(color: Colors.white),),
                  ),
                ),
                SizedBox(
                  height: height*0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Dont have an acount ?',style: TextStyle(color: Colors.white,fontSize: 16),),
                    GestureDetector(
                      child: FlatButton(child: Text('Signup',style: TextStyle(color: Colors.black),),
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
                    Text('are you Admin ?',style: TextStyle(color: Colors.white),),
                    GestureDetector(
                        onTap: (){defaultNavigate(context: context, widget: LoginPage());},
                        child: Text('are you User',style: TextStyle(color: Colors.indigo.shade900),)
                    ),

                  ],
                )
              ],
            ),
          ),
        )
    );
  }

}