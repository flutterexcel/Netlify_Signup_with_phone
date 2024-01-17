// ignore_for_file: unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:new_practise/emailUi.dart';
import 'package:shared_preferences/shared_preferences.dart';
 import 'package:url_launcher/url_launcher.dart';
 import 'package:jwt_decoder/jwt_decoder.dart';
 import 'dart:js' as js;
 import 'package:universal_html/html.dart' as html;


 void main() {
   runApp(MyApp());
 }
 class MyApp extends StatelessWidget {
  Future<void> loadData() async {
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 2));
   
     Map<String, dynamic> decoded;
     Uri currentUri = Uri.parse(html.window.location.href);
    
       Map<String, String> queryParams = currentUri.queryParameters;
       
     String? phtoken = queryParams['phtoken']; 
    
     prefs.setString('token', phtoken!);
     
     try {
       decoded = JwtDecoder.decode(phtoken!);
       int jwtResponse = 1;
       String jwtPhone = decoded['country_code'] + decoded['phone_no'];
      //  print('JWT decoded successfully');
      //  print('JWT Phone: $jwtPhone');
     } catch (e) {
       int jwtResponse = 0;
       String jwtPhone = '';
       print('Invalid JWT or decoding error: $e');
     }
  }
   
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('Stateless Widget Example'),
        // ),
        body: FutureBuilder(
          future: loadData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {       
              return Center(
                child: SignInButton(),
              );
            } else {              
              return Center(
                child: DashbordScreen(),
              );
            }
          },
        ),
      ),
    );
  }
   
 }
 class SignInButton extends StatelessWidget {
   final String api_key = 'BVj4k9UOSCuUoTOSbF0DAg4S335jdnPa'; // Replace with your actual API key
    String? countryCode;
    String? phoneNumber;
   @override
   Widget build(BuildContext context) {
   void openPopupWindow(String url) {
    print("hello");
    js.context.callMethod('open', [url, 'peLoginWindow', 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=500,height=560,top=' + ((js.context['screen']['height'] - 600) / 2).toString() + ',left=' + ((js.context['screen']['width'] - 500) / 2).toString()]);
   }
     return InkWell(
      
       onTap: () {
         openPopupWindow('https://www.phone.email/auth/sign-in?countrycode=${countryCode}&phone_no=${phoneNumber}&redirect_url=http://localhost:8080/');
         
       },
       child: Container(
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(3),
           color: Color(0xFF02BD7E),
         ),
         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
         child: const Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Padding(
               padding: EdgeInsets.only(right: 5),
               child: Icon(
                 Icons.phone,
                 color: Colors.white,
               ),
             ),
             Text(
               'Sign in with Phone Number',
               style: TextStyle(
                 fontWeight: FontWeight.bold,
                 fontSize: 16,
                 color: Colors.white,
               ),
             ),
           ],
         ),
       ),
     );
     
   }
   Future<String> getCurrentUrl() async {
    print(html.window.location.href);
    return html.window.location.href;
    
  }
  
   Future<void> _signInWithPhoneNumber() async {
      String url = 'https://www.phone.email/auth/sign-in?countrycode=91&phone_no=9528202921&redirect_url=http://localhost:8080/';
     try {
       await launch(url, webOnlyWindowName: 'peLoginWindow',);
     } catch (e) {
       print('Error launching URL: $e');
     }
     // Simulate JWT validation
     Map<String, dynamic> decoded;
     Uri currentUri = Uri.parse(await getCurrentUrl());
     print(currentUri);
     print("url ${currentUri}");
       Map<String, String> queryParams = currentUri.queryParameters;
       
     String? phtoken = queryParams['phtoken']; // Replace with your actual JWT token
     try {
       decoded = JwtDecoder.decode(phtoken!);
       int jwtResponse = 1;
       String jwtPhone = decoded['country_code'] + decoded['phone_no'];
     
      
     } catch (e) {
       int jwtResponse = 0;
       String jwtPhone = '';
       print('Invalid JWT or decoding error: $e');
     }
   }
 }

 
  