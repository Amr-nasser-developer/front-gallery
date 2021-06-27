import 'dart:ui';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallary/layout/cubit/cubit.dart';
import 'package:gallary/layout/cubit/state.dart';
import 'package:gallary/shared/components.dart';
import 'package:image_picker/image_picker.dart';

class ProductScreen extends StatelessWidget {
  var arNameController = TextEditingController();
  var enNameController = TextEditingController();
  var costController = TextEditingController();
  var availableController = TextEditingController();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

    return BlocConsumer<GalleryCubit, GalleryStates>(
      listener: (context, state) {
        if (state is GalleryDeleteProductSuccess) {
          Fluttertoast.showToast(
              msg: 'Delete Product Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          GalleryCubit.get(context).listProduct();
        }
        if (state is GalleryCreateProductSuccess) {
          Fluttertoast.showToast(
              msg: 'Create Product Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          GalleryCubit.get(context).listProduct();
        }
        if (state is GalleryUpdateProductSuccess) {
          Fluttertoast.showToast(
              msg: 'Update Product Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          GalleryCubit.get(context).listProduct();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigo.shade900,
            title: Text(
              'Product',
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          key: scaffoldKey,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            reverse: false,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    controller:
                        GalleryCubit.get(context).searchProductController,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      GalleryCubit.get(context).searchProduct(value);
                    },
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      fillColor: Colors.white,
                      hoverColor: Colors.black,
                      labelText: 'Search',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: ConditionalBuilder(
                        condition: state is! GallerySearchProductSuccess,
                        builder: (context) =>
                            ListView.separated(
                              shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index)=>buildProduct(GalleryCubit.get(context).viewProduct[index], context),
                                separatorBuilder: (context, index)=> Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Divider(color: Colors.grey[400],),
                                ),
                                itemCount: GalleryCubit.get(context).viewProduct.length
                            ),
                        fallback: (context) =>
                            ListView.separated(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index)=>buildProduct(GalleryCubit.get(context).searchP[index], context),
                                separatorBuilder: (context, index)=> Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Divider(color: Colors.grey[400],),
                                ),
                                itemCount: GalleryCubit.get(context).searchP.length
                            ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (GalleryCubit.get(context).isBottomSheetShownn) {
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
                                  validatorText: 'Enter Your Cost',
                                  hint: 'Cost',
                                  type: TextInputType.number,
                                  function: costController),
                              SizedBox(
                                height: 10.0,
                              ),
                              defaultTextField(
                                suffixText: 'Available',
                                  validatorText: 'Enter The Available',
                                  hint: 'Yes/No',
                                  type: TextInputType.name,
                                  function: availableController),
                              SizedBox(
                                height: 5.0,
                              ),
                              RaisedButton(
                                  onPressed: (){
                                    GalleryCubit.get(context).getImage(ImageSource.gallery);
                                  },
                                child: Text('Choose Image'),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              FlatButton(
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(120)),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    GalleryCubit.get(context).createProduct(
                                      ar: arNameController.text,
                                      en: enNameController.text,
                                      cost: costController.text,
                                      availabilty: availableController.text,
                                      thumb: GalleryCubit.get(context).image.toString()
                                    );
                                    print('${GalleryCubit.get(context).image.toString()}');
                                  }
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Add Product',
                                  style: TextStyle(color: Colors.white),
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
                  GalleryCubit.get(context).changeBottomSheetStatee(
                    isShow: false,
                    icon: Icons.edit,
                  );
                });

                GalleryCubit.get(context).changeBottomSheetStatee(
                  isShow: true,
                  icon: Icons.add,
                );
              }
            },
            child: Icon(GalleryCubit.get(context).fabIcon),
          ),
        );
      },
    );
  }

  Widget buildProduct(dataOfDataModel, context)=> Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0),
    alignment: Alignment.center,
    color: Colors.black45,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 200,
          width: 200,
          child: Image.network('${dataOfDataModel['thump']}'),
        ),
        SizedBox(width: 15.0,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${dataOfDataModel['name']['ar']}',
              style: TextStyle(color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(width: 15.0,),
            Text(
              '${dataOfDataModel['name']['en']}',
              style: TextStyle(color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        Spacer(),
        IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_sharp,color: Colors.white,))
      ],
    ),
  );
  Widget enableUpload(context) {
    return Container(
      child: Column(
        children: <Widget>[
          Image.network('${GalleryCubit.get(context).image}'),
          RaisedButton(
            elevation: 7.0,
            child: Text('Upload'),
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: () {
              print('${GalleryCubit.get(context).image}');
            },
          )
        ],
      ),
    );
  }
}
