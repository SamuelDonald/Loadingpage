import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewLoginPage extends StatefulWidget {
  _NewLoginPage createState() => _NewLoginPage();
}

class _NewLoginPage extends State<NewLoginPage> {

  bool loading = false;
  final scafoldKey = GlobalKey<ScaffoldState>();
  TextEditingController userC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: scafoldKey,
            backgroundColor: Colors.indigo.withOpacity(.6),
            body: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
                children: [

                  Center(child: Icon(
                    Icons.account_circle, color: Colors.white,size: 90,),),
                  Center(child: Text("Login",style: TextStyle(color: Colors.white,
                      fontSize: 35,fontWeight: FontWeight.w200),),),
                  SizedBox(height: 40,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Text("Email", style: TextStyle(color: Colors.white,
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.w600),),
                      Container(
                        height: 60,
                        width: 250,
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white
                        ),

                        child: TextField(
                          controller: userC,
                          onChanged: (String text) {

                          },
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: "Username",
                            hintStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none,
                          ),

                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        height: 60,
                        width: 250,
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white
                        ),
                        child: TextField(
                          controller: passwordC,
                          onChanged: (String text) {

                          },
                          style: TextStyle(color: Colors.black,),
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          SizedBox(width: 80,),
                          FlatButton(onPressed: (){
                            print("clicked");
                          }, child:  Text("FORGOT YOUR PASSWORD?",style: TextStyle(color: Colors.white,
                                fontSize: 10,
                            fontWeight: FontWeight.w300),),)
                        ],
                      ),

                      SizedBox(height: 20,),
                      FlatButton(onPressed: (){
                        print("clicked");
                        if (validate() == true){
                          setState(() {
                            loading = true;
                          });
                          makePostRequest();
                        }

                      }, child:
                      loading == true ? CircularProgressIndicator(color: Colors.black,strokeWidth: 20,) :

                      Container(
                        height: 50,
                        width: 250,
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.lightBlue.withOpacity(.7)
                        ),
                        child: Center( child:Text("LOGIN",style: TextStyle(color: Colors.white,
                            fontSize: 20,
                        fontWeight: FontWeight.w300),),),
                      ),),
                      SizedBox(height: 100,),
                      Text("-----------------------------OR-----------------------------",
                        style: TextStyle(color: Colors.white),),
                      SizedBox(height: 30,),
                      Row(
                        children: [
                          SizedBox(width: 30,),
                          Container(
                            height: 70,
                            width: 70,
                            padding: EdgeInsets.only(left: 15,top: 15),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(300),
                            color: Colors.deepPurple,),
                            child: Text("Social Media",style: TextStyle(color: Colors.white,
                            fontSize: 15,fontWeight: FontWeight.w500),),
                          ),
                          SizedBox(width: 30,),
                          Container(
                            height: 70,
                            width: 70,
                            padding: EdgeInsets.only(left: 15,top: 15),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(300),
                              color: Colors.blue,),
                            child: Text("Social Media",style: TextStyle(color: Colors.white,
                                fontSize: 15,fontWeight: FontWeight.w500),),
                          ),
                          SizedBox(width: 30,),
                          Container(
                            height: 70,
                            width: 70,
                            padding: EdgeInsets.only(left: 15,top: 15),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(300),
                              color: Colors.red,),
                            child: Text("Social Media",style: TextStyle(color: Colors.white,
                                fontSize: 15,fontWeight: FontWeight.w500),),
                          ),

                        ],
                      ),
                    ],
                  ),

                ],
              ),
            )
        )
    );


  }
  bool validate(){
    if(userC.text.isEmpty){
      scafoldKey.currentState!.showSnackBar(
          new SnackBar(content: Text("ENTER USERNAME"))
      );
      return false;
    }
    if (passwordC.text.isEmpty) {
      scafoldKey.currentState!.showSnackBar(
          new SnackBar(content: Text("ENTER PASSWORD"))
      );
      return false;
    }
    if (passwordC.text.length < 6) {
      scafoldKey.currentState!.showSnackBar(
          new SnackBar(content: Text("Password is weak"))
      );
      return false;
    }
    return true;

  }



  void makePostRequest() async{
    try {
      var url = Uri.parse("http://51.104.186.105/apigw/token/login");

      var headers = {
        HttpHeaders.authorizationHeader: 'Bearer ',
        'Content-Type': 'application/problem+json; charset=utf-8'
      };
      var body = jsonEncode(<String,Object>{
        "channelId": 2,
        "deviceId": 'Android ID',
        "userName": userC.text.trim(),
        "password": passwordC.text.trim(),
      });
      var response = await http.post(url,body: body,headers:headers );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      var dataDecoded = jsonDecode(response.body);
      if(response.statusCode == 200){


        setState(() {
          loading = false;
        });

      } else{

        String msg = dataDecoded["message"];
        scafoldKey.currentState!.showSnackBar(
            new SnackBar(content: Text(msg))
        );

        setState(() {
          loading = false;
        });
      }
    } on SocketException catch (e){
      print(e.message);
      scafoldKey.currentState!.showSnackBar(
          new SnackBar(content: Text("No internet!"))
      );

      setState(() {
        loading = false;
      });
    }
  }
}

