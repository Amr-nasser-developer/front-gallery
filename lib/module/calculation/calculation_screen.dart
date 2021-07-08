import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallary/layout/cubit/cubit.dart';
import 'package:gallary/layout/cubit/state.dart';
import 'package:gallary/shared/components.dart';

class CalculationScreen extends StatefulWidget {
  @override
  _CalculationScreenState createState() => _CalculationScreenState();
}

class _CalculationScreenState extends State<CalculationScreen> {
  var searchController = TextEditingController();
  String? _mySelection;
  GlobalKey<dynamic> dropBottonKey = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  GlobalKey<FormState> formKey = GlobalKey();

  final typeIdController = TextEditingController();

  final cutController = TextEditingController();

  bool? checkedValue = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<GalleryCubit, GalleryStates>(
      listener: (context, state) {
        if (state is GalleryDeleteCalculationSuccess) {
          Fluttertoast.showToast(
              msg: 'Delete Calculation Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          GalleryCubit.get(context).listCalculation();
        }
        if (state is GalleryUpdateCalculationSuccess) {
          Fluttertoast.showToast(
              msg: 'Update Calculation Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          GalleryCubit.get(context).listCalculation();
        }

        if (state is GalleryCreateCalculationSuccess) {
          Fluttertoast.showToast(
              msg: 'Create Calculation Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          GalleryCubit.get(context).listCalculation();
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(
              'Calculations',
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
                        Container(
                          width: width * 0.99,
                          height: height * 0.50,
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          alignment: Alignment.topCenter,
                          color: Colors.white,
                          child: Conditional.single(
                            context : context,
                            conditionBuilder: (context) => state is! GalleryListCalculationLoading,
                            widgetBuilder: (context) => SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: width * 0.45,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'type_id',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                'cut',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold),
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
                                          height: height*0.50,
                                          width: width * 0.90,
                                          child: ListView.separated(
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) =>
                                                  CalculationTable(
                                                      GalleryCubit.get(context)
                                                          .viewCalculation[index],
                                                      context,
                                                      width),
                                              separatorBuilder: (context, index) =>
                                                  Divider(
                                                    height: 2,
                                                  ),
                                              itemCount: GalleryCubit.get(context)
                                                  .viewCalculation
                                                  .length),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            fallbackBuilder: (context)=> Center(child: CircularProgressIndicator(color: Colors.black,),),
                          )
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
                        GalleryCubit.get(context).createCalculation(
                          type_id: _mySelection,
                          cut: cutController.text,
                        );
                        Navigator.pop(context);
                        cutController.clear();
                      }
                    },
                    text: 'Add Calculation');
              }
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }

  Widget CalculationTable(model, context, width) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: width * 0.90,
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Text('${model['types']['name']['en']}')),
                Expanded(child: Text('${model['cut']}')),
                Expanded(
                    child: IconButton(
                        onPressed: () {
                          GalleryCubit.get(context)
                              .deleteCalculation(id: model['id']);
                        },
                        icon: Icon(Icons.delete))),
                Expanded(
                  child: CircleAvatar(
                    child: IconButton(
                      icon: Icon(
                        Icons.update,
                        size: 16.0,
                      ),
                      onPressed: () {
                        _showDialog(
                            context: context,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                GalleryCubit.get(context).updateCalculation(
                                    type_id: _mySelection,
                                    cut: cutController.text,
                                    id: model['id']);
                                Navigator.pop(context);
                                cutController.clear();
                              }
                            },
                            text: 'Update Calculation');
                      },
                    ),
                    radius: 16.0,
                  ),
                ),
              ],
            ),
          )
        ],
      );
  Widget dropButton({selectedItemCalculation, function, item, items}) =>
      Container(
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
              value: selectedItemCalculation,
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
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Column(
                      children: [
                        defaultTextField(
                            validatorText: 'Enter The Cut',
                            hint: 'Cut',
                            type: TextInputType.number,
                            function: cutController),
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
                            key: dropBottonKey,
                            isExpanded: true,
                            items: GalleryCubit.get(context).viewType.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item['name']['en']),
                                value: item['id'].toString(),
                              );
                            }).toList(),
                            onChanged: (String? newVal) {
                              setState(() {
                                _mySelection = newVal;
                              });
                            },
                            value: _mySelection,
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
}
