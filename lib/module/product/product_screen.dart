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
              fontSize: 16.0
          );
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
              fontSize: 16.0
          );
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
              fontSize: 16.0
          );
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
                  fontSize: 24.0, fontWeight: FontWeight.bold ,color: Colors.white),
            ),
          ),
          key: scaffoldKey,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            reverse: false,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'inputData';
                      }
                      return null;
                    },
                    controller: GalleryCubit.get(context).searchProductController,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      GalleryCubit.get(context).searchProduct(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Search',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: ConditionalBuilder(
                            condition: state is! GallerySearchProductSuccess,
                            builder: (context)=> buildProduct(GalleryCubit.get(context).viewProduct,
                                context,formKey,scaffoldKey),
                            fallback: (context)=> buildSearchProduct(GalleryCubit.get(context).searchP,
                                context,formKey,scaffoldKey),
                          ),
                        )
                    ),
                  ),
                  // ConditionalBuilder(
                  //   condition: state is! GalleryListProductLoading,
                  //   builder: (context) => buildProduct(GalleryCubit.get(context).viewProduct,
                  //       context,formKey,scaffoldKey),
                  //   fallback: (context) => Center(
                  //     child: CircularProgressIndicator(color: Colors.black,),
                  //   ),
                  // ),
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
                            height: 5.0,
                          ),
                          defaultTextField(
                              validatorText: 'Available',
                              hint: 'Yes/NO',
                              type: TextInputType.number,
                              function: availableController),
                          SizedBox(
                            height: 5.0,
                          ),
                          FlatButton(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(120)
                            ),
                            onPressed: (){
                              if(formKey.currentState!.validate()){
                                GalleryCubit.get(context).createProduct(
                                  ar: arNameController.text,
                                  en: enNameController.text,
                                  cost: costController.text,
                                  availabilty: availableController.text,
                                );
                              }
                              Navigator.pop(context);
                            },
                            child: Text('Add Product',style: TextStyle(color: Colors.white),),
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

  Widget buildProduct(viewProduct, context,formKey,scaffoldKey) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          ],
        ),
      ),
      SizedBox(
        height: 25.0,
      ),
      GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          childAspectRatio: 1 / 0.5,
          children: List.generate(
              viewProduct.length,
                  (index) => buildGridProduct(
                  viewProduct[index], context,formKey,scaffoldKey)))

    ],
  );
  Widget buildSearchProduct(search, context,formKey,scaffoldKey) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          ],
        ),
      ),
      SizedBox(
        height: 25.0,
      ),
      GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          childAspectRatio: 1 / 0.5,
          children: List.generate(
              search.length,
                  (index) => buildGridSearchProduct(
                  search[index], context,formKey,scaffoldKey)))

    ],
  );
  Widget buildGridProduct(model, context,formKey,scaffoldKey) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(
              image: AssetImage('assets/image/red.png'),
              height: 200,
              width: 200,
            ),
            Row(
              children: [
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    'NEW',
                    style: TextStyle(color: Colors.white, fontSize: 8.0),
                  ),
                ),
                Spacer(),
                CircleAvatar(
                  child: IconButton(
                      onPressed: () {
                        GalleryCubit.get(context).deleteProduct(
                          id: '${model['id']}'
                        );
                      },
                      icon: Icon(
                        Icons.delete_forever,
                        size: 16.0,
                      )),
                  radius: 16.0,
                ),
                SizedBox(width: 15.0,),
                CircleAvatar(
                  child: IconButton(
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
                                        validatorText: 'الاسم عربى',
                                        textAlign: TextAlign.end,
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
                                      height: 5.0,
                                    ),
                                    defaultTextField(
                                        validatorText: 'Available',
                                        hint: 'Yes/No',
                                        type: TextInputType.number,
                                        function: availableController),
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
                                            GalleryCubit.get(context).updateProduct(
                                              id: '${model['id']}',
                                              ar: arNameController.text,
                                              en: enNameController.text,
                                              cost: costController.text,
                                              availabilty: availableController.text,
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
                      icon: Icon(
                        Icons.update,
                        size: 16.0,
                      )),
                  radius: 16.0,
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model['name']['en']}',
                maxLines: 2,
                style: TextStyle(
                    color: Colors.black, fontSize: 14.0, height: 1.3),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '${model['name']['ar']}',
                maxLines: 2,
                style: TextStyle(
                    color: Colors.black, fontSize: 14.0, height: 1.3),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '${model['cost']}\$',
                style: TextStyle(color: Colors.blue, fontSize: 12.0),
              )
            ],
          ),
        )
      ],
    ),
  );
  Widget buildGridSearchProduct(model, context,formKey,scaffoldKey) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(
              image: AssetImage('assets/image/red.png'),
              height: 200,
              width: 200,
            ),
            Row(
              children: [
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    'NEW',
                    style: TextStyle(color: Colors.white, fontSize: 8.0),
                  ),
                ),
                Spacer(),
                CircleAvatar(
                  child: IconButton(
                      onPressed: () {
                        GalleryCubit.get(context).deleteProduct(
                            id: '${model['id']}'
                        );
                      },
                      icon: Icon(
                        Icons.delete_forever,
                        size: 16.0,
                      )),
                  radius: 16.0,
                ),
                SizedBox(width: 15.0,),
                CircleAvatar(
                  child: IconButton(
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
                                        validatorText: 'الاسم عربى',
                                        textAlign: TextAlign.end,
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
                                      height: 5.0,
                                    ),
                                    defaultTextField(
                                        validatorText: 'Available',
                                        hint: 'Yes/No',
                                        type: TextInputType.number,
                                        function: availableController),
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
                                            GalleryCubit.get(context).updateProduct(
                                              id: '${model['id']}',
                                              ar: arNameController.text,
                                              en: enNameController.text,
                                              cost: costController.text,
                                              availabilty: availableController.text,
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
                      icon: Icon(
                        Icons.update,
                        size: 16.0,
                      )),
                  radius: 16.0,
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model['name']['en']}',
                maxLines: 2,
                style: TextStyle(
                    color: Colors.black, fontSize: 14.0, height: 1.3),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '${model['name']['ar']}',
                maxLines: 2,
                style: TextStyle(
                    color: Colors.black, fontSize: 14.0, height: 1.3),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '${model['cost']}\$',
                style: TextStyle(color: Colors.blue, fontSize: 12.0),
              )
            ],
          ),
        )
      ],
    ),
  );
}
