






import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:socialty/providers/register_page_provider.dart';

class RegisterPage extends StatelessWidget {

  late double _deviceWidth;
  late double _deviceHeight;
  FormData _formData=FormData();

    GlobalKey<FormState> _globalKey=GlobalKey<FormState>();

  RegisterPage();

  @override
  Widget build(BuildContext context) {

    _deviceHeight=MediaQuery.of(context).size.height;

    _deviceWidth=MediaQuery.of(context).size.width;







    return Scaffold(

      body: ChangeNotifierProvider.value(
        value: GetIt.instance.get<RegisterPageProvider>(),
      child: SafeArea(
        child:
        Center(child:Column(children: [SocialtyLogo(),FormWidget(),ErrorLabel(),RegisterButton(context),HaveAccountLabel(context)]) ,)
         
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
          _formData.fields.add(MapEntry("password", value!)  );
      
        },
        validator: (value){
          bool result=value!.contains(RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]+$'));
      
          return result? null: "weak password";
          
        },
      ),
    );


  }

  Widget ErrorLabel(){

    return Selector<RegisterPageProvider,String>(selector: (context,provider)=>provider.error,
    
    builder: (context,value,child){

      return Container(
        
        width: _deviceWidth*0.9,
        child: Text(value,style: TextStyle(color: Colors.red),),);


    },
    );


  }
  Widget RegisterButton(BuildContext context){

    return Container(
      margin: EdgeInsets.only(top: _deviceHeight*0.08),
      color: Colors.red,
      child: MaterialButton(
      minWidth: _deviceWidth*0.7,
      

      child: Text("Register",style: TextStyle(fontSize: 20,color: Colors.white),),
      onPressed: (){
        if(_globalKey.currentState!.validate()){
          _globalKey.currentState!.save();

          GetIt.instance.get<RegisterPageProvider>().Register(_formData,context);
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
  Widget HaveAccountLabel(BuildContext _context){

    return GestureDetector(

      onTap: (){
        Navigator.pushNamed(_context, "login");


      },

      child: Container(


      margin: EdgeInsets.only(top: _deviceHeight*0.2),
      child: Text("Already Have An Acoount?",style: TextStyle(color: Colors.blue),),),
    );

    
  }


}