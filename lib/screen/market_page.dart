import 'package:flutter/material.dart';
import 'package:ngn/models/shop_data.dart';
import 'package:ngn/screen/product_page.dart';
import 'package:ngn/models/size_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as cnv;

import 'package:provider/provider.dart';

import '../provider/bazars.dart';
import '../provider/shopdates.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  var _init = true;

  @override
  void didChangeDependencies() {
    if (_init) {
      Provider.of<ShopDates>(context).getShops();
    }
    _init = false;

    super.didChangeDependencies();
  }

  // List<Datum>? datum;
  @override
  Widget build(BuildContext context) {
    var shopDate = Provider.of<ShopDates>(context).shop_dateList;
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: const Text(
            "Do'konlar",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: getProportionateScreenHeight(56),
                width: getProportionateScreenWidth(317),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Qidiring",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Container(
                  height: getProportionateScreenHeight(680),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: GridView.builder(
                        itemCount: shopDate.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => const ProductPage()),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              height: getProportionateScreenHeight(200),
                              width: getProportionateScreenWidth(150),
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Container(
                                    child: Image.network(
                                      "https://nearbazar.uz/api/${shopDate[index].shopImage}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: getProportionateScreenHeight(10)),
                                    child: Text(
                                      "Do'kon nomi: ${shopDate[index].shopName}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ))
            ],
          ),
        ));
  }

//   Future getData() async {
//     //  Uri url = Uri.https("https://nearbazar.uz/api/bazars", );
//     Uri url = Uri.parse('https://nearbazar.uz/api/shop');
//     http.Response res = await http.get(url);
//     print(res.body);
//     List<dynamic> body = cnv.jsonDecode(res.body)['data'];
//     datum = body.map((dynamic item) => Datum.fromJson(item)).toList();
//     return datum;
//   }
}
