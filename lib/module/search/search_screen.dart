import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'inputData';
                }
                return null;

              },
              controller: searchController,
              keyboardType: TextInputType.text,
              onFieldSubmitted: (value){},
              onChanged: (value) {
                print(value);
              },
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
