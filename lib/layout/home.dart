import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gallary/module/login/login_screen.dart';
import 'package:gallary/module/search/search_screen.dart';
import 'package:gallary/shared/components.dart';
import 'package:gallary/shared/network/local/cash.dart';
class GridView{
  String? name;
  int? count;
  GridView({@required this.name, @required this.count});
}

class HomePage extends StatelessWidget {
  List<GridView> names = [
    GridView(
        name: 'Student',
      count: 10
    ),
    GridView(
        name: 'Teacher',
      count: 15
    ),
    GridView(
        name: 'Class',
      count: 20
    ),
    GridView(
        name: 'Section',
      count: 25
    ),
    GridView(
        name: 'Student',
      count: 30
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
          }, child: TextButton(child: Text('LogOut',style: TextStyle(color: Colors.white),),
          onPressed: () => CashHelper.removeData(key: 'token').then((value) => finishNavigate(context: context,widget: LoginPage())),
          ))
        ],
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 30.0),
        child: ListView.separated(
            itemBuilder: (context, index)=> buildHome(names[index]),
            separatorBuilder: (context, index)=> Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30),
              child: Divider(color: Colors.black12,)),
            itemCount: names.length
        ),
      )
    );
  }
  Widget buildHome(GridView gridView)=> Row(
    children: [
     CircleAvatar(backgroundColor: Colors.pink,child: Text('${gridView.count}',style: TextStyle(color: Colors.white),),),
      SizedBox(width: 15.0,),
      Text(
        '${gridView.name}',
        style: TextStyle(color: Colors.white,fontSize: 22.0),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      Spacer(),
      IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_sharp,color: Colors.white,))
    ],
  );
}
