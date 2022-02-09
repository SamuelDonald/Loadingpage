import 'package:flutter/material.dart';

class IntoAcc extends StatefulWidget{
  _IntoAcc createState() =>  _IntoAcc();
}

class  _IntoAcc extends State<IntoAcc> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(

        ),
      ),
    ));
  }
}