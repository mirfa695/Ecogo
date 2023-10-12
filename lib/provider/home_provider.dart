import 'package:ecogo/model_class/class_products.dart';
import 'package:ecogo/services/api_services.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  List cart = [];
  Future<List<Product>> getApi(BuildContext context) async {
    try {
      var data = await ApiServices().getApi();
      return data;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    throw 'ERROR';
  }

  Future getData(BuildContext context, String id) async {
    try {
      var data = await ApiServices().getDetails(id);
      return data;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    throw 'ERROR';
  }

  Future cartData(Product product, BuildContext context) async {
    cart.add(product);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Added to cart')));
  }
}
