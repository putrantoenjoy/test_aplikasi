// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class Network {
//   final String _url = 'http://127.0.0.1:8000/api/api_user';
//   // 192.168.1.2 is my IP, change with your IP address
//   var token;

//   _getToken() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     token = jsonDecode(localStorage.getString('token'))['token'];
//   }

//   auth(data, apiURL) async {
//     var fullUrl = _url + apiURL;
//     return await http.post(fullUrl,
//         body: jsonEncode(data), headers: _setHeaders());
//   }

//   getData(apiURL) async {
//     var fullUrl = _url + apiURL;
//     await _getToken();
//     return await http.get(
//       fullUrl,
//       headers: _setHeaders(),
//     );
//   }

//   _setHeaders() => {
//         'Content-type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $token',
//       };
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_aplikasi/model/user.dart';

class Services {
  static const ROOT = 'http://127.0.0.1:8000/api/api_user';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const _DELETE_EMP_ACTION = 'DELETE_EMP';

  static Future<List<User>> getEmployees() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.get(Uri.parse(ROOT));
      print('getUser Response: ${response.body}');
      print(response.statusCode);
      print(200 == response.statusCode);
      if (200 == response.statusCode) {
        List<User> list = parseResponse(response.body);
        print(list.length);
        return list;
      } else {
        return <User>[];
      }
    } catch (e) {
      return <User>[];
    }
  }

  static List<User> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody);
    print(parsed);
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  // static Future<bool> addEmployee(String firstName, String lastName) async {
  //   try {
  //     var map = Map<String, dynamic>();
  //     map['action'] = _ADD_EMP_ACTION;
  //     map['first_name'] = firstName;
  //     map['last_name'] = lastName;
  //     final response = await http.post(Uri.parse(ROOT), body: map);
  //     print('addEmployee Response: ${response.body}');
  //     if (200 == response.statusCode) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // static Future<bool> updateEmployee(
  //     String empId, String firstName, String lastName) async {
  //   try {
  //     var map = Map<String, dynamic>();
  //     map['action'] = _UPDATE_EMP_ACTION;
  //     map['id'] = empId;
  //     map['first_name'] = firstName;
  //     map['last_name'] = lastName;
  //     final response = await http.put(Uri.parse(ROOT + empId), body: map);
  //     print('updateEmployee Response: ${response.body}');
  //     if (200 == response.statusCode) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // static Future<bool> deleteEmployee(String empId) async {
  //   try {
  //     final response = await http.delete(Uri.parse(ROOT + empId));
  //     print('deleteEmployee Response: ${response.body}');
  //     if (200 == response.statusCode) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     return false;
  //   }
  // }
}
