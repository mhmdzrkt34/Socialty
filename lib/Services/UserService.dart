import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class UserService {

  late Dio _dio;
  late String jwttoken;
  

  UserService(){
      _dio=GetIt.instance.get<Dio>();

  }
  Future<dynamic> Info() async{

  try{

    dynamic Responce=await _dio.get("/User/info",
   options:Options(headers: {
      "content-type": "application/json",
      "accept": "application/json",
      "Authorization":"Bearer "+jwttoken
        

    }));

    if(Responce.statusCode==401){

      return "unauthorized";
    }
    return Responce.data;

    

  }catch(e){
    print(e);
    return null;
  }

}

  Future<dynamic> Posts() async{

  try{

    dynamic Responce=await _dio.get("/Post",
   options:Options(headers: {
      "content-type": "application/json",
      "accept": "application/json",
      "Authorization":"Bearer "+jwttoken
        

    }));

    if(Responce.statusCode==401){

      return "unauthorized";
    }
    return Responce.data;

    

  }catch(e){
    print(e);
    return null;
  }

}

  Future<dynamic> AddPost(FormData data) async{

  try{

    dynamic Responce=await _dio.post("/User/addpost",
    data: data,
   options:Options(headers: {
      "content-type": "application/json",
      "accept": "application/json",
      "Authorization":"Bearer "+jwttoken
        

    }));

    if(Responce.statusCode==401){

      return "unauthorized";
    }
    return Responce.data;

    

  }catch(e){
    print(e);
    return null;
  }

}
}