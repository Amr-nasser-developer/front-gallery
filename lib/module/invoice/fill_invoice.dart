import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallary/layout/cubit/cubit.dart';
import 'package:gallary/layout/cubit/state.dart';

class FillInvoice extends StatefulWidget {
  @override
  _FillInvoiceState createState() => _FillInvoiceState();
}

class _FillInvoiceState extends State<FillInvoice> {
  String? _mySelectionDepartment;
  GlobalKey<dynamic> dropBottonKeyDepartment = GlobalKey();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<GalleryCubit, GalleryStates>(
      listener: (context, state) {
        if(state is GalleryPostFillInVoiceSuccess){
          Fluttertoast.showToast(
              msg: 'Task Assigned To Department',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'InVoice Details',
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            backgroundColor: Colors.indigo.shade900,),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Count Invoice : ${GalleryCubit.get(context).FillInvoice.length}'
                  ,style: TextStyle(color: Colors.white, fontSize: 18.0),),
                SizedBox(height: 15.0,),
                Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    height: height * 0.80,
                    width: width * 0.95,
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child: Conditional.single(
                      context: context,
                      conditionBuilder: (context)=> state is! GalleryListFillInVoiceLoading,
                      widgetBuilder: (context) => SingleChildScrollView(
                        child: Container(
                          height: height * 0.90,
                          child: ListView.separated(
                            itemCount: GalleryCubit.get(context).FillInvoice.length,
                            itemBuilder: (context, index) => viewFillInvoice(
                                GalleryCubit.get(context).FillInvoice[index], width ,height, state),
                            separatorBuilder: (context, index) => Divider(
                              color: Colors.black,
                              height: 10,
                            ),
                          ),
                        ),
                      ),
                      fallbackBuilder: (context) => Center(
                        child: CircularProgressIndicator(),
                      ),
                    )),
                SizedBox(height: 10.0,),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget viewFillInvoice(fillInvoice, width , height,state) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Container(
      height: height * 0.45,
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            if(fillInvoice['department_id'] == null)  CircleAvatar(
                radius: 16.0,
                child:  IconButton(
                    onPressed: (){
                      _showDialogFill(
                        context: context,
                        fillInvoice: fillInvoice['id'],
                          fillInvoiceId: fillInvoice['invoice_id'],
                        state: state
                      );
                    },
                    icon: Icon(Icons.done,size: 16.0,)
                ),
              ),
              if(fillInvoice['department_id'] != null) Row(
                children: [
                  Icon(Icons.done,color: Colors.green,),
                  Text('Done', style: TextStyle(color: Colors.green),),
                ],
              ),
                SizedBox(height: 5.0,),
              if(fillInvoice['product'] != null)Container(
                  height: 150,
                  width: 150,
                  child: Image(image: NetworkImage('http://18.221.253.60:83${fillInvoice['product']['thumb']}'),fit: BoxFit.fill,)
              ),
              if(fillInvoice['product'] == null)Text('No Image', style: TextStyle(color: Colors.red),),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [

                  Text(
                    'Description : ',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    '${fillInvoice['description']}',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.0,),
              Row(
                children: [
                  Text(
                    'Dimentions : ',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    '${fillInvoice['dimentions']}',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.0,),
              if (fillInvoice['product'] != null)
                Row(
                  children: [
                    Text(
                      'Product Name : ',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${fillInvoice['product']['name']['ar']}',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: 5.0,
              ),
              if (fillInvoice['product'] == null)Text(
                'No Product Details!!!',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              if (fillInvoice['product'] != null)Row(
                children: [
                  Text(
                    'Product Cost : ',
                    style: TextStyle(
                        fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${fillInvoice['product']['cost']} LE',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              if (fillInvoice['product'] == null)Text(
                'No Product Details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            ],
          ),
    ),
  );

  Future _showDialogFill({context, fillInvoice,fillInvoiceId, state }) async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text('Post Task'),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Column(
                      children: [
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
                            key: dropBottonKeyDepartment,
                            isExpanded: true,
                            items:
                            GalleryCubit.get(context).viewDepartment.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item['name']['en']),
                                value: item['id'].toString(),
                              );
                            }).toList(),
                            onChanged: (String? newVal) {
                              setState(() {
                                _mySelectionDepartment = newVal;
                              });
                            },
                            value: _mySelectionDepartment,
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
                            GalleryCubit.get(context).postFillInVoice(
                              department_id: _mySelectionDepartment,
                              invoice: fillInvoice
                            );
                            Navigator.pop(context);
                            GalleryCubit.get(context).listFillInVoice(inVoiceId: fillInvoiceId);
                          },
                          child: Text(
                            'Confirm',
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
