import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ngn/models/product_data.dart';
import 'package:ngn/models/size_config.dart';
import 'package:ngn/provider/shopdates.dart';
import 'package:ngn/screen/my_home_page.dart';
import 'package:ngn/widgets/marketModalBottom.dart';
import 'package:provider/provider.dart';

import '../provider/bazars.dart';
import '../provider/products.dart';
import '../widgets/custom_image.dart';
import '../widgets/modalBottom.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  var _init = true;

  @override
  void didChangeDependencies() {
    if (_init) {
      Provider.of<Bazars>(context).getBazars();
      Provider.of<ShopDates>(context).getShops();
    }
    _init = false;

    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    // bazarId = widget.categories[0].id;
  }
  TextEditingController bozorController = TextEditingController();
  TextEditingController dokonController = TextEditingController();
  TextEditingController mahsulotController = TextEditingController();
  TextEditingController narxiController = TextEditingController();
  TextEditingController _mainImageUrlsController = TextEditingController();

  int index = 0;

  void addBazar(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        context: context,
        builder: (ctx) {
          return ModalBottom();
        });
  }

  void addMarket(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        context: context,
        builder: (ctx) {
          return MarketModalBottom();
        });
  }

  int counter = 1;
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imagetemporary = File(image.path);
      setState(() => this.image = imagetemporary);
    } on Platform catch (e) {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    var bazarsDate = Provider.of<Bazars>(context).list;
    var shopDate = Provider.of<ShopDates>(context).shop_dateList;
    String bazarId = '';
    String shopID = '';

    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Admin",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  addBazar(context);
                },
                child: Text('Bozor qo\'sish')),
            ElevatedButton(
                onPressed: () {
                  addMarket(context);
                },
                child: Text('Market qo\'sish')),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.only(
                  left: getProportionateScreenWidth(28),
                  top: getProportionateScreenHeight(22)),
              height: getProportionateScreenHeight(57),
              width: getProportionateScreenWidth(317),
              child: DropdownButton(
                hint: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Icon(Icons.home),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Bozorni tanglang '),
                    ],
                  ),
                ),
                items: bazarsDate
                    .map((bazar) => DropdownMenuItem(
                          child: Text(bazar.bazarName),
                          value: bazar.bazarId,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    bazarId = value as String;
                  });
                },
                isExpanded: true,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.only(
                  left: getProportionateScreenWidth(28),
                  top: getProportionateScreenHeight(22)),
              height: getProportionateScreenHeight(57),
              width: getProportionateScreenWidth(317),
              child: DropdownButton(
                hint: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Icon(Icons.shop),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Do\'konni tanglang '),
                    ],
                  ),
                ),
                items: shopDate
                    .map((shop) => DropdownMenuItem(
                          child: Text(shop.shopName),
                          value: shop.shopId,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    print(value);
                    var shopID = value as String;
                  });
                },
                isExpanded: true,
              ),
            ),
            Container(
              height: getProportionateScreenHeight(470),
              child: ListView.builder(
                  itemCount: counter,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: getProportionateScreenWidth(28),
                                top: getProportionateScreenHeight(22)),
                            height: getProportionateScreenHeight(57),
                            width: getProportionateScreenWidth(317),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter last Name';
                                }
                                return null;
                              },
                              controller: mahsulotController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.shop_2),
                                hintText: "Mahsulot nomi",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: getProportionateScreenWidth(28),
                                top: getProportionateScreenHeight(22)),
                            height: getProportionateScreenHeight(57),
                            width: getProportionateScreenWidth(317),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter last Name';
                                }
                                return null;
                              },
                              controller: narxiController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.money),
                                hintText: "Narxi",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          // Container(
                          //   margin: EdgeInsets.only(
                          //       left: getProportionateScreenWidth(28),
                          //       top: getProportionateScreenHeight(22)),
                          //   height: getProportionateScreenHeight(57),
                          //   width: getProportionateScreenWidth(317),
                          //   child: TextFormField(
                          //     validator: (value) {
                          //       if (value!.isEmpty) {
                          //         return 'Image url';
                          //       }
                          //       return null;
                          //     },
                          //     controller: _mainImageUrlsController,
                          //     decoration: InputDecoration(
                          //       prefixIcon: Icon(Icons.money),
                          //       hintText: "Mahsulot rasm URlni kiriting",
                          //       border: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(10),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // Container(
                          //   margin: EdgeInsets.only(
                          //       top: getProportionateScreenHeight(20)),
                          //   width: getProportionateScreenWidth(200),
                          //   height: getProportionateScreenHeight(40),
                          //   decoration: BoxDecoration(
                          //       color: Colors.blueAccent,
                          //       borderRadius: BorderRadius.circular(50)),
                          //   child: ElevatedButton(
                          //     onPressed: () async {
                          //       image = await _picker.pickImage(
                          //           source: ImageSource.gallery);
                          //     },
                          //     child: Row(
                          //       children: [
                          //         Icon(Icons.image),
                          //         SizedBox(
                          //           width: getProportionateScreenWidth(10),
                          //         ),
                          //         Text("Mahsulot rasmi")
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: image == null
                                  ? ElevatedButton(
                                      onPressed: () {
                                        pickImage();
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.image),
                                          Text("Mahsulot rasmi tanglang")
                                        ],
                                      ),
                                    )
                                  : Image.file(
                                      image!,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(
                                top: getProportionateScreenHeight(20)),
                            height: getProportionateScreenHeight(50),
                            width: getProportionateScreenWidth(50),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  counter++;
                                });
                              },
                              icon: const Icon(
                                Icons.add,
                                size: 30,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            Container(
              height: getProportionateScreenHeight(50),
              width: getProportionateScreenWidth(200),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(30)),
              child: IconButton(
                  onPressed: () {
                    if (mahsulotController.text.isNotEmpty ||
                        _mainImageUrlsController.text.isNotEmpty ||
                        shopID.isNotEmpty ||
                        narxiController.text.isNotEmpty) {
                      setState(() {
                        index = bazarsDate.indexWhere(
                            (element) => element.bazarId == bazarId);
                      });

                      Provider.of<Products>(context, listen: false).addProduct(
                          Product(
                              productId: UniqueKey().toString(),
                              productName: mahsulotController.text,
                              productPrice: narxiController.text,
                              productImage: image!.path.toString(),
                              shopId: shopID,
                              isActive: true,
                              createdAt: DateTime.now(),
                              shopName: shopDate[0].shopName));
                      print(mahsulotController.text);
                      print(narxiController.text);
                      print(_mainImageUrlsController.text);
                      print(shopID);
                      print(shopDate[0].shopName);
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => MyHomePage())));
                  },
                  icon: Text("Yuborish")),
            )
          ],
        ),
      ),
    );
  }
}
