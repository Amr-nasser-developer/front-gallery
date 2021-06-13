import 'package:flutter/material.dart';
import 'package:gallary/module/login/login_screen.dart';
import 'package:gallary/shared/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class View{
  String? name;
  String? image;
  View(this.name, this.image);
}
class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<View> view = [
    View(
        'Welcome Sear',
        'https://images.unsplash.com/photo-1507643179773-3e975d7ac515?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=750&q=80'
    ),
    View(
        'How Are You',
        'https://images.unsplash.com/photo-1507643179773-3e975d7ac515?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=750&q=80'
    ),
    View(
        'Let\'s Start',
        'https://images.unsplash.com/photo-1507643179773-3e975d7ac515?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=750&q=80'
    ),
  ];

 bool isLast = false;

  var boardController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        actions: [
          TextButton(onPressed: (){
            finishNavigate(
                context: context,
                widget: LoginPage()
            );
          }, child: Text('Skip',style: TextStyle(color: Colors.white),))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              physics: BouncingScrollPhysics(),
              onPageChanged: (index){
                if(index == view.length -1){
                  setState(() {
                    isLast = true;
                  });
                }else {
                  setState(() {
                    isLast = false;
                  });
                }
              },
                itemBuilder: (context, index)=> buildIndicator(view[index]),
              controller: boardController,
              itemCount: view.length,
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                  count: view.length,
                ),
                Spacer(),
                FloatingActionButton(
                    onPressed: (){
                     if (isLast){
                       finishNavigate(
                        context: context,
                         widget: LoginPage()
                       );
                     }else{
                       boardController.nextPage(
                         duration: Duration(
                           milliseconds: 750,
                         ),
                         curve: Curves.fastLinearToSlowEaseIn,
                       );
                     }
                    },
                  child: Icon(Icons.arrow_forward_ios_sharp),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildIndicator(View vie){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(image: NetworkImage('${vie.image}'),),
          SizedBox(
            height: 85.0,
          ),
          Text(
            '${vie.name}',
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
