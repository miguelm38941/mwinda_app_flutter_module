import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mwinda/app_screens/directory/zones_list.dart';

import 'Province.dart';

class ProvincesList extends StatefulWidget {
  @override
  _ProvincesListState createState() {
    // TODO: implement createState
    return new _ProvincesListState();
  }
}

class _ProvincesListState extends State<ProvincesList> {
  // Prepare Data Source
  /*List<String> showProvinces() {
    var items = List<String>.generate(1000, (counter) => "Item $counter");
    return items;
  }*/

  Future<List<Province>> showProvinces() async {
    var data = await http.get('https://jsonplaceholder.typicode.com/posts');
    var dataDecoded = json.decode(data.body);

    List<Province> provinces = List();
    provinces.add(new Province("1", "Kinshasa"));
    provinces.add(new Province("2", "Haut Katanga"));
    provinces.add(new Province("3", "Maniema"));
    provinces.add(new Province("4", "Nord Kivu"));
    provinces.add(new Province("5", "Sud Kivu"));
    provinces.add(new Province("6", "Kasai"));
    provinces.add(new Province("7", "Equateur"));
    provinces.add(new Province("8", "Kwilu"));
    provinces.add(new Province("9", "Nord Ubangi"));
    provinces.add(new Province("10", "Congo Central"));
    provinces.add(new Province("11", "Tshopo"));
    provinces.add(new Province("12", "Kasai Central"));

    /*dataDecoded.forEach((province){
      String title = province["title"];
      if(title.length>25){
        title = province["title"].substring(1,25) + "...";
      }
      String body = province["body"].replaceAll(RegExp(r'\n'), " ");
      provinces.add(new Province(title, body));
      //debugPrint("ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" + province["title"]);
    });*/
    return provinces;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Les provinces"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: FutureBuilder(
            future: showProvinces(),
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
                                    builder: (context) => ZonesList(
                                        province: snapshot.data[index]),
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
            }),
      ),
    );
  }
}
