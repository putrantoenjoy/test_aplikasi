import 'package:flutter/material.dart';
import 'package:test_aplikasi/auth/register.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
            color: Color.fromRGBO(66, 162, 232, 1),
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
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(255, 255, 255, 1)),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              "Ringkasan presensi",
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1)),
                            )
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Text(
                              "10/2023",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1)),
                            )
                          ],
                        )
                      ],
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Jaenal",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(255, 255, 255, 1)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
          ),
          Card(
            color: Color.fromRGBO(66, 162, 232, 1),
            margin: EdgeInsets.all(15),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Column(
                    children: [
                      Text(
                        "Hari ini",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(255, 255, 255, 1)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "Datang",
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1)),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Text(
                            "Pergi",
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1)),
                          )
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          ButtonTheme(
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                    fixedSize: const Size(307, 40),
                                    maximumSize: Size.fromWidth(100),
                                    backgroundColor:
                                        Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                  onPressed: () {
                                    // Get.To();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterPage(
                                                    title: "Login Page")));
                                  },
                                  child: const Text(
                                    'Check In',
                                    style: TextStyle(color: Colors.black),
                                  )))
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Presensi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        // currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        // onTap: _onItemTapped,
      ),
    );
  }
}
