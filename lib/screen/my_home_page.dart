import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ngn/admin/login_page.dart';
import 'package:ngn/screen/market_page.dart';
import 'package:ngn/models/bazar_data.dart';
import 'package:ngn/models/size_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as cnv;

import 'package:provider/provider.dart';

import '../provider/bazars.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List<Datum>? datum;
  List colors = const [
    Color(0xffCFEEE8),
    Color(0xff7DE0FD),
    Color(0xffFFC7B5),
    Color(0xffCFEEE8),
    Color(0xff7DE0FD),
    Color(0xffFFC7B5),
    Color(0xffCFEEE8),
    Color(0xff7DE0FD),
    Color(0xffFFC7B5),
    Color(0xffCFEEE8),
    Color(0xff7DE0FD),
    Color(0xffFFC7B5),
    Color(0xffCFEEE8),
    Color(0xff7DE0FD),
    Color(0xffFFC7B5),
    Color(0xffCFEEE8),
    Color(0xff7DE0FD),
    Color(0xffFFC7B5),
    Color(0xffCFEEE8),
    Color(0xff7DE0FD),
    Color(0xffFFC7B5),
    Color(0xffCFEEE8),
    Color(0xff7DE0FD),
    Color(0xffFFC7B5),
    Color(0xffCFEEE8),
    Color(0xff7DE0FD),
    Color(0xffFFC7B5),
    Color(0xffCFEEE8),
    Color(0xff7DE0FD),
    Color(0xffFFC7B5),
    Color(0xffCFEEE8),
    Color(0xff7DE0FD),
    Color(0xffFFC7B5),
    Color(0xffCFEEE8),
    Color(0xff7DE0FD),
    Color(0xffFFC7B5),
    Color(0xffCFEEE8),
    Color(0xff7DE0FD),
    Color(0xffFFC7B5),
    Color(0xffCFEEE8),
    Color(0xff7DE0FD),
    Color(0xffFFC7B5)
  ];
  @override
  // void initState() {
  //   getData();
  //   super.initState();
  // }
  var _init = true;

  @override
  void didChangeDependencies() {
    if (_init) {
      Provider.of<Bazars>(context)
          .getBazars();
    }
    _init = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var bazarsDate = Provider.of<Bazars>(context).list;
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Bozorlar",
                  style: TextStyle(color: Colors.black),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => LoginPage())));
                  },
                  icon: const Icon(
                    Icons.admin_panel_settings,
                    color: Colors.black,
                  ),
                ),
              ],
            )),
        body: SingleChildScrollView(
          child: SafeArea(
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


                          Container(
                            height: getProportionateScreenHeight(750),
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: getProportionateScreenWidth(20),
                                    vertical: getProportionateScreenHeight(10),
                                  ),
                                  width: getProportionateScreenWidth(327),
                                  height: getProportionateScreenHeight(180),
                                  decoration: BoxDecoration(
                                    color: colors[index],
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
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
                                                        20),
                                                top:
                                                    getProportionateScreenHeight(
                                                        20)),
                                            child: Text(
                                              bazarsDate[index].bazarName,
                                              style: GoogleFonts.lato(
                                                textStyle: const TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff000000),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left:
                                                    getProportionateScreenWidth(
                                                        20),
                                                top:
                                                    getProportionateScreenHeight(
                                                        20)),
                                            child: Text(
                                              '448 market',
                                              style: GoogleFonts.lato(
                                                textStyle: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff717171),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              left: getProportionateScreenWidth(
                                                  20),
                                              top: getProportionateScreenHeight(
                                                  25),
                                            ),
                                            decoration: BoxDecoration(
                                              color: Color(0xff4B17FF),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            height:
                                                getProportionateScreenHeight(
                                                    40),
                                            width: getProportionateScreenWidth(
                                                100),
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const MarketPage()));
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Kirish',
                                                    style: GoogleFonts.lato(
                                                      textStyle:
                                                          const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: getProportionateScreenWidth(
                                                100),
                                            top: getProportionateScreenHeight(
                                                80)),
                                        height:
                                            getProportionateScreenHeight(70),
                                        width: getProportionateScreenWidth(70),
                                        child: Image.asset(
                                          'assets/market.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              itemCount: bazarsDate.length,
                            ),
                          )


              ],
            ),
          ),
        ));
  }

//   Future getData() async {
//      Uri url = Uri.https("https://nearbazar.uz/api/bazars", );
//     Uri url = Uri.parse('https://nearbazar.uz/api/bazars');
//     http.Response res = await http.get(url);
//     print(res.body);
//     List<dynamic> body = cnv.jsonDecode(res.body)["data"];
//     datum = body.map((dynamic item) => Datum.fromJson(item)).toList();
//     return datum;
//   }
}
