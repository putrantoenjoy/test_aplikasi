import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_aplikasi/auth/register.dart';

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Home - Presensi',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 255, 255, 255)),
          useMaterial3: true,
        ),
        home: const HomePage(title: 'Home Page'),
        debugShowCheckedModeBanner: false);
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.035),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.only(top: 40, bottom: 40),
            child: Image.asset('logo/logoHome.png'),
          ),
          Card(
            margin: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsetsDirectional.only(
                    top: 20,
                  ),
                  child: Text(
                    "Februari",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Column(
                          children: [Text("Ringkasan presensi")],
                        ),
                        Column(
                          children: [
                            Text(
                              "10/23",
                              textAlign: TextAlign.right,
                            )
                          ],
                        )
                      ],
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text("Jaenal"),
                ),
              ],
            ),
          ),
          Container(),
        ],
      ),
    );
  }
}
