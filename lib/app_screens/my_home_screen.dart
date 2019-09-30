import 'package:flutter/material.dart';

class MyHomeScreen extends StatelessWidget {
    @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
        color: Colors.lightBlueAccent,
      child: Center(
        child: Text(
          "Bienvenue sur Mwinda",
          textDirection: TextDirection.ltr,
          style: TextStyle(color: Colors.white, fontSize: 40.0),
        )
      ),
    );
  }



}