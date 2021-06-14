import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/layout/cubit/cubit.dart';
import 'package:gallary/layout/home.dart';
import 'package:gallary/module/login/login_screen.dart';
import 'package:gallary/shared/network/local/cash.dart';
import 'package:gallary/shared/network/obServerCubit.dart';
import 'package:gallary/shared/network/remote/dio_helper.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.init();
  String token = await CashHelper.getData(key: 'token');
  // var widget;
  // if(token 0){
  //   widget = HomePage();
  // }else{
  //   widget = OnBoarding();
  // }
  runApp(MyApp(token));
}
class MyApp extends StatelessWidget {
  String? token;
  MyApp(this.token);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=> GalleryCubit()..getCustomer(),)],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          scaffoldBackgroundColor: Colors.orangeAccent,
          appBarTheme: AppBarTheme(
            titleSpacing: 20.0,
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.orangeAccent,
              statusBarIconBrightness: Brightness.dark,
            ),
            backgroundColor: Colors.orangeAccent,
            elevation: 0.0,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.deepOrange,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.deepOrange,
            unselectedItemColor: Colors.grey,
            elevation: 20.0,
            backgroundColor: Colors.white,
          ),
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        title: 'Sallah',
        home: (token != null) ? HomePage() : LoginPage(),
      ),
    );
  }
}

