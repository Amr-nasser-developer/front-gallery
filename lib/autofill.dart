import 'package:flutter/material.dart';
import 'package:gallary/layout/cubit/cubit.dart';
import 'package:textfield_search/textfield_search.dart';
class HomePages extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePages> {
  // This will be displayed below the autocomplete field
  String? _selectedAnimal;

  // This list holds all the suggestions
  final List<String> _suggestions = [
    'Alligator',
    'Buffalo',
    'Chicken',
    'Dog',
    'Eagle',
    'Frog'
  ];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kindacode.com'),
      ),
      body: Column(
        children: [
      Container(
        height: 100.0,
        child: ListView(
        children: <Widget>[
        SizedBox(height: 16),
        TextFieldSearch(
            label: 'Simple Future List',
            initialList: [GalleryCubit.get(context).viewProduct],
            controller: myController2,
            future: () {
              return GalleryCubit.get(context).viewProduct.map((e){
                return Text('${e['name']['ar']}');
              });
            }),
          ],
        ),
      ),
    ]
      )
    );
  }
}
