// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, deprecated_member_use, unnecessary_brace_in_string_interps
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_practise/EmailCountservice.dart';
// import 'package:phonelogin/EmailcountService.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:universal_html/html.dart' as html;

import 'package:shared_preferences/shared_preferences.dart';

class EmailCounter extends StatefulWidget {
  const EmailCounter({super.key, this.title});
  final String? title;
  @override
  State<EmailCounter> createState() => _EmailCounterState();
}

class _EmailCounterState extends State<EmailCounter> {
  EmailCountService emailCountService = EmailCountService();
  String count = '';
  @override
  void initState() {
    super.initState();
    getEmailCount();
  }

  getEmailCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = await prefs.getString('token');
    print("token hello token ******* ${prefs.getString('token')}");
    Uri currentUri = Uri.parse(html.window.location.href);
    Map<String, String> queryParams = currentUri.queryParameters;
    Map<String, dynamic> decoded;

    String? token = queryParams['phtoken'];
    decoded = JwtDecoder.decode(token!);
    int jwtResponse = 1;
    String jwtPhone = decoded['country_code'] + decoded['phone_no'];
    print('ddepak');
    print(jwtPhone);
    emailCountService.getEmailCount(token!).then((value) {
      print("API valur******* $value ");
      setState(() {
        count = value;
      });

      print("count ${count}");
    });
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            // Shopping bag icon
            Icon(
              Icons.email,
              size: 100,
              color: Colors.black,
            ),
            // Dot with counter
           Positioned(
                    right: 5,
                    top: 5,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: Text(
                        '${count}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                
          ],
        ),
      ),
            SizedBox(
              height: 9.9,
            ),
            Container(
              height: 180,
              width: 300,
              color: Color.fromARGB(255, 255, 236, 181),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 37.5, left: 45.0, right: 21.0, bottom: 25.2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your are now Logged In with",
                      style: TextStyle(
                          fontSize: 16.2, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 15.2,
                    ),
                    Text("+919528202921"),
                    SizedBox(
                      height: 15.5,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        logout();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                          side: BorderSide(
                              color: Color.fromARGB(
                                  255, 48, 48, 48)), // Set border color
                        ),
                        fixedSize: Size(130, 35),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4.2, bottom: 4.2),
                        child: Center(
                          child: Text(
                            'Logout',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 62, 62, 62)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
