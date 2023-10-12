import 'dart:convert';

import 'package:ecogo/model_class/class_products.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<List<Product>> getApi() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      var decodeData = jsonDecode(response.body);
      List<Product> data = decodeData.map<Product>((e) {
        return Product.fromJson(e);
      }).toList();
      return data;
    } else {
      throw 'Error';
    }
  }

  Future getDetails(String id) async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products/$id'));
    if (response.statusCode == 200) {
      var decodeData = jsonDecode(response.body);
      return decodeData;
    } else {
      throw 'Error';
    }
  }
}
