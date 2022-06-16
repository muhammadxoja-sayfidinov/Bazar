import 'package:flutter/material.dart';
import 'package:ngn/models/size_config.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as cnv;

import '../models/product_data.dart';
import '../provider/products.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}




class _ProductPageState extends State<ProductPage> {
  var _init = true;

  @override
  void didChangeDependencies() {
    if (_init) {
      Provider.of<Products>(context)
          .getProduct();
    }
    _init = false;

    super.didChangeDependencies();
  }
  final Uri _url = Uri.parse('https://t.me/nbnmarketplace');
  @override
  Widget build(BuildContext context) {
    var productDate = Provider.of<Products>(context).product_list;
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            "Mahsulot",
            style: TextStyle(color: Colors.black),
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
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              // FutureBuilder(
              //     future: getData(),
              //     builder: ((context, snapshot) {
              //       if (snapshot.hasData) {
              //         if (snapshot.hasError) {
              //           return Text(snapshot.error.toString());
              //         } else {
              //           return
                          Container(
                          height: getProportionateScreenHeight(650),
                          child: ListView.builder(
                              itemCount: productDate.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.all(10),
                                  height: getProportionateScreenHeight(170),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    children: [
                                      Container(
                                        height:
                                            getProportionateScreenHeight(200),
                                        width: getProportionateScreenWidth(150),
                                        child: Image.network(
                                          'https://nearbazar.uz/api/${productDate[index].productImage}',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                left:
                                                    getProportionateScreenWidth(
                                                        10),
                                                top:
                                                    getProportionateScreenHeight(
                                                        10)),
                                            child:  Text(
                                              "Mahsulot nomi: ${productDate[index].productName}",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left:
                                                    getProportionateScreenWidth(
                                                        10),
                                                top:
                                                    getProportionateScreenHeight(
                                                        10)),
                                            child:  Text(
                                              "Narxi: ${productDate[index].productPrice}",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left:
                                                        getProportionateScreenWidth(
                                                            10),
                                                    top:
                                                        getProportionateScreenHeight(
                                                            10)),
                                                child: const Text(
                                                  "Telegram : ",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    getProportionateScreenWidth(
                                                        60),
                                              ),
                                              Container(
                                                child: IconButton(
                                                    onPressed: _launchUrl,
                                                    icon: Image.asset(
                                                        'assets/send.png')),
                                              )
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left:
                                                    getProportionateScreenWidth(
                                                        10),
                                                top:
                                                    getProportionateScreenHeight(
                                                        10)),
                                            child: const Text(
                                              "Call center: +998908165719 ",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }),
                        // );
                      // }
                    // } else {
                    //   return Center(
                    //     child: CircularProgressIndicator(),
                    //   );
                    // }
                  // }))
                          )],
          ),
        ));
  }

  void _launchUrl() async {
    if (!await launchUrl(_url )) throw 'Could not launch $_url';
  }

//   Future getData() async {
//     //  Uri url = Uri.https("https://nearbazar.uz/api/bazars", );
//     Uri url = Uri.parse('https://nearbazar.uz/api/product');
//     http.Response res = await http.get(url);
//     print(res.body);
//     List<dynamic> body = cnv.jsonDecode(res.body)["data"];
//     datum = body.map((dynamic item) => Datum.fromJson(item)).toList();
//     return datum;
//   }
}
