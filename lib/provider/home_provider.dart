import 'package:ecogo/model_class/class_products.dart';
import 'package:ecogo/services/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier{
  Future <List<Product>>getApi(BuildContext context)async{
    try{
     var data= await ApiServices().getApi();
     return data;
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }throw 'ERROR';
  }
}