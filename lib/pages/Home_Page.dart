


import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:socialty/Services/UserService.dart';
import 'package:socialty/pages/Feed_page.dart';
import 'package:socialty/pages/Profile_page.dart';
import 'package:socialty/providers/Home_Page_Provider.dart';

class HomePage extends StatelessWidget {

  List<Widget> _pages=[FeedPage(),ProfilePage()];


  HomePage();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        actions: [CamerAction(),
        Logout()

        ],
        automaticallyImplyLeading: false,
        title: Container(child: Text("Socialty",style: TextStyle(color: Colors.white),),
        
      
      
      ),
      backgroundColor: Colors.red,
      ),
      body: ChangeNotifierProvider.value(value:GetIt.instance.get<HomePageProvider>(),
      child:Body() ,),

      bottomNavigationBar:ChangeNotifierProvider.value(value:GetIt.instance.get<HomePageProvider>(),
      child:BottomWidget() ,),
    );

  }

  Widget CamerAction(){

    return GestureDetector(
      onTap: (){
        FilePicker.platform.pickFiles(type: FileType.image).then((value){

          FormData data=FormData();
          File image=File(value!.files.first.path!);
          FileImage fileImage=FileImage(image);
          data.files.add(MapEntry("image",MultipartFile.fromFileSync(image.path,filename: "image.jpg")));

          GetIt.instance.get<HomePageProvider>().AddPost(data);
        

        });
       
        


      },

      child: Container(
        margin: EdgeInsets.only(right: 10),
        child: Icon(Icons.camera_alt,color: Colors.white,)),
    );
  }

  Widget Logout(BuildContext context){

        return GestureDetector(
      onTap: (){

        Navigator.pop(context);

        GetIt.instance.get<UserService>().jwttoken="";

        Navigator.pushNamed(context, "login");
      },

      child: Container(
        
        margin: EdgeInsets.only(right: 10),
        child: Icon(Icons.logout,color: Colors.white,)),
    );

  }
  Widget BottomWidget(){

    return 
    Selector<HomePageProvider,int>(selector: (context,provider)=>provider.currentPageIndex,
    builder: (context, value, child){
      return

          BottomNavigationBar(

            onTap: (index){

              GetIt.instance.get<HomePageProvider>().changePage(index);


            },
            backgroundColor: Colors.white,
            
            currentIndex: value,
            items: [

      BottomNavigationBarItem( label: "Feed", icon:Icon(Icons.feed)),
      BottomNavigationBarItem(label: "Profile", icon:Icon(Icons.person)),
      




    ],
    selectedItemColor: Colors.red,);



    }) ;
    
    

    


   



  }

  Widget Body(){
    return Selector<HomePageProvider,int>(selector: (context,provider)=>provider.currentPageIndex,
    
    builder:(context,value,child){

      return _pages[value];
    } ,
    );
  }
}