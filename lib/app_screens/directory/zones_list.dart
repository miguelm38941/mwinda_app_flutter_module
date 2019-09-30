import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Province.dart';
import 'centre_list.dart';
import 'zonesante.dart';

class ZonesList extends StatefulWidget {
  // Declare a field that holds the Zone.
  final Province province;

  // In the constructor, require a Zone.
  ZonesList({Key key, @required this.province}) : super(key: key);

  @override
  _ZonesListState createState() {
    // TODO: implement createState
    return new _ZonesListState(province);
  }
}

class _ZonesListState extends State<ZonesList> {
  Province province;
  // Constructor
  _ZonesListState(province) {
    this.province = province;
  }

  // Prepare Data Source
  /*List<String> showProvinces() {
    var items = List<String>.generate(1000, (counter) => "Item $counter");
    return items;
  }*/

  Future<List<ZoneSante>> showZones() async {
    var data = await http
        .get('http://landela.org/mobileapi/zones/liste/' + this.province.id);
    var dataDecoded = json.decode(data.body);

    List<ZoneSante> zones = List();
    dataDecoded["result"].forEach((zone) {
      String title = zone["zones"];
      String id = zone['id'];
      //String body = zone["body"].replaceAll(RegExp(r'\n'), " ");
      zones.add(new ZoneSante(id, title));
    });
    return zones;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Sélectionnez une zone"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: FutureBuilder(
              future: showZones(),
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
                                      builder: (context) => CentresList(
                                          zone: snapshot.data[index]),
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
