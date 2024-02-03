

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:socialty/models/configiration.dart';
import 'package:socialty/providers/Home_Page_Provider.dart';

class ProfilePage extends StatelessWidget {
      late double _deviceWidth;
    late double _deviceHeight;


  ProfilePage();
  @override
  Widget build(BuildContext context) {
        _deviceHeight=MediaQuery.of(context).size.height;

    _deviceWidth=MediaQuery.of(context).size.width;

    return Scaffold(

      body: ChangeNotifierProvider.value(value: GetIt.instance.get<HomePageProvider>(),

      child: ProfileWidget(),
      
      
      ),
    );

  }

  Widget ProfileWidget(){

    return Selector<HomePageProvider,dynamic>(selector:(context,provider)=>provider.UserInfo ,
    builder: (context, value, child){

      if(value=={}){

        return Center(child: CircularProgressIndicator(),);
      }
      else {
      return Center(child:
      Column(children: [
        
        
        Profile(GetIt.instance.get<config>().serverPath+value["profile_Url"], ),PostsView()])
       ,);
      }


    });
    
    
  }

  Widget Profile(String path){




    return Container(

      width: 100,
      height: 100,
      margin: EdgeInsets.only(top: 10),

      decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: NetworkImage(path!),fit: BoxFit.cover)),
    );
  }

    Widget PostsView(){

    return Selector<HomePageProvider,dynamic>(selector: (selector,provider)=>provider.UserInfo['posts'],
    builder: (context, value, child){



        return

          Expanded(child:
          Center(child:
                             ListView.builder(
                    
                    
                    itemCount: value.length, itemBuilder: (BuildContext _context,int _index){

          return
          Container(

            margin: EdgeInsets.only(top: 15),
            width: _deviceWidth*0.83,
            height: _deviceHeight*0.3,

            decoration: BoxDecoration(image: DecorationImage(image: NetworkImage( GetIt.instance.get<config>().serverPath+value[_index]["post_Url"]),fit: BoxFit.contain)),
          );



        })) ,);
 
        



      }

    );
    


    
  }

  
}