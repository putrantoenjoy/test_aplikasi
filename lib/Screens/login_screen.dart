import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_aplikasi/Screens/register_screen.dart';
import 'package:test_aplikasi/new/Services/auth_services.dart';
import 'package:test_aplikasi/new/Services/globals.dart';
import 'package:test_aplikasi/rounded_button.dart';
import 'package:http/http.dart' as http;

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _password = '';
  final FocusNode _focusNodePassword = FocusNode();

  final TextEditingController _controllerPassword = TextEditingController();
  bool _obscurePassword = true;

  loginPressed() async {
    if (_email.isNotEmpty && _password.isNotEmpty) {
      http.Response response = await AuthServices.login(_email, _password);
      Map responseMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const HomeScreen(),
            ));
      } else {
        errorSnackBar(context, responseMap.values.first);
      }
    } else {
      errorSnackBar(context, 'enter all required fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.black,
        //   centerTitle: true,
        //   elevation: 0,
        //   title: const Text(
        //     'Login',
        //     style: TextStyle(
        //       fontSize: 20,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 100),
          Text(
            "Login",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 10),
          Text(
            "Input your account",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 35),
          SizedBox(
            width: 320,
            height: 50,
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: const Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(66, 162, 232, 1), width: 0.0),
                ),
              ),
              onChanged: (value) {
                _email = value;
              },
              // validator: (String? value) {
              //   if (value == null || value.isEmpty) {
              //     return "Please enter email.";
              //   } else if (!(value.contains('@') && value.contains('.'))) {
              //     return "Invalid email";
              //   }
              //   return null;
              // },
              // onEditingComplete: () => _focusNodePassword.requestFocus(),
            ),
          ),
          // const SizedBox(
          //   height: 20,
          // ),
          // TextField(
          //   decoration: const InputDecoration(
          //     hintText: 'Enter your email',
          //   ),
          //   onChanged: (value) {
          //     _email = value;
          //   },
          // ),
          const SizedBox(height: 10),
          SizedBox(
            width: 320,
            height: 50,
            child: TextFormField(
              controller: _controllerPassword,
              obscureText: _obscurePassword,
              focusNode: _focusNodePassword,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: "Password",
                prefixIcon: const Icon(Icons.password_outlined),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    icon: _obscurePassword
                        ? const Icon(Icons.visibility_outlined)
                        : const Icon(Icons.visibility_off_outlined)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(66, 162, 232, 1), width: 0.0),
                ),
              ),
              onChanged: (value) {
                _password = value;
              },
              // validator: (String? value) {
              //   if (value == null || value.isEmpty) {
              //     return "Please enter password.";
              //   } else if (value.length < 8) {
              //     return "Password must be at least 8 character.";
              //   }
              //   return null;
              // },
              // onEditingComplete: () =>
              //     _focusNodeConfirmPassword.requestFocus(),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          // TextField(
          //   obscureText: true,
          //   decoration: const InputDecoration(
          //     hintText: 'Enter your password',
          //   ),
          //   onChanged: (value) {
          //     _password = value;
          //   },
          // ),
          const SizedBox(
            height: 30,
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(307, 40),
                  backgroundColor: Color(0xff42a2e8),
                ),
                onPressed: () => loginPressed(),
                child: const Text(
                  "Login",
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have account?"),
                  TextButton(
                    onPressed: () {
                      // Get.To();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterScreen()));
                    },
                    child: const Text("Sign Up"),
                  ),
                ],
              ),
            ],
          ),

          // RoundedButton(
          //   btnText: 'LOG IN',
          //   onBtnPressed: () => loginPressed(),
          // )
        ],
      ),
    ));
  }
}
