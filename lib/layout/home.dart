import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:gallary/module/customer/customer_screen.dart';
import 'package:gallary/module/department/department_screen.dart';
import 'package:gallary/module/invoice/invoice_screen.dart';
import 'package:gallary/module/login/login_screen.dart';
import 'package:gallary/module/product/product_screen.dart';
import 'package:gallary/module/search/search_screen.dart';
import 'package:gallary/module/setting/setting_screen.dart';
import 'package:gallary/module/user/user_screen.dart';
import 'package:gallary/shared/components.dart';
import 'package:gallary/shared/network/local/cash.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sallah',style: TextStyle(color: Colors.white,fontSize: 24.0),),
        actions: [
          IconButton(onPressed: (){
            defaultNavigate(context: context,widget: SearchScreen());
          }, icon: Icon(Icons.search,color: Colors.white,)),
          TextButton(onPressed: (){
            finishNavigate(
                context: context,
                widget: LoginPage()
            );
          }, child: Row(
            children: [
              TextButton(child: Text('LogOut',style: TextStyle(color: Colors.white),),
              onPressed: () => CashHelper.removeData(key: 'token').then((value) => finishNavigate(context: context,widget: LoginPage())),
              ),
              Icon(Icons.logout,color: Colors.white,)
            ],
          ))
        ],
        backgroundColor: Colors.indigo.shade900,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHome(
                  name: 'Department',
                  iconData: Icons.work_sharp,
                function: (){
                    defaultNavigate(context: context ,widget: DepartmentScreen());
                }
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Divider(height: height*0.08,color: Colors.black12,),
              ),
              buildHome(
                name: 'Users',
                iconData: Icons.supervisor_account_sharp,
                function: (){
                  defaultNavigate(context: context ,widget: UserScreen());
                } ,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Divider(height: height*0.08,color: Colors.black12,),
              ),
              buildHome(
                  name: 'Customers',
                  iconData: Icons.person,
                function: (){
                  defaultNavigate(context: context ,widget: CustomerScreen());
                } ,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Divider(height: height*0.08,color: Colors.black12,),
              ),
              buildHome(
                  name: 'Product',
                  iconData: Icons.shopping_cart,
                function: (){
                  defaultNavigate(context: context ,widget: ProductScreen());
                } ,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Divider(height: height*0.08,color: Colors.black12,),
              ),
              buildHome(
                  name: 'InVoices',
                  iconData  : Icons.alt_route_sharp,
                function: (){
                  defaultNavigate(context: context ,widget: InVoiceScreen());
                } ,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Divider(height: height*0.08,color: Colors.black12,),
              ),
              buildHome(
                  name: 'Settings',
                  iconData  : Icons.settings,
                function: (){
                  defaultNavigate(context: context ,widget: SettingScreen());
                } ,
              ),
            ],
          )
        ),
      )
    );
  }

}
