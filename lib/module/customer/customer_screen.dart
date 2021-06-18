import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/layout/cubit/cubit.dart';
import 'package:gallary/layout/cubit/state.dart';
import 'package:gallary/shared/components.dart';

class CustomerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    double height = MediaQuery.of(context).size.height;
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    GlobalKey<FormState> formKey = GlobalKey();
    var arNameController = TextEditingController();
    var enNameController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocConsumer<GalleryCubit, GalleryStates>(
      listener: (context, state) {
        if (state is GalleryCreateCustomerSuccess) {
          GalleryCubit.get(context).getCustomer();
        }
        if (state is GalleryDeleteCustomerSuccess) {
          GalleryCubit.get(context).getCustomer();
        }
        if (state is GalleryCreateCustomerLoading) {
          Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is GalleryDeleteCustomerSuccess) {
          print('DeleteCustomerSuccess');
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'inputData';
                      }
                      return null;
                    },
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (value) {},
                    onChanged: (value) {
                      print(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Search',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 300.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: 15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Text(
                                'Id',
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
                                'Phone',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 24.0),
                              )),
                              Expanded(
                                  child: Text(
                                '        ',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 24.0),
                              )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Expanded(
                          child: ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) => customerTable(
                                  GalleryCubit.get(context).customer[index],
                                  context),
                              separatorBuilder: (context, index) => Divider(
                                    height: 2,
                                  ),
                              itemCount:
                                  GalleryCubit.get(context).customer.length),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (GalleryCubit.get(context).isBottomSheetShown) {
                if (formKey.currentState!.validate()) {}
              } else {
                scaffoldKey.currentState!
                    .showBottomSheet(
                      (context) => Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(
                          20.0,
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defaultTextField(
                                  validatorText: 'Enter Your ArabicName',
                                  hint: 'ArabicName',
                                  type: TextInputType.name,
                                  function: arNameController),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              defaultTextField(
                                  validatorText: 'Enter Your EnglishName',
                                  hint: 'EnglishName',
                                  type: TextInputType.name,
                                  function: enNameController),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              defaultTextField(
                                  validatorText: 'Enter Your Mobile Number',
                                  hint: 'Phone',
                                  function: phoneController,
                                  type: TextInputType.phone),
                              SizedBox(
                                height: height * 0.04,
                              ),
                              ConditionalBuilder(
                                condition: state is! GalleryCreateCustomerLoading,
                                builder: (context) => FlatButton(
                                  color: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(120)),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      GalleryCubit.get(context).createCustomer(
                                          arName: arNameController.text,
                                          enName: enNameController.text,
                                          phone: phoneController.text);
                                    }
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'ADD',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                fallback: (context) => Center(
                                  child: CircularProgressIndicator(),
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
                  GalleryCubit.get(context).changeBottomSheetState(
                    isShow: false,
                    icon: Icons.edit,
                  );
                });

                GalleryCubit.get(context).changeBottomSheetState(
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

  Widget customerTable(model, context) => Column(
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
                Expanded(child: Text('${model['id']}')),
                Expanded(child: Text('${model['name']['ar']}')),
                Expanded(child: Text('${model['name']['en']}')),
                Expanded(child: Text('${model['phone']}')),
                Expanded(
                    child: IconButton(
                        onPressed: () {
                          GalleryCubit.get(context)
                              .deleteCustomer(id: model['id']);
                        },
                        icon: Icon(Icons.delete))),
              ],
            ),
          )
        ],
      );
}