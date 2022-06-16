import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ngn/admin/admin_page.dart';
import 'package:ngn/models/size_config.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var adminName = 'nbnAdmin';
  var adminPassword = 'Shexroz21';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: getProportionateScreenWidth(130),
                  top: getProportionateScreenHeight(30)),
              height: getProportionateScreenHeight(111),
              width: getProportionateScreenWidth(133),
              child: Image.asset("assets/market.png"),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: getProportionateScreenWidth(29),
                top: getProportionateScreenHeight(71),
              ),
              child: const Text(
                "Login",
                style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400),
              ),
            ),
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
                controller: usernameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.people),
                  hintText: "username",
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
              height: getProportionateScreenHeight(56),
              width: getProportionateScreenWidth(317),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter last Name';
                  }
                  return null;
                },
                controller: passwordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: "password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(50),
                  top: getProportionateScreenHeight(164)),
              child: ElevatedButton(
                onPressed: () {
                  // if (usernameController.text==adminName &&
                  //    passwordController.text==adminPassword) {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: ((context) => AdminPage())));


                  // }
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff3D56F0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  fixedSize: Size(
                    271,
                    58,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Kirish",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Future<void> login(String name, String password) async {
//   print('object');
//   final url = Uri.parse('https://nearbazar.uz/api/auth/login');
//   return http
//       .post(url,
//           body: jsonEncode({
//             'adminName': name,
//             'adminPassword': password,
//           }))
//       .then((response) {
//
//     final id = (jsonDecode(response.body) as Map<String, dynamic>)['name'];
//     print(id);
//   }).catchError((error) {
//     print('qo\'shishda xatolik');
//     throw error;
//   });
// }
