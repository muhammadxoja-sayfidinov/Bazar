import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ngn/models/bazar_data.dart';


class Bazars with ChangeNotifier {
  List<Bazar> _list = [];

  List<Bazar> get list {
    return [..._list];
  }



  Future<void> addProduct(Bazar bazar) async {
    final url = Uri.parse(
        'https://nearbazar.uz/api/bazars');
    return http
        .post(url,
        body: jsonEncode({
          'bazarName': bazar.bazarName,
          'bazarImage': bazar.bazarImage,
        }))
        .then((response) {
      final id = (jsonDecode(response.body) as Map<String, dynamic>)['name'];
      final newProduct = Bazar(
        bazarId: id,
        bazarImage: bazar.bazarImage,
        bazarName:bazar.bazarName,
        isActive: true,
        createdAt: DateTime.now(),

      );
      _list.insert(0, newProduct);
      notifyListeners();
    }).catchError((error) {
      print('qo\'shishda xatolik');
      throw error;
    });
  }

  Future<void> getBazars() async  {
    final url = Uri.parse(
        'https://nearbazar.uz/api/bazars');
    try {
      final response = await http.get(url);
      if (response.body != null) {
        final date = jsonDecode(response.body) as Map<String, dynamic>;
        var dates = date['data'] as   List
        ;
        final List<Bazar> loadedProducts = [];
        for (Map<String,dynamic> bazarData in dates){
          loadedProducts.add(
                Bazar(
                    bazarId: bazarData['bazar_id'],
                    bazarName: bazarData['bazar_name'],
                    bazarImage: bazarData['bazar_image'],
                    isActive: bazarData['is_active'],
                    createdAt: DateTime.parse(bazarData['created_at'])),
              );
        }
        // print(dates.runtimeType);

        // date.forEach((productId, bazarData) {
        //   print(bazarData);
        //
        // }
        // );
        _list = loadedProducts;

        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> updateProductsFromFirebase(Product updateProduct) async {
  //   final productIndex = _list.indexWhere(
  //         (product) => product.id == updateProduct.id,
  //   );
  //   if (productIndex >= 0) {
  //     final url = Uri.parse(
  //         'https://fir-app-6342f-default-rtdb.firebaseio.com/product/${updateProduct.id}.json');
  //     try {
  //       await http.patch(url,
  //           body: jsonEncode({
  //             'title': updateProduct.title,
  //             'description': updateProduct.description,
  //             'price': updateProduct.price,
  //             'imageUrl': updateProduct.imageUrl,
  //           }));
  //       _list[productIndex] = updateProduct;
  //       notifyListeners();
  //     } catch (e) {
  //       rethrow;
  //     }
  //   }
  // }
  //
  //
  // Product findById(String productId) {
  //   return _list.firstWhere((pro) => pro.id == productId);
  // }
  //
  // void updateProduct(Product newProduct) {
  //   final productIndex =
  //   _list.indexWhere((element) => element.id == newProduct.id);
  //   if (productIndex >= 0) {
  //     _list[productIndex] = newProduct;
  //     notifyListeners();
  //   }
  // }
  //
  // Future<void> deleteProduct(String id) async {
  //   final url = Uri.parse(
  //       'https://fir-app-6342f-default-rtdb.firebaseio.com/product/$id.json');
  //   try {
  //     _list.removeWhere((product) => product.id == id);
  //     await http.delete(url);
  //
  //     notifyListeners();
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
