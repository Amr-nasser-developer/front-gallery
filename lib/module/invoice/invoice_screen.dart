import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallary/layout/cubit/cubit.dart';
import 'package:gallary/layout/cubit/state.dart';
import 'package:gallary/module/invoice/fill_invoice.dart';
import 'package:gallary/shared/components.dart';
import 'package:textfield_search/textfield_search.dart';

class InVoiceScreen extends StatefulWidget {
  @override
  _InVoiceScreen createState() => _InVoiceScreen();
}

class _InVoiceScreen extends State<InVoiceScreen> {
  TextEditingController myController2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    myController2.addListener(_printLatestValue);
  }

  _printLatestValue() {
    print("text field: ${myController2.text}");
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController2.dispose();
    super.dispose();
  }
  var searchController = TextEditingController();
  List itemsSize = ['original', 'custom'];
  String? _mySelectionType;
  String? _mySelectionSize;
  String? _mySelectionCustomer;
  String? _mySelectionProduct;
  GlobalKey<dynamic> dropBottonKeyType = GlobalKey();
  GlobalKey<dynamic> dropBottonKeyProduct = GlobalKey();
  GlobalKey<dynamic> dropBottonKeySize = GlobalKey();
  GlobalKey<dynamic> dropBottonKeyCustomer = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  GlobalKey<FormState> formKey = GlobalKey();
  final widthController = TextEditingController();
  final descriptionController = TextEditingController();
  final heightController = TextEditingController();
  bool? checkedValue = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<GalleryCubit, GalleryStates>(
      listener: (context, state) {
        if (state is GalleryUpdateInVoiceSuccess) {
          Fluttertoast.showToast(
              msg: 'Update InVoice Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          GalleryCubit.get(context).listInVoice(CreateInvoiceSuccess: true);
        }
        if (state is GalleryCreateFillInVoiceSuccess) {
          Fluttertoast.showToast(
              msg: 'Fill Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          GalleryCubit.get(context).listInVoice(CreateInvoiceSuccess: true);
        }

        if (state is GalleryCreateInVoiceSuccess) {
          Fluttertoast.showToast(
              msg: 'Create InVoice Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          GalleryCubit.get(context).listInVoice(CreateInvoiceSuccess: true);
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(
              'InVoices',
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            backgroundColor: Colors.indigo.shade900,
          ),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        SingleChildScrollView(
                          child: Container(
                              width: width * 0.99,
                              height: height * 0.50,
                              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              alignment: Alignment.center,
                              color: Colors.white,
                              child: Conditional.single(
                                context: context,
                                conditionBuilder: (context)=> state is! GalleryListInVoiceLoading,
                                widgetBuilder: (context) => SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: width * 0.96,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Customer\nArabic\nName',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'Customer\nEnglish\nName',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'Phone',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '        Size',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        SingleChildScrollView(
                                          child: Container(
                                            height: height * 0.50,
                                            width: width * 1.2,
                                            child: ListView.separated(
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) =>
                                                    InVoiceTable(
                                                        GalleryCubit.get(context)
                                                            .viewInVoice[index],
                                                        context,
                                                        width,
                                                        state,
                                                    ),
                                                separatorBuilder:
                                                    (context, index) => Divider(
                                                          height: 2,
                                                        ),
                                                itemCount: GalleryCubit.get(context)
                                                    .viewInVoice
                                                    .length),
                                          ),
                                        ),
                                        Stack(
                                          alignment: Alignment.center,
                                          children:
                                          [
                                            Container(),
                                            if(state is! GalleryListInVoiceMoreLoading && GalleryCubit.get(context).currentPageInvoice <= GalleryCubit.get(context).currentTotalPageInvoice)
                                              MaterialButton(
                                                height: 40.0,
                                                color: Colors.white,
                                                onPressed: ()
                                                {
                                                  if(GalleryCubit.get(context).currentPageInvoice <= GalleryCubit.get(context).currentTotalPageInvoice)
                                                    GalleryCubit.get(context).listInvoiceMore();
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
                                            if(state is GalleryListInVoiceMoreLoading)
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
                                fallbackBuilder: (context) => Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ])),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (GalleryCubit.get(context).isBottomSheetShownn) {
                if (formKey.currentState!.validate()) {}
              } else {
                _showDialog(
                    context: context,
                    function: () {
                      if (formKey.currentState!.validate()) {
                        GalleryCubit.get(context).createInVoice(
                            type_id: _mySelectionType,
                            customer_id: _mySelectionCustomer,
                            high: heightController.text,
                            width: widthController.text,
                            size: _mySelectionSize);
                        Navigator.pop(context);
                        heightController.clear();
                        widthController.clear();
                      }
                    },
                    text: 'Add InVoice');
              }
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }

  Widget InVoiceTable(model, context, width, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onDoubleTap: () {
              GalleryCubit.get(context).listFillInVoice(inVoiceId: '${model['id']}');
              defaultNavigate(context: context , widget: FillInvoice());
            },
            onTap: () {
              _showDialogCreateFill(
                  width: width,
                  text: 'Fill',
                  function: () {
                    if (formKey.currentState!.validate()) {
                      GalleryCubit.get(context).createFillInVoice(
                        description: descriptionController.text,
                        inVoiceId: '${model['id']}',
                        product_id: _mySelectionProduct,
                      );
                      Navigator.pop(context);
                      descriptionController.clear();
                    }
                  },
                  context: context);
            },
            child: Container(
              width: width * 1.2,
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Text('${model['customers']['name']['ar']}')),
                  Expanded(child: Text('${model['customers']['name']['en']}')),
                  Expanded(child: Text('${model['customers']['phone']}')),
                  Expanded(child: Text('        ${model['size']}')),
                  Expanded(
                    child: CircleAvatar(
                      child: IconButton(
                        icon: Icon(
                          Icons.update,
                          size: 16.0,
                        ),
                        onPressed: () {
                          _showDialogUpdate(
                              context: context,
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  GalleryCubit.get(context).updateInVoice(
                                      type_id: _mySelectionType,
                                      customer_id: _mySelectionCustomer,
                                      high: heightController.text,
                                      width: widthController.text,
                                      size: _mySelectionSize,
                                      id: model['id']);
                                  Navigator.pop(context);
                                  heightController.clear();
                                  widthController.clear();
                                }
                              },
                              text: 'Update InVoice');
                        },
                      ),
                      radius: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      );
  Widget dropButton({selectedItemInVoice, function, item, items}) => Container(
        height: 20.0,
        child: ListView.separated(
          itemBuilder: (context, state) => Container(
            height: 55.0,
            alignment: AlignmentDirectional.center,
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white),
            child: DropdownButton<String>(
              menuMaxHeight: 120.0,
              hint: Text('role'),
              value: selectedItemInVoice,
              icon: const Icon(
                Icons.arrow_downward,
                color: Colors.black38,
                size: 20,
              ),
              isExpanded: true,
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              onChanged: function,
              items: (item['name']['ar'])
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
            ),
          ),
          itemCount: items,
          separatorBuilder: (context, state) => Divider(
            height: 1.0,
          ),
        ),
      );
  Future _showDialog({context, text, function}) async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text('Create InVoice'),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Column(
                      children: [
                        defaultTextField(
                            validatorText: 'Enter The Width',
                            hint: 'Width',
                            type: TextInputType.number,
                            function: widthController),
                        SizedBox(
                          height: 5.0,
                        ),
                        defaultTextField(
                            validatorText: 'Enter The Height',
                            hint: 'Height',
                            type: TextInputType.number,
                            function: heightController),
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
                            hint: Text('Customer'),
                            menuMaxHeight: 140.0,
                            key: dropBottonKeyCustomer,
                            isExpanded: true,
                            items:
                                GalleryCubit.get(context).customer.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item['name']['en']),
                                value: item['id'].toString(),
                              );
                            }).toList(),
                            onChanged: (String? newVal) {
                              setState(() {
                                _mySelectionCustomer = newVal;
                              });
                            },
                            value: _mySelectionCustomer,
                          ),
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
                            hint: Text('Size'),
                            menuMaxHeight: 140.0,
                            key: dropBottonKeySize,
                            isExpanded: true,
                            items: itemsSize.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item),
                                value: item.toString(),
                              );
                            }).toList(),
                            onChanged: (String? newVal) {
                              setState(() {
                                _mySelectionSize = newVal;
                              });
                            },
                            value: _mySelectionSize,
                          ),
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
                            hint: Text('Type'),
                            menuMaxHeight: 140.0,
                            key: dropBottonKeyType,
                            isExpanded: true,
                            items:
                                GalleryCubit.get(context).viewType.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item['name']['en']),
                                value: item['id'].toString(),
                              );
                            }).toList(),
                            onChanged: (String? newVal) {
                              setState(() {
                                _mySelectionType = newVal;
                              });
                            },
                            value: _mySelectionType,
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
        );
      },
    );
  }

  Future _showDialogUpdate({context, text, function}) async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text('Update InVoice'),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Column(
                      children: [
                        defaultTextField(
                            validatorText: 'Enter The Width',
                            hint: 'Width',
                            type: TextInputType.number,
                            function: widthController),
                        SizedBox(
                          height: 5.0,
                        ),
                        defaultTextField(
                            validatorText: 'Enter The Height',
                            hint: 'Height',
                            type: TextInputType.number,
                            function: heightController),
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
                            hint: Text('Customer'),
                            menuMaxHeight: 140.0,
                            key: dropBottonKeyCustomer,
                            isExpanded: true,
                            items:
                                GalleryCubit.get(context).customer.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item['name']['en']),
                                value: item['id'].toString(),
                              );
                            }).toList(),
                            onChanged: (String? newVal) {
                              setState(() {
                                _mySelectionCustomer = newVal;
                              });
                            },
                            value: _mySelectionCustomer,
                          ),
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
                            hint: Text('Size'),
                            menuMaxHeight: 140.0,
                            key: dropBottonKeySize,
                            isExpanded: true,
                            items: itemsSize.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item),
                                value: item.toString(),
                              );
                            }).toList(),
                            onChanged: (String? newVal) {
                              setState(() {
                                _mySelectionSize = newVal;
                              });
                            },
                            value: _mySelectionSize,
                          ),
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
                            hint: Text('Type'),
                            menuMaxHeight: 140.0,
                            key: dropBottonKeyType,
                            isExpanded: true,
                            items:
                                GalleryCubit.get(context).viewType.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item['name']['en']),
                                value: item['id'].toString(),
                              );
                            }).toList(),
                            onChanged: (String? newVal) {
                              setState(() {
                                _mySelectionType = newVal;
                              });
                            },
                            value: _mySelectionType,
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
        );
      },
    );
  }

  Future _showDialogCreateFill({context, text, function, width}) async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            width: width * 0.25,
            child: AlertDialog(
              title: Text('Fill InVoice'),
              content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Column(mainAxisSize: MainAxisSize.min, children: <
                      Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Column(
                        children: [
                          defaultTextField(
                              validatorText: 'Description',
                              hint: 'Description',
                              max: 4,
                              type: TextInputType.name,
                              function: descriptionController),
                          SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            height: 55.0,
                            alignment: AlignmentDirectional.center,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white),
                            child: DropdownButton(
                              hint: Text('Product'),
                              menuMaxHeight: 140.0,
                              key: dropBottonKeyProduct,
                              isExpanded: true,
                              items: GalleryCubit.get(context)
                                  .viewProduct
                                  .map((item) {
                                return new DropdownMenuItem(
                                  child:
                                      new Text(item['name']['en'].toString()),
                                  value: item['id'].toString(),
                                );
                              }).toList(),
                              onChanged: (String? Val) {
                                setState(() {
                                  _mySelectionProduct = Val;
                                });
                              },
                              value: _mySelectionProduct,
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
