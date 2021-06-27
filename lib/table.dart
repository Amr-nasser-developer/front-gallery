import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/layout/cubit/cubit.dart';
import 'package:gallary/layout/cubit/state.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GalleryCubit, GalleryStates>(
      listener: (context, state){},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigo.shade900,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  child: GalleryCubit.get(context).image == null ? Image.asset('assets/image/redWood.jpg',fit: BoxFit.fill,)
                   :  enableUpload(context),
                )
              )
            ],
          ),
          floatingActionButton: new FloatingActionButton(
            onPressed: (){
              GalleryCubit.get(context).getImage(ImageSource.gallery);
            },
            tooltip: 'Add Image',
            child: new Icon(Icons.add),
          ),
        );
      }
        );

  }
  Widget enableUpload(context) {
    return Container(
      child: Column(
        children: <Widget>[
          Image.network('${GalleryCubit.get(context).image}'),
          RaisedButton(
            elevation: 7.0,
            child: Text('Upload'),
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: () {
              print('${GalleryCubit.get(context).image}');
            },
          )
        ],
      ),
    );
  }
}





