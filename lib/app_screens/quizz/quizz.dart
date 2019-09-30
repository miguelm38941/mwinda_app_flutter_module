import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mwinda/app_screens/app_index.dart';
import 'package:mwinda/app_screens/quizz/answersList.dart';
import 'package:mwinda/app_screens/quizz/question.dart';

class Quizz extends StatefulWidget {
  // Declare a field that holds the Zone.
  final Question question;

  // In the constructor, require a Zone.
  Quizz({Key key, this.question, int id}) : super(key: key);

  @override
  _QuizzState createState() {
    // TODO: implement createState
    print("111111111111111111111111111111 - " + this.question.toString());
    return new _QuizzState(question);
  }
}

class _QuizzState extends State<Quizz> {
  Question question;
  // Constructor
  _QuizzState(Question question) {
    this.question = question;
    print("2222222222222222222222222 - " + this.question.toString());
  }

  Future<bool> _onWillPopScope() {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppIndex(),
      ),
    );
  }

  Future<Question> getResponses() async {
    var data;
    print("33333333333333333333333333333 " + this.question.toString());
    if (this.question == null) {
      data = await http
          .get('https://landela.org/mobileapi/quizz/questions/next/0');
    } else {
      data = await http.get(
          'https://landela.org/mobileapi/quizz/questions/next/' +
              this.question.id);
    }

    var dataDecoded = json.decode(data.body);

    //
    List<Question> questions = List();

    //dataDecoded["result"].forEach((question) {
    String id = dataDecoded["result"]["id"];
    String libelle = dataDecoded["result"]["libelle"];

    //questions.add(new Question(id, libelle));
    //});

    return new Question(id, libelle);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new WillPopScope(
        onWillPop: _onWillPopScope,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Quizz", style: TextStyle(color: Colors.white)),
          ),
          body: Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: FutureBuilder(
                  future: getResponses(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            alignment: Alignment(0.0, 200.0),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("QUESTION",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.lightBlue[600])),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            color: Colors.lightBlue[600],
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 32.0,
                                  bottom: 32.0,
                                  left: 16.0,
                                  right: 16.0),
                              child: Text(snapshot.data.libelle,
                                  style: TextStyle(
                                      fontSize: 30.0, color: Colors.white)),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            margin: const EdgeInsets.only(top: 40.0),
                            child: RaisedButton(
                              color: Colors.green,
                              child: Text(
                                "Go",
                                style: TextStyle(
                                    fontSize: 60.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AnswersList(question: snapshot.data),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(top: 30.0),
                            child: RaisedButton(
                              padding: const EdgeInsets.all(20.0),
                              color: Colors.red,
                              splashColor: Colors.redAccent,
                              child: Text(
                                "Terminer",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AppIndex(),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      );
                    } else {
                      final children = <Widget>[];

                      if (null != this.question) {
                        children.add(Container(child: Text("Done!")));
                      } else {
                        children.add(Align(
                          alignment: FractionalOffset.center,
                          child: CircularProgressIndicator(),
                        ));
                      }

                      return Column(
                        children: children,
                      );
                    }
                  })),
        ));
  }

  /*Padding displayAnswersList() {
    return Padding(
        padding: const EdgeInsets.all(0.0),
        child: FutureBuilder(
            future: getAnswers(),
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
                              title: Text(snapshot.data[index].status,
                                  style: TextStyle(fontSize: 15.0)),
                              onTap: () {
                                /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      //builder: (context) => CentreDetail(centre: snapshot.data[index]),
                                      ),
                                );*/
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
            }));
  }*/
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
