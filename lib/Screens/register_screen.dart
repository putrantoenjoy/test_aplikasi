import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_aplikasi/new/Services/auth_services.dart';
import 'package:test_aplikasi/new/Services/globals.dart';

import '../rounded_button.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _email = '';
  String _password = '';
  String _name = '';

  // final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeConfirmPassword = FocusNode();

  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConFirmPassword =
      TextEditingController();
  bool _obscurePassword = true;

  createAccountPressed() async {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_email);
    if (emailValid) {
      http.Response response =
          await AuthServices.register(_name, _email, _password);
      Map responseMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const HomeScreen(),
            ));
      } else {
        errorSnackBar(context, responseMap.values.first[0]);
      }
    } else {
      errorSnackBar(context, 'email not valid');
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
      //     'Registration',
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
            // const SizedBox(
            //   height: 20,
            // ),
            // TextField(
            //   decoration: const InputDecoration(
            //     hintText: 'Name',
            //   ),
            //   onChanged: (value) {
            //     _name = value;
            //   },
            // ),
            // const SizedBox(
            //   height: 30,
            // ),
            // TextField(
            //   decoration: const InputDecoration(
            //     hintText: 'Email',
            //   ),
            //   onChanged: (value) {
            //     _email = value;
            //   },
            // ),
            // const SizedBox(
            //   height: 30,
            // ),
            // TextField(
            //   obscureText: true,
            //   decoration: const InputDecoration(
            //     hintText: 'Password',
            //   ),
            //   onChanged: (value) {
            //     _password = value;
            //   },
            // ),

            // const SizedBox(height: 35),
            // SizedBox(
            //   width: 320,
            //   height: 50,
            //   child: TextFormField(
            //     controller: _controllerUsername,
            //     keyboardType: TextInputType.name,
            //     decoration: InputDecoration(
            //         labelText: "Username",
            //         prefixIcon: const Icon(Icons.person_outline),
            //         border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(15),
            //         ),
            //         enabledBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(15),
            //           borderSide: const BorderSide(
            //               color: Color.fromRGBO(66, 162, 232, 1), width: 0.0),
            //         ),
            //         errorText: errorTextVal.isEmpty ? null : errorTextVal),
            //     validator: (String? value) {
            //       if (value == null || value.isEmpty) {
            //         errorTextVal = 'Username salah';
            //       }

            //       return null;
            //     },
            //     onEditingComplete: () => _focusNodeEmail.requestFocus(),
            //   ),
            // ),

            const SizedBox(height: 10),
            SizedBox(
              width: 320,
              height: 50,
              child: TextFormField(
                // controller: _controllerFullname,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Fullname",
                  prefixIcon: const Icon(Icons.person_outline),
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
                  _name = value;
                },
                // validator: (String? value) {
                //   if (value == null || value.isEmpty) {
                //     return "Please enter Fullname.";
                //     // } else if (_boxAccounts.containsKey(value)) {
                //     //   return "Username is already registered.";
                //   }

                //   return null;
                // },

                // onEditingComplete: () => _focusNodeEmail.requestFocus(),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 320,
              height: 50,
              child: TextFormField(
                // controller: _controllerEmail,
                // focusNode: _focusNodeEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onChanged: (value) {
                  _email = value;
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter email.";
                  } else if (!(value.contains('@') && value.contains('.'))) {
                    return "Invalid email";
                  }
                  return null;
                },
                // onEditingComplete: () => _focusNodePassword.requestFocus(),
              ),
            ),
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
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter password.";
                  } else if (value.length < 8) {
                    return "Password must be at least 8 character.";
                  }
                  return null;
                },
                onEditingComplete: () =>
                    _focusNodeConfirmPassword.requestFocus(),
              ),
            ),
            // const SizedBox(
            //   height: 40,
            // ),
            // RoundedButton(
            //   btnText: 'Create Account',
            //   onBtnPressed: () => createAccountPressed(),
            // ),
            // const SizedBox(
            //   height: 40,
            // ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (BuildContext context) => const LoginScreen(),
            //         ));
            //   },
            //   child: const Text(
            //     'already have an account',
            //     style: TextStyle(
            //       decoration: TextDecoration.underline,
            //     ),
            //   ),
            // ),
            const SizedBox(height: 50),
            Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(307, 40),
                    backgroundColor: Color(0xff42a2e8),
                  ),
                  onPressed: () => createAccountPressed(),
                  child: const Text(
                    "Register",
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Login"),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
