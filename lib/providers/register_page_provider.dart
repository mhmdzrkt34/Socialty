

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:socialty/Services/AuthService.dart';

class RegisterPageProvider extends ChangeNotifier {
late AuthService _authService;
String error="";

  RegisterPageProvider(){
    _authService=GetIt.instance.get<AuthService>();
  }

  Future<void> Register(FormData data,BuildContext context) async{
    
    dynamic result= await _authService.Register(data);
    if(result['error']!=null){
      error=result['error'];
      notifyListeners();
    }
    if(result['register']!=null){

      Navigator.pushNamed(context, "login");
    }
  }


}