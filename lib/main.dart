import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:socialty/Services/AuthService.dart';
import 'package:socialty/Services/UserService.dart';
import 'package:socialty/pages/login_page.dart';
import 'package:socialty/pages/register_page.dart';
import 'package:socialty/providers/Home_Page_Provider.dart';
import 'package:socialty/providers/login_page_provider.dart';
import 'package:socialty/providers/register_page_provider.dart';

void main() {
   HttpOverrides.global = MyHttpOverrides();
  GetIt.instance.registerSingleton<Dio>(Dio());
  GetIt.instance.get<Dio>().options.baseUrl="https://10.0.2.2:7008/api";
   (GetIt.instance.get<Dio>().httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  };
  GetIt.instance.registerSingleton<AuthService>(AuthService());
  GetIt.instance.registerSingleton<UserService>(UserService());
  GetIt.instance.registerSingleton<LoginPageProvider>(
      LoginPageProvider());
  GetIt.instance.registerSingleton<RegisterPageProvider>(
      RegisterPageProvider());
        GetIt.instance.registerSingleton<HomePageProvider>(
      HomePageProvider());
      


      

      
     


  runApp(const MyApp());
}


class MyApp extends StatelessWidget {

  const MyApp({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "socialty",

      initialRoute: "register",


      routes: {

        "login":(context)=>LoginPage(),
        "register":(context)=>RegisterPage()
      },



    );

  }



}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
