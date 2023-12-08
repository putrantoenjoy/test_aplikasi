import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:presensi/home-page.dart';
import 'package:http/http.dart' as myHttp;
import 'package:presensi/login-page.dart';
import 'package:presensi/models/login-response.dart';
import 'package:presensi/models/cuti-response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CutiPage extends StatefulWidget {
  const CutiPage({Key? key}) : super(key: key);

  @override
  State<CutiPage> createState() => _CutiPageState();
}

const Map<String, String> headers = {"Content-Type": "application/json"};

class Cuti {
  static Future<myHttp.Response> cuti(
      String tanggalmulai,
      String tanggalselesai,
      String jeniscuti,
      String keterangan,
      String status) async {
    Map data = {
      "tanggal_mulai": tanggalmulai,
      "tanggal_selesai": tanggalselesai,
      "jenis_cuti": jeniscuti,
      "keterangan": keterangan,
      "status": status,
    };
    var body = json.encode(data);
    var url = Uri.parse('http://127.0.0.1:8000/api/cuti');
    myHttp.Response response = await myHttp.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }
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
  String _jeniscuti = '';
  String _tanggalmulai = '';
  String _tanggalselesai = '';
  String _keterangan = '';
  String _status = '';

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dateinput = TextEditingController();

  createAccountPressed() async {
    myHttp.Response response = await Cuti.cuti(
        _tanggalmulai, _tanggalselesai, _jeniscuti, _keterangan, _status);
    Map responseMap = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final token = json.decode(response.body)['token'];

      //mengabil data user
      final user = json.decode(response.body)['user'];
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString('token', token);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomePage(),
          ));
    } else {
      // errorSnackbar(context, responseMap.values.first[0]);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(responseMap.values.first[0])));
    }
  }

  @override
  Future saveCuti() async {
    try {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CutiPage()))
          .then((value) {
        setState(() {});
      });
    } catch (err) {
      print('ERROR :' + err.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
    }
  }

  Future cuti(
      tanggalmulai, tanggalselesai, jeniscuti, keterangan, status) async {
    // CutiResponseModel? CutiResponseModel;
    CutiResponseModel? cutiResponseModel;
    Map<String, String> body = {
      "tanggal_mulai": tanggalmulai,
      "tanggal_selesai": tanggalselesai,
      "keterangan": keterangan,
      "status": status,
    };
    var response = await myHttp
        .post(Uri.parse('http://127.0.0.1:8000/api/cuti'), body: body);
    if (response.statusCode == 401) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error")));
    } else {
      cutiResponseModel =
          CutiResponseModel.fromJson(json.decode(response.body));
      saveCuti();
    }
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
                    onSelected: (value) {
                      _jeniscuti = value.toString();
                    },
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
                    onChanged: (value) {
                      _tanggalmulai = value;
                    },
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
                    onChanged: (value) {
                      _tanggalselesai = value;
                    },
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
                    onChanged: (value) {
                      _keterangan = value;
                    },
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
