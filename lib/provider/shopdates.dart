import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/shop_data.dart';


class ShopDates with ChangeNotifier {
  List<ShopDate> _shop_dateList = [];

  List<ShopDate> get shop_dateList {
    return [..._shop_dateList];
  }



  Future<void> addShop(ShopDate shopDate) async {
    final url = Uri.parse(
        'https://bazar-b2d83-default-rtdb.firebaseio.com/shop.json');
    return http
        .post(url,
        body: jsonEncode({
         'shopName' :shopDate.shopName,
        'shopPhone' :shopDate.shopPhone,
       'shopImage':shopDate.shopImage,
       'bazarId':shopDate.bazarId,
         'isActive':shopDate.isActive,
       'createdAt':shopDate.createdAt.toString(),
        'bazarName':shopDate.bazarName,
        }))
        .then((response) {
      final id = (jsonDecode(response.body) as Map<String, dynamic>)['name'];
      final newProduct = ShopDate(
          shopId: shopDate.shopId,
          shopName: shopDate.shopName,
          shopPhone: shopDate.shopPhone,
          shopImage: shopDate.shopImage,
          bazarId: shopDate.bazarId,
          isActive: true,
          createdAt: DateTime.now(),
          bazarName: shopDate.bazarName);
      _shop_dateList.insert(0, newProduct);
      notifyListeners();
      print(shopDate.shopName);
    }).catchError((error) {
      print('qo\'shishda xatolik');
      throw error;
    });
    print(shopDate.shopName);
  }

  Future<void> getShops() async  {
    final url = Uri.parse(
        'https://bazar-b2d83-default-rtdb.firebaseio.com/shop.json');
    try {
      final response = await http.get(url);
      if (response.body != null) {
        final date = jsonDecode(response.body) as Map<String, dynamic>;

        final List<ShopDate> loadedProducts = [];
        date.forEach((shopID, shopDate) {
          loadedProducts.add(
            ShopDate(
                shopId: shopID,
                shopName: shopDate['shopName'],
                shopPhone: shopDate['shopPhone'].toString(),
                shopImage: shopDate['shopImage'].toString(),
                bazarId: shopID,
                isActive: shopDate['isActive'],
                createdAt: DateTime.parse(shopDate['createdAt']),
                bazarName: shopDate['bazarName'],
            ));

        });

        // print(dates.runtimeType);

        // date.forEach((productId, bazarData) {
        //   print(bazarData);
        //
        // }
        // );
        _shop_dateList = loadedProducts;

        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }


}
