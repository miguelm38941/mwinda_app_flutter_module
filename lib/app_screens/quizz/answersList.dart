import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mwinda/app_screens/quizz/answer.dart';
import 'package:mwinda/app_screens/quizz/question.dart';
import 'package:mwinda/app_screens/quizz/quizz.dart';

class AnswersList extends StatefulWidget {
  // Declare a field that holds the Zone.
  final Question question;

  // In the constructor, require a Zone.
  AnswersList({Key key, @required this.question}) : super(key: key);

  @override
  _AnswersListState createState() {
    // TODO: implement createState
    return new _AnswersListState(question);
  }
}

class _AnswersListState extends State<AnswersList> {
  Question question;
  // Constructor
  _AnswersListState(question) {
    this.question = question;
  }

  Future<List<Answer>> showCentres() async {
    var data = await http.get(
        'https://landela.org/mobileapi/quizz/reponses/question/' +
            this.question.id);
    var dataDecoded = json.decode(data.body);
    List<Answer> reponses = List();
    dataDecoded["result"].forEach((reponse) {
      reponses.add(new Answer(reponse["id"], reponse["libelle"],
          reponse["idquestion"], reponse["reponse"]));
    });
    return reponses;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          this.question.libelle,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: FutureBuilder(
              future: showCentres(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              ListTile(
                                //selected: true,
                                leading: Icon(Icons.keyboard_arrow_right),
                                title: Text(
                                    snapshot.data[index].libelle +
                                        " - " +
                                        snapshot.data[index].status,
                                    style: TextStyle(fontSize: 20.0)),
                                onTap: () {
                                  if (snapshot.data[index].status == "vrai") {
                                    print("PPPPPPPPPPPPPPPPPPPPPPPPPP " +
                                        this.question.toString());
                                    showPositiveAlertDialog(
                                        context, this.question);
                                  } else {
                                    showNegativeAlertDialog(
                                        context, this.question);
                                  }
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

  showPositiveAlertDialog(BuildContext context, Question question) {
    // set up the button
    print("NNNNNNNNNNNNNNNNNNNN " + question.toString());
    Widget launchButton = FlatButton(
      child: Text("Question suivante"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Quizz(question: question),
          ),
        );
      },
    ); // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Félicitations!"),
      content: Text("C'est une bonne réponse de trouvée!"),
      actions: [
        launchButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showNegativeAlertDialog(BuildContext context, Question question) {
    // set up the button
    print("NNNNNNNNNNNNNNNN " + question.toString());
    Widget launchButton = FlatButton(
      child: Text("Continuer"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Quizz(question: question),
          ),
        );
      },
    ); // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Ooouuups!"),
      content: Text("Ce n'est malheureusement pas la bonne réponse."),
      actions: [
        launchButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
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
