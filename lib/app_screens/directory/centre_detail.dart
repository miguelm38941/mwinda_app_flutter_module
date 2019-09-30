import 'package:flutter/material.dart';
import '../my_home_page.dart';
import '../my_home_screen.dart';
import 'centre.dart';
import 'map_screen.dart';


class CentreDetail extends StatelessWidget {
  // Declare a field that holds the Post.
  final Centre centre;

  // In the constructor, require a Post.
  CentreDetail({Key key, @required this.centre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Post to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(this.centre.title, style: TextStyle(color: Colors.white),),
      ),
      body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Container(
              width: boxesWidth(context),
              padding: const EdgeInsets.all(16.0),
              child: Container(
                margin: EdgeInsets.only(bottom:0.0),
                child: Text(
                  this.centre.title,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize:30.0, fontWeight: FontWeight.bold),
                ),
              )
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: 5.0,
              margin: EdgeInsets.only(bottom:40.0),
              color: Colors.deepOrange,
            ),
            _buildFieldRow(context, "Type:", this.centre.type),
            _buildFieldRow(context, "Appartenance:", this.centre.appartenance),
            _buildFieldRow(context, "Type:", this.centre.adresse),
            RaisedButton(
              child: Text("Afficher sur une carte"),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapScreen(centre: this.centre),
                  ),
                );
              },
            )
          ],
      )
    );
  }

  Container _buildFieldRow(BuildContext context, String label, String fielddata) {
    return Container(
      width: boxesWidth(context),
      margin: EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            child: Text(
            label + ":",
              textAlign: TextAlign.right,
              style: TextStyle(fontSize:20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              fielddata,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize:20.0),
            ),
          )
        ],
      )
    );
  }

  double boxesWidth(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.4;
  }

}