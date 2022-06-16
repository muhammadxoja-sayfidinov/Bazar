import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/shop_data.dart';


class ShopDates with ChangeNotifier {
  List<ShopDate> _shop_dateList = [];

  List<ShopDate> get shop_dateList {
    return [..._shop_dateList];
  }



  Future<void> addPr(ShopDate shopDate) async {
    final url = Uri.parse(
        'https://nearbazar.uz/api/bazars');
    return http
        .post(url,
        body: jsonEncode({
          'shop_phone': shopDate.shopPhone,
          'bazar_id': shopDate.bazarId,
          'image': shopDate.bazarId,
          'shopName': shopDate.shopName,
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
    }).catchError((error) {
      print('qo\'shishda xatolik');
      throw error;
    });
  }

  Future<void> getShops() async  {
    final url = Uri.parse(
        'https://nearbazar.uz/api/shop');
    try {
      final response = await http.get(url);
      if (response.body != null) {
        final date = jsonDecode(response.body) as Map<String, dynamic>;
        var dates = date['data'] as   List
        ;
        final List<ShopDate> loadedProducts = [];
        for (Map<String,dynamic> shopDate in dates){
          print(shopDate);
          loadedProducts.add(
            ShopDate(
                shopId: shopDate['shop_id'],
                shopName: shopDate['shop_name'],
                shopPhone: shopDate['shop_phone'],
                shopImage: shopDate['shop_image'],
                bazarId: shopDate['bazar_id'],
                isActive: shopDate['is_active'],
                createdAt: DateTime.parse(shopDate['created_at']),
                bazarName: shopDate['bazar_name'],
            )
          );
        }
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
