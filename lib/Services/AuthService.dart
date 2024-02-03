

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class AuthService{

late Dio _dio;

AuthService(){
  _dio=GetIt.instance.get<Dio>();


}


Future<dynamic> Register(FormData data) async{

  try{

    dynamic Responce=await _dio.post("/Auth/register",
    data: data,options:Options(headers: {
      "content-type": "application/json",
      "accept": "application/json"
        

    }));
    return Responce.data;

    

  }catch(e){
    print(e);
    return null;
  }

}
Future<dynamic> Login(FormData data) async{

  try{

    dynamic Responce=await _dio.post("/Auth/login",
    data: data,options:Options(headers: {
      "content-type": "application/json",
      "accept": "application/json"
        

    }));
    
    return Responce.data;

    

  }catch(e){
    print(e);
    return null;
  }

}

}