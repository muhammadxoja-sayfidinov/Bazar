import 'package:flutter/material.dart';
import 'package:ngn/provider/bazars.dart';
import 'package:ngn/provider/products.dart';
import 'package:ngn/provider/shopdates.dart';
import 'package:ngn/screen/my_home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Bazars>(create: (ctx) {
          return Bazars();
        }),
        ChangeNotifierProvider<ShopDates>(create: (ctx) {
          return ShopDates();
        }),
        ChangeNotifierProvider<Products>(create: (ctx) {
          return Products();
        }),
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: MyHomePage()),
    );
  }
}
