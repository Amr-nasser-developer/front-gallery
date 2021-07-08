import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallary/layout/cubit/cubit.dart';
import 'package:gallary/layout/cubit/state.dart';
import 'package:gallary/shared/components.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List available = ['yes', 'no'];
  String? _mySelectionAvailable;
  GlobalKey<dynamic> dropBottonKeyAvailable = GlobalKey();
  ScrollController controller = ScrollController();
  BuildContext? blocContext;
  GlobalKey<FormState> formKey = GlobalKey();
  var arNameController = TextEditingController();
  var enNameController = TextEditingController();
  var costController = TextEditingController();
  var availableController = TextEditingController();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

    return BlocConsumer<GalleryCubit, GalleryStates>(
      listener: (context, state) {
        if(state is GalleryUploadImageSuccess){
          Fluttertoast.showToast(
              msg: 'Upload Success',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          GalleryCubit.get(context).listProduct(CreateProductSuccess: true);
        }
        if (state is GalleryDeleteProductSuccess) {
          Fluttertoast.showToast(
              msg: 'Delete Product Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          GalleryCubit.get(context).listProduct(CreateProductSuccess: true);
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
          GalleryCubit.get(context).listProduct(CreateProductSuccess: true);
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
          GalleryCubit.get(context).listProduct(CreateProductSuccess: true);
        }
      },
      builder: (context, state) {
        blocContext = context;
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
            controller: controller,
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
                    controller: GalleryCubit.get(context).searchProductController,
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
                      child: Conditional.single(
                        context: context,
                        conditionBuilder: (context) => state is! GallerySearchProductSuccess,
                        widgetBuilder: (context) => Column(
                              children: [
                                ListView.separated(
                                    shrinkWrap:  true,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index)=>buildProduct(GalleryCubit.get(context).viewProduct[index], context,),
                                    separatorBuilder: (context, index)=> Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                      child: Divider(color: Colors.grey[400],),
                                    ),
                                    itemCount: GalleryCubit.get(context).viewProduct.length
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Stack(
                                  alignment: Alignment.center,
                                  children:
                                  [
                                    Container(),
                                    if(state is! GalleryListProductMoreLoading && GalleryCubit.get(context).currentPageProduct <= GalleryCubit.get(context).totalPageProduct)
                                      MaterialButton(
                                        height: 40.0,
                                        color: Colors.white,
                                        onPressed: ()
                                        {
                                          if(GalleryCubit.get(context).currentPageProduct <= GalleryCubit.get(context).totalPageProduct)
                                            GalleryCubit.get(context).listProductMore();
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Load More',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Icon(
                                              Icons.arrow_downward,
                                              size: 16.0,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if(state is GalleryListProductMoreLoading)
                                      CircularProgressIndicator(color: Colors.white,),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                              ],
                            ),
                        fallbackBuilder: (context) => Column(
                              children: [
                                ListView.separated(
                                  controller: controller,
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index)=>buildProduct(GalleryCubit.get(context).searchP[index], context,),
                                    separatorBuilder: (context, index)=> Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                      child: Divider(color: Colors.grey[400],),
                                    ),
                                    itemCount: GalleryCubit.get(context).searchP.length
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Stack(
                                  alignment: Alignment.center,
                                  children:
                                  [
                                    Container(),
                                    if(state is! GalleryListProductMoreLoading && GalleryCubit.get(context).currentPageProduct <= GalleryCubit.get(context).totalPageProduct)
                                      MaterialButton(
                                        height: 40.0,
                                        color: Colors.white,
                                        onPressed: ()
                                        {
                                          if(GalleryCubit.get(context).currentPageProduct <= GalleryCubit.get(context).totalPageProduct)
                                            GalleryCubit.get(context).listProductMore();
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Load More',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Icon(
                                              Icons.arrow_downward,
                                              size: 16.0,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if(state is GalleryListProductMoreLoading)
                                      CircularProgressIndicator(color: Colors.white,),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                              ],
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
              } else {
                _showDialogCreate(
                  context: context,
                  text: 'Add Product',
                  function: (){
                      GalleryCubit.get(context).createProduct(
                          ar: arNameController.text,
                          en: enNameController.text,
                          cost: costController.text,
                          availabilty: _mySelectionAvailable,
                        thumb:  GalleryCubit.get(context).imageName,
                      );
                       print('thumb : ${GalleryCubit.get(context).imageName}');
                    Navigator.pop(context);
                  },
                );
              }
            },
            child: Icon(GalleryCubit.get(context).fabIcon),
          ),
        );
      },
    );
  }

 buildProduct(product, context)=> Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0),
    alignment: Alignment.center,
    color: Colors.black45,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: 100,
          child: ('${product['thumb']}' == 0 )?
          Container() :
          Image(image: NetworkImage('http://18.221.253.60:83${product['thumb']}'),fit: BoxFit.fill,)
        ),
        SizedBox(width: 15.0,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${product['name']['ar']}',
              style: TextStyle(color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(width: 15.0,),
            Text(
              '${product['name']['en']}',
              style: TextStyle(color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        Spacer(),
        IconButton(onPressed: (){
          setState(() {
            GalleryCubit.get(context).deleteProduct(
                id: '${product['id']}'
            );
          });

        }, icon: Icon(Icons.delete,color: Colors.white,)),
        IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_sharp,color: Colors.white,))
      ],
    ),
  );
  Future _showDialogCreate({context, text, function,formkey}) async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Form(
          key: formkey,
          child: SingleChildScrollView(
            child: AlertDialog(
              title: Text('Create Product'),
              content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          child: Column(
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
                              SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                height: 55.0,
                                alignment: AlignmentDirectional.center,
                                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.white),
                                child: DropdownButton(
                                  hint: Text('Available'),
                                  menuMaxHeight: 140.0,
                                  key: dropBottonKeyAvailable,
                                  isExpanded: true,
                                  items: available.map((item) {
                                    return new DropdownMenuItem(
                                      child: new Text(item),
                                      value: item.toString(),
                                    );
                                  }).toList(),
                                  onChanged: (String? newVal) {
                                    setState(() {
                                      _mySelectionAvailable = newVal;
                                    });
                                  },
                                  value: _mySelectionAvailable,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              FlatButton(
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(120)),
                                onPressed: (){
                                  GalleryCubit.get(context).getImage();
                                },
                                child: Text(
                                  'Choose Image',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              FlatButton(
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(120)),
                                onPressed: function,
                                child: Text(
                                  text,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        FlatButton(
                            child: Text('cancel'),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ]);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
