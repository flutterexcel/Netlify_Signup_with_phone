// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, sort_child_properties_last, unnecessary_null_comparison, prefer_if_null_operators, must_be_immutable
import 'package:flutter/material.dart';
import 'package:new_practise/Emailcount.dart';

import 'package:shared_preferences/shared_preferences.dart';
class DashbordScreen extends StatefulWidget {
  String? phone;
  String? jwtToken;
  DashbordScreen({super.key, this.phone, this.jwtToken});
  @override
  State<DashbordScreen> createState() => _DashbordScreenState();
}
class _DashbordScreenState extends State<DashbordScreen> {
  EmailCountService emailCountService=EmailCountService();
  String count = "";
  @override
  void initState() {
    super.initState();
    getEmailCount();
  }
  getEmailCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token') ?? widget.jwtToken;
    print("token hello token ******* ${prefs.getString('token')}");
    emailCountService.getEmailCount(token!).then((value) {
      print("API valur******* $value ");
      String count = value.toString();
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 236, 236, 236),
        automaticallyImplyLeading: false,
        title: Text(
          'Phone.email',
          style: TextStyle(color: Colors.green),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 50),
            child: FittedBox(
              child: Stack(
                alignment: Alignment(1.3, -1.0),
                children: [
                  FloatingActionButton(
                    backgroundColor: Colors.transparent,
                    onPressed: () {},
                    child: Icon(
                      Icons.email_outlined,
                      size: 35.5,
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text('${count == null ? '0' : count}',
                          style: TextStyle(color: Colors.white)),
                    ),
                    padding: EdgeInsets.all(8),
                    constraints: BoxConstraints(minHeight: 20, minWidth: 20),
                    decoration: BoxDecoration(
                      // This controls the shadow
                      // boxShadow: [
                      //   BoxShadow(
                      //       spreadRadius: 1,
                      //       // blurRadius: 5,
                      //       //color: Colors.black.withAlpha(50)
                      //       )
                      // ],
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.red, // This would be color of the Badge
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.28,
          height: MediaQuery.of(context).size.height * 0.22,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 192, 199, 147),
            borderRadius: BorderRadius.circular(3.2),
          ),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("You are logged in with"),
                SizedBox(
                  height: 15.5,
                ),
                Text("${widget.phone ?? 'Number'}"),
                SizedBox(
                  height: 15.5,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add your logout logic here
                    print('Logout button pressed');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors
                        .transparent, // Change the background color as needed
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20.0), // Adjust the border radius
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Logout',
                      style: TextStyle(
                          fontSize: 18.0), // Adjust the font size as needed
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}