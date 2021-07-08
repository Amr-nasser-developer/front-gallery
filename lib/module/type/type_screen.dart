import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallary/layout/cubit/cubit.dart';
import 'package:gallary/layout/cubit/state.dart';
import 'package:gallary/shared/components.dart';

class TypeScreen extends StatelessWidget {
  var searchController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  GlobalKey<FormState> formKey = GlobalKey();
  final enNameController = TextEditingController();
  final arNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<GalleryCubit, GalleryStates>(
      listener: (context, state) {
        if (state is GalleryDeleteTypeSuccess) {
          Fluttertoast.showToast(
              msg: 'Delete Type Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          GalleryCubit.get(context).listType();
        }
        if (state is GalleryUpdateTypeSuccess) {
          Fluttertoast.showToast(
              msg: 'Update Type Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          GalleryCubit.get(context).listType();
        }

        if (state is GalleryCreateTypeSuccess) {
          Fluttertoast.showToast(
              msg: 'Create Type Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          GalleryCubit.get(context).listType();
        }
      },

      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title:Text('Types',style: TextStyle(
                fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),),
            backgroundColor: Colors.indigo.shade900,
          ),
          body: SingleChildScrollView(
            reverse: false,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: width * 0.99,
                    height: height * 0.50,
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                      alignment: Alignment.topCenter,
                    color: Colors.white,
                      child: Conditional.single(
                        context: context,
                        conditionBuilder: (context)=> state is! GallerySearchTypeSuccess ,
                        widgetBuilder: (context)=> SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.only(start: 15.0),
                                  child: Container(
                                    width: width * 0.45,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: Text(
                                              '   Arabic\n   Name',
                                              style: TextStyle(
                                                  color: Colors.black,fontWeight: FontWeight.bold),
                                            )),
                                        Expanded(
                                            child: Text(
                                              'English\nName',
                                              style: TextStyle(
                                                  color: Colors.black,fontWeight: FontWeight.bold),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                SingleChildScrollView(
                                  child: Container(
                                    height: height*0.50,
                                    width: width * 0.90,
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) => TypeTable(
                                          GalleryCubit.get(context).viewType[index],
                                          context,
                                          width
                                        ),
                                        separatorBuilder: (context, index) => Divider(
                                          height: 2,
                                        ),
                                        itemCount:
                                        GalleryCubit.get(context).viewType.length),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        fallbackBuilder: (context)=> SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.only(start: 15.0),
                                  child: Container(
                                    width: width * 0.45,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: Text(
                                              '   Arabic\n   Name',
                                              style: TextStyle(
                                                  color: Colors.black,fontWeight: FontWeight.bold ),
                                            )),
                                        Expanded(
                                            child: Text(
                                              'English\nName',
                                              style: TextStyle(
                                                  color: Colors.black,fontWeight: FontWeight.bold ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                SingleChildScrollView(
                                  child: Container(
                                    height: height*0.50,
                                    width: width * 0.9,
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) => TypeTable(
                                            GalleryCubit.get(context).searchY[index],
                                            context,
                                            width
                                        ),
                                        separatorBuilder: (context, index) => Divider(
                                          height: 2,
                                        ),
                                        itemCount:
                                        GalleryCubit.get(context).searchY.length),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ),
                      )
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
                          FlatButton(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(120)
                            ),
                            onPressed: (){
                              if(formKey.currentState!.validate()){
                                GalleryCubit.get(context).createType(
                                  ar: arNameController.text,
                                  en: enNameController.text,
                                );
                              }
                              Navigator.pop(context);
                            },
                            child: Text('Add Type',style: TextStyle(color: Colors.white),),
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

  Widget TypeTable(model, context, width) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        width: width * 0.9,
        alignment: Alignment.center,
        padding: EdgeInsetsDirectional.only(start: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Text('     ${model['name']['ar']}')),
            Expanded(child: Text('     ${model['name']['en']}')),
            Expanded(
                child: IconButton(
                    onPressed: () {
                      GalleryCubit.get(context)
                          .deleteType(id: model['id']);
                    },
                    icon: Icon(Icons.delete))),
            Expanded(
              child: CircleAvatar(
                child: IconButton(
                    onPressed: () {
                      if (GalleryCubit.get(context).isBottomSheetShownnn) {
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
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 80),
                                    child : FlatButton(
                                      color: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(120)
                                      ),
                                      onPressed: (){
                                        if(formKey.currentState!.validate()){
                                          GalleryCubit.get(context).updateType(
                                              enName: enNameController.text,
                                              arName: arNameController.text,
                                              id: '${model['id']}'
                                          );
                                        }
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
                          GalleryCubit.get(context).changeBottomSheetStateee(
                            isShow: false,
                            icon: Icons.edit,
                          );
                        });

                        GalleryCubit.get(context).changeBottomSheetStateee(
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
            ),
          ],
        ),
      )
    ],
  );
}
