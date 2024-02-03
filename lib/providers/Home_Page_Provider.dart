import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:socialty/Services/UserService.dart';

class HomePageProvider extends ChangeNotifier {


  int currentPageIndex=0;

  dynamic UserInfo={};

  dynamic Posts=[];

  late UserService _userService;


  HomePageProvider(){
    _userService = GetIt.instance.get<UserService>();
  }




  Future<dynamic> fetchInfo() async{


    dynamic result=await _userService.Info();

    if(result!=null){


      if(result!="unauthorized"){

      UserInfo=result;
      
       notifyListeners();
      
      
      }



    }

   
   






  }
    Future<dynamic> AddPost(FormData data) async{


    dynamic result=await _userService.AddPost(data);
    //print(result);

    if(result!=null){


      if(result!="unauthorized"){

      Posts=result['posts'];
      UserInfo['posts']=result['userposts'];
      
       notifyListeners();
      
      
      }



    }

   
   






  }

  void changePage(int index){

    currentPageIndex=index;
    notifyListeners();

  }


    Future<dynamic> fetchPosts() async{


    dynamic result=await _userService.Posts();

    if(result!=null){


      if(result!="unauthorized"){

      Posts=result;
      //print(Posts);
      notifyListeners();
      
      
      }



    }

   
   






  }


}