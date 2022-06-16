import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ngn/models/product_data.dart';

import '../models/shop_data.dart';


class Products with ChangeNotifier {
  List<Product> _product_list = [];

  List<Product> get product_list {
    return [..._product_list];
  }



  Future<void> addProduct(Product productDate) async {
    final url = Uri.parse(
        'https://nearbazar.uz/api/product');
    return http
        .post(url,
        body: jsonEncode({
          'shop_id': productDate.shopId,
          'product_name': productDate.shopName,
          'product_price': productDate.productPrice,
          'image': productDate.productImage,
        }))
        .then((response) {
      final id = (jsonDecode(response.body) as Map<String, dynamic>)['name'];
      final newProduct = Product(
          productId: productDate.productId,
          productName: productDate.productName,
          productPrice: productDate.productPrice,
          productImage: productDate.productImage,
          shopId: productDate.shopId,
          isActive: productDate.isActive,
          createdAt: productDate.createdAt,
          shopName: productDate.shopName);
      _product_list.insert(0, newProduct);
      notifyListeners();
          print('object');
          print(response.statusCode);
    }).catchError((error) {
      print('qo\'shishda xatolik');
      throw error;
    });
  }

  Future<void> getProduct() async  {
    final url = Uri.parse(
        'https://nearbazar.uz/api/product');
    try {
      final response = await http.get(url);
      if (response.body != null) {
        final date = jsonDecode(response.body) as Map<String, dynamic>;
        var dates = date['data'] as   List
        ;
        final List<Product> loadedProducts = [];
        for (Map<String,dynamic> product in dates){
          print(product);
          loadedProducts.add(
           Product(
               productId: product['product_id'],
               productName: product['product_name'],
               productPrice: product['product_price'],
               productImage: product['product_image'],
               shopId: product['shop_id'],
               isActive: product['is_active'],
               createdAt: DateTime.parse( product['created_at']),
               shopName: product['shop_name'])
          );
        }
        // print(dates.runtimeType);

        // date.forEach((productId, bazarData) {
        //   print(bazarData);
        //
        // }
        // );
        _product_list = loadedProducts;

        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }


}
