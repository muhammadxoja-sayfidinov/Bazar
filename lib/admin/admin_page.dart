import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ngn/models/product_data.dart';
import 'package:ngn/models/size_config.dart';
import 'package:ngn/provider/shopdates.dart';
import 'package:ngn/screen/my_home_page.dart';
import 'package:provider/provider.dart';

import '../provider/bazars.dart';
import '../provider/products.dart';
import '../widgets/custom_image.dart';

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

  int counter = 1;
  late final XFile? image;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    var bazarsDate = Provider.of<Bazars>(context).list;
    var shopDate = Provider.of<ShopDates>(context).shop_dateList;
    String bazarId = '14b668d2-03d2-45fb-be83-783885c13d14';
    String shopID = 'f859b344-65f8-4e36-9808-8eaaadf4ba88';

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
                    children: [
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
                          child: bazarId == shop.bazarId
                              ? Text(shop.shopName)
                              : Text(''),
                          value: bazarId == shop.bazarId ? shop.shopId : '',
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
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
                          Container(
                            margin: EdgeInsets.only(
                                left: getProportionateScreenWidth(28),
                                top: getProportionateScreenHeight(22)),
                            height: getProportionateScreenHeight(57),
                            width: getProportionateScreenWidth(317),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black26),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextField(
                              controller: _mainImageUrlsController,
                              decoration: InputDecoration(
                                  label:
                                      Text('Mahsulot rasmini urlni kiriting')),
                              onSubmitted: (value) {
                                setState(() {
                                  _mainImageUrlsController =
                                      value as TextEditingController;
                                });
                              },
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
                      Provider.of<Products>(context, listen: false).addProduct(
                          Product(
                              productId: UniqueKey().toString(),
                              productName: mahsulotController.text,
                              productPrice: narxiController.text,
                              productImage: _mainImageUrlsController.text,
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
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: ((context) => MyHomePage())));
                  },
                  icon: Text("Yuborish")),
            )
          ],
        ),
      ),
    );
  }
}
