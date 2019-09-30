import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mwinda/app_screens/directory/zonesante.dart';

import 'centre.dart';
import 'centre_detail.dart';

class CentresList extends StatefulWidget {
  // Declare a field that holds the Zone.
  final ZoneSante zone;

  // In the constructor, require a Zone.
  CentresList({Key key, @required this.zone}) : super(key: key);

  @override
  _CentresListState createState() {
    // TODO: implement createState
    return new _CentresListState(zone);
  }
}

class _CentresListState extends State<CentresList> {
  ZoneSante zone;
  // Constructor
  _CentresListState(zone) {
    this.zone = zone;
  }

  Future<List<Centre>> showCentres() async {
    var data = await http.get(
        'https://landela.org/mobileapi/centre_depistage/liste/' + this.zone.id);
    var dataDecoded = json.decode(data.body);

    List<Centre> centres = List();
    dataDecoded["result"].forEach((centre) {
      String id = centre["id"];
      String title = centre["centre"];

      //String body = centre["body"].replaceAll(RegExp(r'\n'), " ");
      String type = centre["type"];
      String appartenance = centre["appartenance"];
      String adresse = centre["adresse"];
      String phone = centre["phone"];
      String long = centre["longitude"];
      String lat = centre["latitude"];
      centres.add(
          new Centre(id, title, type, appartenance, adresse, phone, long, lat));
    });
    return centres;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Sélectionnez un centre"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: FutureBuilder(
              future: showCentres(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              ListTile(
                                //selected: true,
                                trailing: Icon(Icons.keyboard_arrow_right),
                                title: Text(snapshot.data[index].title,
                                    style: TextStyle(fontSize: 15.0)),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CentreDetail(
                                          centre: snapshot.data[index]),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ));
                      });
                } else {
                  return Align(
                    alignment: FractionalOffset.center,
                    child: CircularProgressIndicator(),
                  );
                }
                ;
              })),
    );
  }
}

class SnackBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: Text('Yay! A SnackBar!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          // Find the Scaffold in the widget tree and use
          // it to show a SnackBar.
          Scaffold.of(context).showSnackBar(snackBar);
        },
        child: Text('Show SnackBar'),
      ),
    );
  }
}
