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
        'https://bazar-b2d83-default-rtdb.firebaseio.com/bazars.json  ');
    return http
        .post(url,
            body: jsonEncode({
              'bazarName': bazar.bazarName,
              'bazarImage': bazar.bazarImage,
              'isActive': bazar.isActive,
              'createdAt': bazar.createdAt.toString(),
            }))
        .then((response) {
      final id = (jsonDecode(response.body) as Map<String, dynamic>)['name'];
      final newProduct = Bazar(
        bazarId: id,
        bazarImage: bazar.bazarImage,
        bazarName: bazar.bazarName,
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

  Future<void> getBazars() async {
    final url =
        Uri.parse('https://bazar-b2d83-default-rtdb.firebaseio.com/bazars.json');
    try {
      final response = await http.get(url);
      if (response.body != null) {
        final date = jsonDecode(response.body) as Map<String, dynamic>;
        final List<Bazar> loadedProducts = [];
       date.forEach((bazarID, bazarData) {
          loadedProducts.add(
            Bazar(
                bazarId: bazarID,
                bazarName: bazarData['bazarName'],
                bazarImage: bazarData['bazarImage'],
                isActive: bazarData['isActive'],
                createdAt: DateTime.parse(bazarData['createdAt'])),
          );});

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
