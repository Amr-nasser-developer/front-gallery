import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallary/layout/cubit/cubit.dart';
import 'package:gallary/layout/cubit/state.dart';
import 'package:gallary/shared/components.dart';


class DepartmentScreen extends StatelessWidget {
  var searchController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  GlobalKey<FormState> formKey = GlobalKey();
  final enNameController = TextEditingController();
  final arNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GalleryCubit, GalleryStates>(
      listener: (context, state) {
        if (state is GalleryDeleteDepartmentSuccess) {
          Fluttertoast.showToast(
              msg: 'Delete Department Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          GalleryCubit.get(context).listDepartment();
        }
        if (state is GalleryCreateDepartmentSuccess) {
          Fluttertoast.showToast(
              msg: 'Create Department Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          GalleryCubit.get(context).listDepartment();
        }
        if (state is GalleryUpdateDepartmentSuccess) {
          Fluttertoast.showToast(
              msg: 'Update Department Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          GalleryCubit.get(context).listDepartment();
        }
      },
      builder: (context, state) {
        var search = GalleryCubit.get(context).searchD;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.indigo.shade900,
            title: Text(
              'Department',
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'inputData';
                    }
                    return null;
                  },
                  controller: GalleryCubit.get(context).searchDepartmentController,
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (value) {},
                  onChanged: (value) {
                    GalleryCubit.get(context).searchDepartment(value);
                  },
                  decoration: InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white),
                  child: Padding(
                      padding: EdgeInsets.all(15.0),
                    child: ConditionalBuilder(
                      condition: state is! GallerySearchDepartmentSuccess,
                      builder: (context)=> Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Text(
                                    '  Id',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 24.0),
                                  )),
                              Expanded(
                                  child: Text(
                                    'Arabic Name',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 24.0),
                                  )),
                              Expanded(
                                  child: Text(
                                    'English Name',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 24.0),
                                  )),
                              Expanded(
                                  child: Text(
                                    '                 Delete       ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 24.0),
                                  )),
                              Expanded(
                                  child: Text(
                                    '                Update    ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 24.0),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) => departmentSearch(
                                GalleryCubit.get(context)
                                    .viewDepartment[index],
                                context,
                              ),
                              separatorBuilder: (context, index) => Divider(
                                height: 2,
                              ),
                              itemCount: GalleryCubit.get(context)
                                  .viewDepartment
                                  .length),
                        ],
                      ),
                      fallback: (context)=> Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Text(
                                    ' Id',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 24.0),
                                  )),
                              Expanded(
                                  child: Text(
                                    'Arabic Name',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 24.0),
                                  )),
                              Expanded(
                                  child: Text(
                                    'English Name',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 24.0),
                                  )),
                              Expanded(
                                  child: Text(
                                    '                 Delete       ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 24.0),
                                  )),
                              Expanded(
                                  child: Text(
                                    '                Update    ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 24.0),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) => departmentSearch(
                                GalleryCubit.get(context)
                                    .searchC[index],
                                context,
                              ),
                              separatorBuilder: (context, index) => Divider(
                                height: 2,
                              ),
                              itemCount: GalleryCubit.get(context)
                                  .searchC
                                  .length),
                        ],
                      ),
                    ),
                  )
                ),
              )
            ],
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
                                GalleryCubit.get(context).createDepartment(
                                  ar: arNameController.text,
                                  en: enNameController.text,
                                );
                              }
                              Navigator.pop(context);
                            },
                            child: Text('Add Department',style: TextStyle(color: Colors.white),),
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

  Widget departmentSearch(search, context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        alignment: Alignment.center,
        padding: EdgeInsetsDirectional.only(start: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Text('${search['id']}')),
            Expanded(child: Text('      ${search['name']['ar']}')),
            Expanded(child: Text('      ${search['name']['en']}')),
            Expanded(
                child: IconButton(
                    onPressed: () {
                      GalleryCubit.get(context)
                          .deleteDepartment(id: search['id']);
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
                                          GalleryCubit.get(context).updateDepartment(
                                              enName: enNameController.text,
                                              arName: arNameController.text,
                                              id: '${search['id']}'
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
