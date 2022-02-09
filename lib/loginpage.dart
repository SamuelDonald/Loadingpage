import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterlogin/intoaccount.dart';
import 'package:flutterlogin/newinfo.dart';
import 'package:flutterlogin/newpost.dart';
import 'package:flutterlogin/userinfo.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {


  bool loading = false;
  final scafoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scafoldKey,
        backgroundColor: Colors.lightBlue,
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
                Center(
                  child: Text("Sign in",
                    style: TextStyle(color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w600),),
                ),
                SizedBox(height: 40,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Email", style: TextStyle(color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),),
                    Container(
                      height: 60,
                      width: 300,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue.withOpacity(.7)
                      ),

                      child: TextField(
                        controller: emailC,
                        onChanged: (String text) {

                        },
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Enter Email",
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                        ),

                      ),
                    ),
                    SizedBox(height: 40,),
                    Text("Password", style: TextStyle(color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),),
                    SizedBox(height: 5),
                    Container(
                      height: 60,
                      width: 300,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue.withOpacity(.7)
                      ),
                      child: TextField(
                        controller: passwordC,
                        onChanged: (String text) {

                        },
                        style: TextStyle(color: Colors.black,),
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Enter Password",
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Row(
                      children: [
                        SizedBox(width: 150,),
                        FlatButton(
                          onPressed: () {
                            print("clicked");


                            //  SnackBar(
                            //   content: const Text('I have clicked it!'),
                            //   action: SnackBarAction(
                            //     label: 'Undo',
                            //     onPressed: () {
                            //       // Some code to undo the change.
                            //     },
                            //   ),
                            // );

                          },
                          child: Text("Forgot password ?",
                            style: TextStyle(color: Colors.white,
                                fontSize: 15, fontWeight: FontWeight.w600),),
                        ),
                      ],
                    ),
                    SizedBox(height: 40,),
                    Row(
                      children: [
                        Icon(Icons.check_box, color: Colors.white,),
                        SizedBox(width: 10,),

                        Text("Remember me",
                          style: TextStyle(color: Colors.white,
                              fontSize: 15, fontWeight: FontWeight.w600),),
                      ],
                    ),
                    SizedBox(height: 35,),
                    Column(
                      children: [


                     loading == true ? CircularProgressIndicator(color: Colors.green,strokeWidth: 20,) :  Container(
                          height: 60,
                          width: 300,
                          padding: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FlatButton(onPressed: () {
                                print("clicked");

                                // Navigator.push(context, MaterialPageRoute(
                                //     builder: (context) => IntoAcc()));


                                if (validate() == true) {
                                 setState(() {
                                   loading = true;
                                 });

                                 makePostRequest();

                                }
                              },
                                  child: Center(child: Text("LOGIN",
                                    style: TextStyle(color: Colors.lightBlue,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),),)),
                            ],
                          ),
                        ),
                        SizedBox(height: 30,),
                        Text("- OR -", style: TextStyle(color: Colors.white),),
                        SizedBox(height: 30,),
                        Text("Sign in with", style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),),
                        SizedBox(height: 40,),
                        Row(
                          children: [
                            SizedBox(width: 60,),
                            FlatButton(onPressed: () {
                              print("clicked");

                              //makePostRequest2();
                            }
                                , child: Icon(Icons.facebook, size: 60,
                                  color: Colors.white,)),
                            SizedBox(width: 25,),
                            FlatButton(onPressed: () {
                              print("clicked");
                              makeGetRequest2();
                            }
                                , child: Icon(Icons.facebook_sharp, size: 60,)),

                          ],
                        ),
                        SizedBox(height: 20,),
                        Text("Don't have an account sign in",
                          style: TextStyle(color: Colors.white,
                              fontSize: 15),)
                      ],
                    ),
                  ],

                ),

              ]

          ),
        ),
      ),
    );
  }


  bool validate() {
    if (emailC.text.isEmpty) {
      scafoldKey.currentState!.showSnackBar(
          new SnackBar(content: Text("ENTER EMAIL"))
      );

      return false;
    }
    if (!emailC.text.contains("@")) {
      scafoldKey.currentState!.showSnackBar(
          new SnackBar(content: Text("ENTER A VALID EMAIL"))
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


  void makeGetRequest() async {
    try {
      var url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
      var response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var dataDecoded = jsonDecode(response.body);
        List<dynamic> list = dataDecoded;
        List<UserInfo> allData = list.map((e) => UserInfo.fromJson(e)).toList();
        print(allData[4].id);
      } else {
        scafoldKey.currentState!.showSnackBar(
            new SnackBar(content: Text("Network error ...try again"))
        );
      }
    } on SocketException catch (e) {
      print(e.message);
      scafoldKey.currentState!.showSnackBar(
          new SnackBar(content: Text("No Connection found"))
      );
    }
  }




  void makeGetRequest2() async {
    try {
      var url = Uri.parse(
          "https://jsonplaceholder.typicode.com/posts/1/comments");
      var response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var dataDecoded = jsonDecode(response.body);
        List<dynamic> list = dataDecoded;
        List<NewInfo> alldata = list.map((e) => NewInfo.fromJson(e)).toList();
        print(alldata[4].id);
      }else {
    scafoldKey.currentState!.showSnackBar(
    new SnackBar(content: Text("Network error ...try again"))
    );

    }
    }on SocketException catch (e){
    print(e.message);
    scafoldKey.currentState!.showSnackBar(
    new SnackBar(content: Text("Network error ...try again"))
    );
    }

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
      "userName": emailC.text.trim(),
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