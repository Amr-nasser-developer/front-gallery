import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallary/layout/cubit/cubit.dart';
import 'package:gallary/layout/cubit/state.dart';
import 'package:gallary/shared/components.dart';

class CustomerScreen extends StatefulWidget {
  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {

  ScrollController controller = ScrollController();
  BuildContext? blocContext;

  // @override
  // void initState()
  // {
  //   super.initState();
  //
  //   controller.addListener(()
  //   {
  //     if (controller.offset >= controller.position.maxScrollExtent &&
  //         !controller.position.outOfRange)
  //     {
  //       print('bottom bottom');
  //
  //       if(GalleryCubit.get(blocContext).currentPageCustomer <= GalleryCubit.get(blocContext).totalPageCustomer)
  //         GalleryCubit.get(blocContext).listCustomerMore();
  //     }
  //   });
  // }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  GlobalKey<FormState> formKey = GlobalKey();

  final enNameController = TextEditingController();

  final arNameController = TextEditingController();

  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<GalleryCubit, GalleryStates>(
      listener: (context, state) {
        if (state is GalleryDeleteCustomerSuccess) {
          Fluttertoast.showToast(
              msg: 'Delete Customer Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
           GalleryCubit.get(context).getCustomer(CreateCustomerSuccess: true);
        }
        if (state is GalleryCreateCustomerSuccess) {
          Fluttertoast.showToast(
              msg: 'Create Customer Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
           GalleryCubit.get(context).getCustomer(CreateCustomerSuccess: true);
          setState(() {

          });
        }
        if (state is GalleryUpdateCustomerSuccess) {
          Fluttertoast.showToast(
              msg: 'Update Customer Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          GalleryCubit.get(context).getCustomer(CreateCustomerSuccess: true);
        }
      },
      builder: (context, state) {
        blocContext = context;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.indigo.shade900,
            title: Text(
              'Customer',
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    style: TextStyle(
                        color: Colors.white
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'inputData';
                      }
                      return null;
                    },
                    controller: GalleryCubit.get(context).searchCustomerController,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (value) {},
                    onChanged: (value) {
                      GalleryCubit.get(context).searchCustomer(value);
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
                    width: width * 0.99,
                      height: height * 0.50,
                      alignment: Alignment.topCenter,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Conditional.single(
                          context: context,
                          conditionBuilder: (context)=> state is! GallerySearchCustomerSuccess,
                          widgetBuilder: (context)=> SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:width * 0.75,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: Text(
                                              '   Arabic\n   Name',
                                              style: TextStyle(
                                                  color: Colors.black, fontWeight: FontWeight.bold),
                                            )),
                                        Expanded(

                                            child: Text(
                                              'English\nName',
                                              style: TextStyle(
                                                  color: Colors.black, fontWeight: FontWeight.bold),
                                            )),
                                        Expanded(

                                            child: Text(
                                              'phone',
                                              style: TextStyle(
                                                  color: Colors.black, fontWeight: FontWeight.bold),
                                            )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  SingleChildScrollView(
                                    child: Container(
                                      height: height*0.50,
                                      width: width * 1.2,
                                      child: ListView.separated(
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) => customerSearch(
                                            GalleryCubit.get(context)
                                                .customer[index],
                                            context,
                                            width
                                          ),
                                          separatorBuilder: (context, index) => Divider(
                                            height: 2,
                                          ),
                                          itemCount: GalleryCubit.get(context)
                                              .customer
                                              .length),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Stack(
                                    alignment: Alignment.center,
                                    children:
                                    [
                                      Container(),
                                      if(state is! GalleryListCustomerMoreLoading && GalleryCubit.get(context).currentPageCustomer < GalleryCubit.get(context).totalPageCustomer)
                                        MaterialButton(
                                          height: 40.0,
                                          color: Colors.white,
                                          onPressed: ()
                                          {
                                            if(GalleryCubit.get(context).currentPageCustomer < GalleryCubit.get(context).totalPageCustomer)
                                              GalleryCubit.get(context).listCustomerMore();
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
                                      if(state is GalleryListCustomerMoreLoading)
                                        CircularProgressIndicator(),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.0,
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
                                  Container(
                                    width: width * 0.75,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: Text(
                                              '   Arabic\n   Name',
                                              style: TextStyle(
                                                  color: Colors.black, fontWeight: FontWeight.bold),
                                            )),
                                        Expanded(
                                            child: Text(
                                              'English\nName',
                                              style: TextStyle(
                                                  color: Colors.black, fontWeight: FontWeight.bold),
                                            )),
                                        Expanded(
                                            child: Text(
                                              'phone',
                                              style: TextStyle(
                                                  color: Colors.black, fontWeight: FontWeight.bold),
                                            )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  SingleChildScrollView(
                                    child: Container(
                                      height: height*0.50,
                                      width: width * 1.2,
                                      child: ListView.separated(
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) => customerSearch(
                                              GalleryCubit.get(context)
                                                  .searchC[index],
                                              context,
                                              width
                                          ),
                                          separatorBuilder: (context, index) => Divider(
                                            height: 2,
                                          ),
                                          itemCount: GalleryCubit.get(context)
                                              .searchC
                                              .length),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Stack(
                                    alignment: Alignment.center,
                                    children:
                                    [
                                      Container(),
                                      if(state is! GalleryListCustomerMoreLoading && GalleryCubit.get(context).currentPageCustomer <= GalleryCubit.get(context).totalPageCustomer)
                                        MaterialButton(
                                          height: 40.0,
                                          color: Colors.white,
                                          onPressed: ()
                                          {
                                            if(GalleryCubit.get(context).currentPageCustomer <= GalleryCubit.get(context).totalPageCustomer)
                                              GalleryCubit.get(context).listCustomerMore();
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
                                      if(state is GalleryListCustomerMoreLoading)
                                        CircularProgressIndicator(),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                ],
                              ),
                            )
                          ),
                        ),
                      )
                  ),
                )
              ],
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
                              validatorText: 'Enter Your Phone',
                              hint: 'Phone',
                              type: TextInputType.number,
                              function: phoneController),
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
                                GalleryCubit.get(context).createCustomer(
                                  arName: arNameController.text,
                                  enName: enNameController.text,
                                  phone: phoneController.text,
                                );
                              }
                              Navigator.pop(context);
                            },
                            child: Text('Add Customer',style: TextStyle(color: Colors.white),),
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

  Widget customerSearch(search, context, width) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        width: width * 1.2,
        alignment: Alignment.center,
        padding: EdgeInsetsDirectional.only(start: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Text('${search['name']['ar']}')),
            Expanded(child: Text('${search['name']['en']}')),
            Expanded(child: Text('${search['phone']}')),
            Expanded(
              child: IconButton(
                  onPressed: () {
                    GalleryCubit.get(context)
                        .deleteCustomer(id: search['id']);
                  },
                  icon: Icon(      Icons.delete)),
            ),
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
                                  defaultTextField(
                                      validatorText: 'Enter Your Phone',
                                      hint: 'Phone',
                                      type: TextInputType.number,
                                      function: phoneController),
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
                                          GalleryCubit.get(context).updateCustomer(
                                            phone: phoneController.text,
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
                    )
                ),
                radius: 16.0,
              ),
            ),
          ],
        ),
      )
    ],
  );
}
