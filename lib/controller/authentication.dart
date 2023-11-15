// import 'package:get/get.dart';

// class authentication extends GetxController {
//   String email, password;

//   Future<Response> login(email, password) async {
//     try {
//       Response response = await _dio.post(
//         'https://api.loginradius.com/identity/v2/auth/login',
//         data: {'email': email, 'password': password},
//         queryParameters: {'apikey': 'YOUR_API_KEY'},
//       );
//       //returns the successful user data json object
//       return response.data;
//     } on DioError catch (e) {
//       //returns the error object if any
//       return e.response!.data;
//     }
//   }
// }

import 'dart:convert';

// import 'package:api_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_aplikasi/dashboard/home.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_aplikasi/services/constant.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginWithEmail() async {
    var headers = {'Content-Type': 'application/json'};
    try {
      final login = Uri.parse(url + "login");
      Map body = {
        'email': emailController.text.trim(),
        'password': passwordController.text
      };
      http.Response response =
          await http.post(login, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['code'] == 0) {
          var token = json['data']['Token'];
          final SharedPreferences? prefs = await _prefs;
          await prefs?.setString('token', token);

          emailController.clear();
          passwordController.clear();
          Get.offAll(HomePage(title: "Home Page"));
        } else if (json['code'] == 1) {
          throw jsonDecode(response.body)['message'];
        }
      } else {
        throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });
    }
  }
}
