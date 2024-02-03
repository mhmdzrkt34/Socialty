

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:socialty/models/configiration.dart';
import 'package:socialty/providers/Home_Page_Provider.dart';

class FeedPage extends StatelessWidget {
    late double _deviceWidth;
    late double _deviceHeight;


  FeedPage();

  @override
  Widget build(BuildContext context) {
    _deviceHeight=MediaQuery.of(context).size.height;

    _deviceWidth=MediaQuery.of(context).size.width;



    return Scaffold(

      body: ChangeNotifierProvider.value(value: GetIt.instance.get<HomePageProvider>(),
      child:FeedView() ,
      ),
    );


  }



  Widget FeedView(){

    return Selector<HomePageProvider,dynamic>(selector: (selector,provider)=>provider.Posts,
    builder: (context, value, child){

      if(value==[]){

        return Center(child: CircularProgressIndicator(),);
      }
      else {
        return
          Center(child:
                   ListView.builder(itemCount: value.length, itemBuilder: (BuildContext _context,int _index){

          return
          Container(

            margin: EdgeInsets.only(top: 15),
            width: _deviceWidth*0.83,
            height: _deviceHeight*0.3,

            decoration: BoxDecoration(image: DecorationImage(image: NetworkImage( GetIt.instance.get<config>().serverPath+value[_index]["post_Url"]),fit: BoxFit.contain)),
          );



        }) ,);
        



      }

    });
    


    
  }
}