import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Register',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 255, 255, 255)),
          useMaterial3: true,
        ),
        home: const RegisterPage(title: 'Home Page'),
        debugShowCheckedModeBanner: false);
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String errorTextVal = '';
  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeConfirmPassword = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerDate = TextEditingController();
  final TextEditingController _controllerAlamat = TextEditingController();
  final TextEditingController _controllerFullname = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConFirmPassword =
      TextEditingController();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.035),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 100),
              Text(
                "Register",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                "Create your account",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 35),
              SizedBox(
                width: 320,
                height: 50,
                child: TextFormField(
                  controller: _controllerUsername,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      labelText: "Username",
                      prefixIcon: const Icon(Icons.person_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(66, 162, 232, 1), width: 0.0),
                      ),
                      errorText: errorTextVal.isEmpty ? null : errorTextVal),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      errorTextVal = 'Username salah';
                    }

                    return null;
                  },
                  onEditingComplete: () => _focusNodeEmail.requestFocus(),
                ),
              ),

              const SizedBox(height: 10),
              SizedBox(
                width: 320,
                height: 50,
                child: TextFormField(
                  controller: _controllerFullname,
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
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Fullname.";
                      // } else if (_boxAccounts.containsKey(value)) {
                      //   return "Username is already registered.";
                    }

                    return null;
                  },
                  // onEditingComplete: () => _focusNodeEmail.requestFocus(),
                ),
              ),
              const SizedBox(height: 10),
              // TextFormField(
              //   controller: _controllerEmail,
              //   focusNode: _focusNodeEmail,
              //   keyboardType: TextInputType.emailAddress,
              //   decoration: InputDecoration(
              //     labelText: "Email",
              //     prefixIcon: const Icon(Icons.email_outlined),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ),
              //   validator: (String? value) {
              //     if (value == null || value.isEmpty) {
              //       return "Please enter email.";
              //     } else if (!(value.contains('@') && value.contains('.'))) {
              //       return "Invalid email";
              //     }
              //     return null;
              //   },
              //   onEditingComplete: () => _focusNodePassword.requestFocus(),
              // ),
              // const SizedBox(height: 10),
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
              const SizedBox(height: 10),
              SizedBox(
                width: 320,
                height: 50,
                child: TextFormField(
                  controller: _controllerConFirmPassword,
                  obscureText: _obscurePassword,
                  focusNode: _focusNodeConfirmPassword,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
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
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter password.";
                    } else if (value != _controllerPassword.text) {
                      return "Password doesn't match.";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              // TextFormField(
              //   controller: _controllerDate,
              //   keyboardType: TextInputType.name,
              //   decoration: InputDecoration(
              //     labelText: "Tanggal Lahir",
              //     prefixIcon: const Icon(Icons.calendar_today),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ),
              //   onTap: () async {
              //     DateTime? pickedDate = await showDatePicker(
              //         context: context,
              //         initialDate: DateTime.now(),
              //         firstDate: DateTime(
              //             2000), //DateTime.now() - not to allow to choose before today.
              //         lastDate: DateTime(2101));

              //     if (pickedDate != null) {
              //       print(
              //           pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
              //       String formattedDate =
              //           DateFormat('yyyy-MM-dd').format(pickedDate);
              //       print(
              //           formattedDate); //formatted date output using intl package =>  2021-03-16
              //       //you can implement different kind of Date Format here according to your requirement

              //       setState(() {
              //         _controllerDate.text =
              //             formattedDate; //set output date to TextField value.
              //       });
              //     } else {
              //       print("Date is not selected");
              //     }
              //   },
              //   // onEditingComplete: () => _focusNodeEmail.requestFocus(),
              // ),
              // const SizedBox(height: 10),
              // DropdownButtonFormField(
              //   decoration: InputDecoration(
              //     labelText: "Gender",
              //     prefixIcon: const Icon(Icons.person_outline),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ),
              //   hint: Text('Select The Gender'),
              //   value: null,
              //   items: ["Male", "Female"]
              //       .map<DropdownMenuItem<String?>>((e) => DropdownMenuItem(
              //             child: Text(e.toString()),
              //             value: e,
              //           ))
              //       .toList(),
              //   onChanged: (value) {},
              // ),
              // const SizedBox(height: 10),
              // DropdownButtonFormField(
              //   decoration: InputDecoration(
              //     labelText: "Agama",
              //     prefixIcon: const Icon(Icons.book),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ),
              //   hint: Text('Select The Religion'),
              //   value: null,
              //   items: ["Islam", "Kristen", "Buddha", "Hindu", "Katolik"]
              //       .map<DropdownMenuItem<String?>>((e) => DropdownMenuItem(
              //             child: Text(e.toString()),
              //             value: e,
              //           ))
              //       .toList(),
              //   onChanged: (value) {},
              // ),
              // const SizedBox(height: 10),
              SizedBox(
                width: 320,
                height: 50,
                child: TextFormField(
                  controller: _controllerAlamat,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "Alamat",
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Fullname.";
                      // } else if (_boxAccounts.containsKey(value)) {
                      //   return "Username is already registered.";
                    }

                    return null;
                  },
                  // onEditingComplete: () => _focusNodeEmail.requestFocus(),
                ),
              ),
              const SizedBox(height: 50),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(307, 40),
                      backgroundColor: Color(0xff42a2e8),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                      // if (_formKey.currentState?.validate() ?? false) {
                      //   _boxAccounts.put(
                      //     _controllerUsername.text,
                      //     _controllerConFirmPassword.text,
                      //   );

                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //       width: 200,
                      //       backgroundColor:
                      //           Theme.of(context).colorScheme.secondary,
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //       behavior: SnackBarBehavior.floating,
                      //       content: const Text("Registered Successfully"),
                      //     ),
                      //   );

                      //   _formKey.currentState?.reset();

                      //   Navigator.pop(context);
                      // }
                    },
                    child: const Text(
                      "Register",
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
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
      ),
    );
  }
}
