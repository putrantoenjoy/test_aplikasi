import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:presensi/home-page.dart';
import 'package:http/http.dart' as myHttp;
import 'package:presensi/login-page.dart';
import 'package:presensi/models/login-response.dart';
import 'package:presensi/models/register-response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CutiPage extends StatefulWidget {
  const CutiPage({Key? key}) : super(key: key);

  @override
  State<CutiPage> createState() => _CutiPageState();
}

const List<String> list = <String>[
  'Cuti Sakit',
  'Cuti Hari Libur Nasional',
  'Cuti Hari Libur Keagamaan',
  'Cuti Hamil',
  'Cuti Ayah',
  'Cuti Kedukaan',
  'Cuti Kompensasi',
  'Cuti Panjang',
  'Cuti Tidak Dibayar',
  'Cuti Pendidikan'
];

class _CutiPageState extends State<CutiPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  late Future<String> _name, _token;
  final FocusNode _focusNodePassword = FocusNode();
  bool _obscurePassword = true;

  @override
  void initState() {
    dateinput.text = "";
    // TODO: implement initState
    super.initState();
    _token = _prefs.then((SharedPreferences prefs) {
      return prefs.getString("token") ?? "";
    });

    _name = _prefs.then((SharedPreferences prefs) {
      return prefs.getString("name") ?? "";
    });
    // checkToken(_token, _name);
  }

  @override
  Widget build(BuildContext context) {
    String dropdownValue = list.first;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cuti"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  child: Center(
                child: SizedBox(
                  width: 320,
                  child: Text(
                    "Ajukan Cuti",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(66, 162, 232, 1)),
                  ),
                ),
              )),
              SizedBox(height: 20),
              // Text("Email"),
              Center(
                child: SizedBox(
                  width: 320,
                  height: 50,
                  child: TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "Name",
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(66, 162, 232, 1), width: 0.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 320,
                  height: 50,
                  child: DropdownMenu(
                    width: 320,
                    menuHeight: 185,
                    leadingIcon: const Icon(Icons.library_books),
                    label: const Text('Pilih Cuti'),
                    inputDecorationTheme: InputDecorationTheme(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(66, 162, 232, 1), width: 0.0),
                      ),
                    ),
                    dropdownMenuEntries:
                        list.map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
                  ),
                ),
              ),
              // Center(
              //   child: TextField(
              //     controller: dateinput, //editing controller of this TextField
              //     decoration: InputDecoration(
              //         icon: Icon(Icons.calendar_today), //icon of text field
              //         labelText: "Enter Date" //label text of field
              //         ),
              //     readOnly:
              //         true, //set it true, so that user will not able to edit text
              //     onTap: () async {
              //       DateTime pickedDate = await showDatePicker(
              //           context: context,
              //           initialDate: DateTime.now(),
              //           firstDate: DateTime(
              //               2000), //DateTime.now() - not to allow to choose before today.
              //           lastDate: DateTime(2101));

              //       if (pickedDate != null) {
              //         print(
              //             pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
              //         String formattedDate =
              //             DateFormat('yyyy-MM-dd').format(pickedDate);
              //         print(
              //             formattedDate); //formatted date output using intl package =>  2021-03-16
              //         //you can implement different kind of Date Format here according to your requirement

              //         setState(() {
              //           dateinput.text =
              //               formattedDate; //set output date to TextField value.
              //         });
              //       } else {
              //         print("Date is not selected");
              //       }
              //     },
              //   ),
              // ),

              SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 320,
                  height: 50,
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Tanggal Mulai",
                      prefixIcon: const Icon(Icons.calendar_month),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(66, 162, 232, 1), width: 0.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 320,
                  height: 50,
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Tanggal Selesai",
                      prefixIcon: const Icon(Icons.calendar_month),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(66, 162, 232, 1), width: 0.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 320,
                  height: 50,
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Keterangan",
                      prefixIcon: const Icon(Icons.library_books_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(66, 162, 232, 1), width: 0.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(320, 40),
                    backgroundColor: Color(0xff42a2e8),
                  ),
                  onPressed: null,
                  child: const Text(
                    "Buat Cuti",
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
