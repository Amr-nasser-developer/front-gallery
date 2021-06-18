import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallary/layout/cubit/cubit.dart';
import 'package:gallary/layout/cubit/state.dart';
import 'package:gallary/module/product/product_screen.dart';
import 'package:gallary/shared/components.dart';


class InsertProduct extends StatelessWidget{
  final GlobalKey<FormState> _globalKey = GlobalKey();
  GlobalKey<dynamic> buttonKey = GlobalKey();
  var arNameController = TextEditingController();
  var enNameController = TextEditingController();
  var costController = TextEditingController();
  var availableController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context)=> GalleryCubit(),
      child: BlocConsumer<GalleryCubit, GalleryStates>(
        listener: (context, state){
          if(state is GalleryCreateProductSuccess){
            GalleryCubit.get(context).listProduct();
            Fluttertoast.showToast(
                msg: 'Add Successfully',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        },
        builder: (context, state){
          var arNameController = TextEditingController();
          var enNameController = TextEditingController();
          var costController = TextEditingController();
          var availableController = TextEditingController();

          return Scaffold(
            appBar: AppBar(
              actions: [
                TextButton(onPressed: (){
                  finishNavigate(widget: ProductScreen(), context: context);
                }, child: Text('Back'))
              ],
            ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Form(
                  key: _globalKey,
                  child: ListView(
                    children: <Widget>[
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
                          validatorText: 'Enter Your Cost',
                          hint: 'Cost',
                          function: costController,
                          type: TextInputType.number
                      ),
                      SizedBox(
                        height: height*0.02,
                      ),
                      defaultTextField(
                          validatorText: 'Enter Your Available',
                          hint: 'Available',
                          type: TextInputType.number,
                          function: availableController
                      ),
                      SizedBox(
                        height: height*0.02,
                      ),
                      // RaisedButton(onPressed: (){
                      //   GalleryCubit.get(context).pickImage();
                      // },
                      //   key: buttonKey,
                      //   child: Text('Insert Photo'),
                      // ),
                      SizedBox(
                        height: height*0.02,
                      ),
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
                              GalleryCubit.get(context).createProduct(
                              ar: arNameController.text,
                                en: enNameController.text,
                                cost: costController.text,
                                availabilty: availableController.text,
                                thumb: buttonKey.toString()
                              );
                            }
                          },
                          child: Text('Add Product',style: TextStyle(color: Colors.white),),
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
