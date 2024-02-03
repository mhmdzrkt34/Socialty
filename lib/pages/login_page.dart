


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:socialty/providers/login_page_provider.dart';


class LoginPage extends StatelessWidget {
    late double _deviceWidth;
  late double _deviceHeight;
FormData _formData=FormData();
    GlobalKey<FormState> _globalKey=GlobalKey<FormState>();

 LoginPage();

  @override
  Widget build(BuildContext context) {
    _deviceHeight=MediaQuery.of(context).size.height;

    _deviceWidth=MediaQuery.of(context).size.width;

    return Scaffold(

      body: ChangeNotifierProvider.value(
        value: GetIt.instance.get<LoginPageProvider>(),
      child: SafeArea(
        child:
        Center(child:Column(children: [SocialtyLogo(),FormWidget(),ErrorLabel(),LoginButton(context),DontHaveAccountLabel(context)]) ,)
         
      ),
      ),
      
    );
  }


  Widget FormWidget(){

    return Form(
      key: _globalKey,
      child: Column(children: [EmailForm(),PasswordForm()],)
      
      );
  }

  Widget EmailForm(){

    return Container(
      margin: EdgeInsets.only(top: _deviceHeight*0.1),

      width: _deviceWidth*0.9,
      child: TextFormField(
      
        decoration: InputDecoration(hintText: "Email..."),
      
        onSaved: (value){
      
          _formData.fields.add(MapEntry("email", value!));
      
      
        },
        validator: (value){
          bool result=value!.contains(RegExp(r'^[\w-]+(\.[\w-]+)*@(gmail\.com|outlook\.com|hotmail\.com)$', caseSensitive: false));
      
      
          return result? null:"invalid email format";
      
      
        },
      ),
    );


  }

  Widget PasswordForm(){
    return Container(
      margin: EdgeInsets.only(top: _deviceHeight*0.04),
      width: _deviceWidth*0.9,
      
      child: TextFormField(
      
        decoration: InputDecoration(hintText:"Password..." ),
        onSaved: (value){
           _formData.fields.add(MapEntry("password", value!));
      
        },
        validator: (value){
          bool result=value!.contains(RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]+$'));
      
          return result? null: "weak password";
          
        },
      ),
    );


  }

  Widget ErrorLabel(){

    return Selector<LoginPageProvider,String>(selector: (context,provider)=>provider.error,
    
    builder: (context,value,child){

      return Container(
        
        width: _deviceWidth*0.9,
        child: Text(value,style: TextStyle(color: Colors.red),),);


    },
    );


  }
  Widget LoginButton(BuildContext context){

    return Container(
      margin: EdgeInsets.only(top: _deviceHeight*0.08),
      color: Colors.red,
      child: MaterialButton(
      minWidth: _deviceWidth*0.7,
      

      child: Text("Login",style: TextStyle(fontSize: 20,color: Colors.white),),
      onPressed: (){
        if(_globalKey.currentState!.validate()){
          _globalKey.currentState!.save();

          GetIt.instance.get<LoginPageProvider>().Register(_formData,context);
          _formData=FormData();
          
          

        }

      },
    ),);
  }



  Widget SocialtyLogo(){

    


    return Container(
      margin: EdgeInsets.only(top: _deviceHeight*0.08),
      
      child: Text("Socialty",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),);
  }
  Widget DontHaveAccountLabel(BuildContext context){

    return GestureDetector(
      onTap: (){
        Navigator.pushNamed( context, "register");

      },
      child:Container(
      margin: EdgeInsets.only(top: _deviceHeight*0.2),
      child: Text("Dont have An Acoount?",style: TextStyle(color: Colors.blue),),)
    );


  }
}