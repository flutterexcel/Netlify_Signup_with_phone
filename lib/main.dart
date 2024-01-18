// ignore_for_file: unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:new_practise/emailUi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:js' as js;
import 'package:universal_html/html.dart' as html;
import 'dart:developer';
// build 

 void main() {
   runApp(MyApp());
 }
 class MyApp extends StatelessWidget {
   String jwtPhone='';
   String? phtoken='';

  Future<void> loadData() async {
    
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
     Map<String, dynamic> decoded;
     Uri currentUri = Uri.parse(html.window.location.href);
      Map<String, String> queryParams = currentUri.queryParameters;
       
     phtoken = queryParams['phtoken']; 
     log('token${phtoken}');
    
     
     try {
       decoded = JwtDecoder.decode(phtoken!);
       int jwtResponse = 1;
       jwtPhone = decoded['country_code'] + decoded['phone_no'];
       print('JWT decoded successfully');
       print('JWT Phone: $jwtPhone');
     } catch (e) {
       int jwtResponse = 0;
       String jwtPhone = '';
       print('Invalid JWT or decoding error: $e');
     }
  }
   
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(        
        body: FutureBuilder(
          future: loadData(),
          builder: (context, snapshot) {
            print(phtoken);
            if (phtoken==null) {   
          
              return Center(
                child: SignInButton(),
              );
          
            } else if(phtoken!=''){
              return const Center(
                child: EmailCounter()
              ); 
            }else{
              return const Center(
                child: Text('Not logged in')
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
    String? redirectUrl = html.window.location.href;
   @override
   Widget build(BuildContext context) {
   void openPopupWindow(String url) {
    print("hello");
    js.context.callMethod('open', [url, 'peLoginWindow', 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=500,height=560,top=' + ((js.context['screen']['height'] - 600) / 2).toString() + ',left=' + ((js.context['screen']['width'] - 500) / 2).toString()]);
   }
     return InkWell(
      
       onTap: () {
        countryCode ='91';
        phoneNumber ='9528202921';
        String url = 'https://www.phone.email/auth/sign-in?countrycode=+91&phone_no=9528202921&redirect_url=${redirectUrl}';
         openPopupWindow(url);
         print(url);
         
       },
       child: Container(
        height: 50,
        width: 300,
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(3),
           color: Color(0xFF02BD7E),
         ),
         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
         child: const
       Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 5, left: 5),
                      child: Icon(
                        Icons.phone,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                     Text(
                      'Sign in with Phone',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
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

 }

 
  