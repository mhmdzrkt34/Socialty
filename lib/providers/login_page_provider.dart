


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:socialty/Services/AuthService.dart';
import 'package:socialty/Services/UserService.dart';
import 'package:socialty/pages/Home_Page.dart';
import 'package:socialty/providers/Home_Page_Provider.dart';

class LoginPageProvider extends ChangeNotifier {

  late AuthService _authService;

  String error="";
  


  LoginPageProvider(){
    _authService=GetIt.instance.get<AuthService>();
  }

    Future<void> Register(FormData data,BuildContext context) async{
    
    dynamic result= await _authService.Login(data);
    if(result['error']!=null){
      error=result['error'];
      notifyListeners();
    }

    if(result['token']!=null){

      //print(result['token']['result']);
      GetIt.instance.get<UserService>().jwttoken=result['token']['result'];
      

      GetIt.instance.get<HomePageProvider>().fetchInfo();
      GetIt.instance.get<HomePageProvider>().fetchPosts();


      Navigator.pop(context);
      
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));

    }
  }
}