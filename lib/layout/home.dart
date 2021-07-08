import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:gallary/module/calculation/calculation_screen.dart';
import 'package:gallary/module/customer/customer_screen.dart';
import 'package:gallary/module/department/department_screen.dart';
import 'package:gallary/module/invoice/invoice_screen.dart';
import 'package:gallary/module/login/login_screen.dart';
import 'package:gallary/module/product/product_screen.dart';
import 'package:gallary/module/task/task_screen.dart';
import 'package:gallary/module/type/type_screen.dart';
import 'package:gallary/module/user/user_screen.dart';
import 'package:gallary/shared/components.dart';
import 'package:gallary/shared/network/local/cash.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _scanBarcode ;

  String roles = CashHelper.getData(key: 'role');

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery',style: TextStyle(color: Colors.white,fontSize: 24.0),),
        actions: [
          IconButton(
              onPressed: () async {
                  String barcodeScanRes;
                  try {
                    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                        '#ff6666', 'Cancel', true, ScanMode.QR);
                    print(barcodeScanRes);
                  } on PlatformException {
                    barcodeScanRes = 'Failed to get platform version.';
                  }
                  if (!mounted) return;

                  setState(() {
                    _scanBarcode = barcodeScanRes;
                  });
              },
              icon: Icon(Icons.qr_code_scanner, color: Colors.white,)
          ),
          SizedBox(width: 20,),
          TextButton(onPressed: (){
            finishNavigate(
                context: context,
                widget: LoginPage()
            );
          }, child: Row(
            children: [
              TextButton(child: Text('LogOut',style: TextStyle(color: Colors.white),),
              onPressed: () {
                CashHelper.removeData(key: 'token').then((value){
                 print('token removed');
                  CashHelper.removeData(key: 'role');
                 print('token role');
                  finishNavigate(context: context , widget: LoginPage());
                });
              }
              ),
              Icon(Icons.logout,color: Colors.white,),
            ],
          ))
        ],
        backgroundColor: Colors.indigo.shade900,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 30.0),
          child: (roles == 'admin')?
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        defaultNavigate(context: context , widget: DepartmentScreen());
                      },
                      child: Container(
                        height: 100.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.pink
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.work_sharp ,color: Colors.white,),
                            Text(
                              'Department',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        defaultNavigate(context: context , widget: UserScreen());
                      },
                      child: Container(
                        height: 100.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.pink
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.supervisor_account_sharp ,color: Colors.white,),
                            Text(
                              'Users',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        defaultNavigate(context: context , widget: ProductScreen());
                      },
                      child: Container(
                        height: 100.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.pink
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_cart ,color: Colors.white,),
                            Text(
                              'Products',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        defaultNavigate(context: context , widget: InVoiceScreen());
                      },
                      child: Container(
                        height: 100.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.pink
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.wallpaper ,color: Colors.white,),
                            Text(
                              'Invoices',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        defaultNavigate(context: context , widget: TypeScreen());
                      },
                      child: Container(
                        height: 100.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.pink
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.merge_type ,color: Colors.white,),
                            Text(
                              'Type',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        defaultNavigate(context: context , widget: CalculationScreen());
                      },
                      child: Container(
                        height: 100.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.pink
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.calculate_outlined ,color: Colors.white,),
                            Text(
                              'Calculation',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        defaultNavigate(context: context , widget: CustomerScreen());
                      },
                      child: Container(
                        height: 100.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.pink
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person ,color: Colors.white,),
                            Text(
                              'Customers',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                      child: GestureDetector(
                        onTap: (){
                          defaultNavigate(context: context, widget: TaskScreen());
                        },
                        child: Container(
                          height: 100.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.pink
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.workspaces_filled ,color: Colors.white,),
                              Text(
                                'Tasks',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  )

                ],
              ),
            ],
          )
              : Text('no data')

        ),
      )
    );
  }
}
