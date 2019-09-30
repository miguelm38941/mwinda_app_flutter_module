import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mwinda/app_screens/posts/post_detail.dart';

import 'post.dart';

class PostsList extends StatefulWidget {
  @override
  _PostsListState createState() {
    // TODO: implement createState
    return new _PostsListState();
  }
}

class _PostsListState extends State<PostsList> {
  // Prepare Data Source
  /*List<String> showPosts() {
    var items = List<String>.generate(1000, (counter) => "Item $counter");
    return items;
  }*/

  Future<List<Post>> showPosts() async {
    var data = await http
        .get('https://landela.org/mobileapi/blog/categories/posts/actualites');
    var dataDecoded = json.decode(data.body);

    List<Post> posts = List();
    dataDecoded['result'].forEach((post) {
      //debugPrint("BBBBBBBBBBBBBBBBBBBBBBBBBBBB" + post.tospring());
      String title = post["title"];
      if (title.length > 25) {
        title = post["title"]; //.substring(1,25) + "...";
      }
      String body = post["article"].replaceAll(RegExp(r'\n'), " ");
      posts.add(new Post(title, body, post["image"]));
    });
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Information",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
              future: showPosts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                            color: Colors.lightBlue[50],
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    goToPostDetail(
                                        context, snapshot.data[index]);
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Image.network(
                                        snapshot.data[index].image,
                                      ),
                                      Divider(),
                                      Text(
                                        snapshot.data[index].title,
                                        style: TextStyle(fontSize: 20.0),
                                      ), // overflow: TextOverflow.ellipsis,
                                      Divider(),
                                      //Text(snapshot.data[index].text, style: TextStyle(fontSize: 15.0)),
                                      /*Html(
                                  data: snapshot.data[index].text.toString().substring(0, 50),
                                ),
                                Divider(),*/
                                      /*RaisedButton(
                                    child: Text("Lire plus..."),
                                    onPressed: (){
                                      goToPostDetail(context, snapshot.data[index]);
                                    },
                                  )*/
                                    ],
                                  ),
                                )));
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

  void goToPostDetail(BuildContext context, dataIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostDetail(post: dataIndex),
      ),
    );
  }
}
