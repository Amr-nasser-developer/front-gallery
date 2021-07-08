import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:gallary/layout/cubit/cubit.dart';
import 'package:gallary/layout/cubit/state.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreen createState() => _TaskScreen();
}

class _TaskScreen extends State<TaskScreen> {
  String? _mySelectionDepartment;
  GlobalKey<dynamic> dropBottonKeyDepartment = GlobalKey();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<GalleryCubit, GalleryStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Tasks',
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            backgroundColor: Colors.indigo.shade900,
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Count Tasks : ${GalleryCubit.get(context).task.length}',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    height: height * 0.80,
                    width: width * 0.95,
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child: Conditional.single(
                      context: context,
                      conditionBuilder: (context)=> state is! GalleryListFillInVoiceLoading,
                      widgetBuilder: (context) => SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: height * 0.90,
                              child: ListView.separated(
                                itemCount: GalleryCubit.get(context).task.length,
                                itemBuilder: (context, index) => viewFillInvoice(
                                    GalleryCubit.get(context).task[index],
                                    width,
                                    height,
                                    state),
                                separatorBuilder: (context, index) => Divider(
                                  color: Colors.black,
                                  height: 10,
                                ),
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
                                if(state is! GalleryListTaskMoreLoading && GalleryCubit.get(context).currentPageTask <= GalleryCubit.get(context).totalPageTask)
                                  MaterialButton(
                                    height: 40.0,
                                    color: Colors.white,
                                    onPressed: ()
                                    {
                                      if(GalleryCubit.get(context).currentPageTask <= GalleryCubit.get(context).totalPageTask)
                                        GalleryCubit.get(context).listTaskMore();
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
                                if(state is GalleryListTaskMoreLoading)
                                  CircularProgressIndicator(color: Colors.white,),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      ),
                      fallbackBuilder: (context) => Center(child: CircularProgressIndicator(color: Colors.black,),),
                    )),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget viewFillInvoice(task, width, height, state) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          height: height * 0.50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // if(task['department_id'] == null)  CircleAvatar(
              //   radius: 16.0,
              //   child:  IconButton(
              //       onPressed: (){
              //         _showDialogFill(
              //             context: context,
              //             fillInvoice: fillInvoice['id'],
              //             fillInvoiceId: fillInvoice['invoice_id'],
              //             state: state
              //         );
              //       },
              //       icon: Icon(Icons.done,size: 16.0,)
              //   ),
              // ),
              // if(fillInvoice['department_id'] != null) Row(
              //   children: [
              //     Icon(Icons.done,color: Colors.green,),
              //     Text('Done', style: TextStyle(color: Colors.green),),
              //   ],
              // ),
              if(task['product'] != null)Container(
                  height: 150,
                  width: 150,
                  child: Image(image: NetworkImage('http://18.221.253.60:83${task['product']['thumb']}'),fit: BoxFit.fill,)
              ),
              if(task['product'] == null)Text('No Image', style: TextStyle(color: Colors.red),),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Text(
                    'Description : ',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${task['description']}',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Text(
                    'Dimentions : ',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${task['dimentions']}',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              if (task['product'] != null)
                Row(
                  children: [
                    Text(
                      'Product Name : ',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${task['product']['name']['ar']}',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: 5.0,
              ),
              if (task['product'] == null)Text(
                  'No Product Details!!!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
              SizedBox(
                height: 5.0,
              ),
              if (task['product'] != null)Row(
                  children: [
                    Text(
                      'Product Cost : ',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${task['product']['cost']} LE',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: 5.0,
              ),
              if (task['product'] == null)Text(
                  'No Product Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Text(
                    'Status : ',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${task['status']['name']}',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Text(
                    'Department Name : ',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${task['department']['name']['ar']}',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),


            ],
          ),
        ),
      );

  Future _showDialogFill({context, fillInvoice, fillInvoiceId, state}) async {
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
                            items: GalleryCubit.get(context)
                                .viewDepartment
                                .map((item) {
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
                          onPressed: () {
                            GalleryCubit.get(context).postFillInVoice(
                                department_id: _mySelectionDepartment,
                                invoice: fillInvoice);
                            if (state is GalleryPostFillInVoiceSuccess)
                              GalleryCubit.get(context)
                                  .listFillInVoice(inVoiceId: fillInvoiceId);
                            Navigator.pop(context);
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
