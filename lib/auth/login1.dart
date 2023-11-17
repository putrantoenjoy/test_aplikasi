// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// import 'package:test_aplikasi/dashboard/homepage.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController emailController = TextEditingController();

//   final TextEditingController passwordController = TextEditingController();

//   Future<void> login(String email, String password) async {
//     var apiUrl = 'http://127.0.0.1:8000/api/login';

//     final response = await http.post(Uri.parse(apiUrl), body: {
//       'email': email,
//       'password': password,
//     });

//     if (response.statusCode == 200) {
//       //mengambil data token
//       final token = json.decode(response.body)['token'];

//       //mengabil data user
//       final user = json.decode(response.body)['user'];

//       //menyimpan data token
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setString('token', token);

//       //berpindah halaman
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HomePage(
//             id: user.id,
//             name: user['name'],
//             email: user['email'],
//             token: token,
//           ),
//         ),
//         (route) => false,
//       );
//     } else {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Login Failed'),
//             content: Text('Invalid email or password.'),
//             actions: <Widget>[
//               // ignore: deprecated_member_use
//               ElevatedButton(
//                 child: Text('OK'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Welcome 👏',
//               style: TextStyle(fontSize: 24),
//             ),
//             Text(
//               'Login to get started!',
//             ),
//             SizedBox(
//               height: 16,
//             ),
//             TextFormField(
//               controller: emailController,
//               decoration: InputDecoration(
//                 labelText: 'Email',
//               ),
//             ),
//             TextFormField(
//               controller: passwordController,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//               ),
//               obscureText: true,
//             ),
//             SizedBox(height: 16.0),
//             // ignore: deprecated_member_use
//             ElevatedButton(
//               child: Text('Login'),
//               onPressed: () {
//                 login(emailController.text, passwordController.text);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
