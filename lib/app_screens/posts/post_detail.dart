import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mwinda/app_screens/posts/post.dart';
import 'package:url_launcher/url_launcher.dart';

class PostDetail extends StatelessWidget {
  // Declare a field that holds the Post.
  final Post post;

  // In the constructor, require a Post.
  PostDetail({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                title: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 0.0, right: 28.0),
                  child: Text(
                    post.title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                background: Image.network(
                  post.image,
                  fit: BoxFit.cover,
                )),
          ),
        ];
      },
      body: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            color: Colors.lightBlue[600],
            child: Padding(
              padding: EdgeInsets.only(
                  top: 16.0, bottom: 16.0, left: 16.0, right: 16.0),
              child: Text(post.title,
                  style: TextStyle(fontSize: 20.0, color: Colors.white)),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            alignment: Alignment(0.0, 200.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Actualités",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontStyle: FontStyle.italic,
                      color: Colors.lightBlue[600])),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 30.0, bottom: 16.0, left: 16.0, right: 16.0),
              child: Html(
                data: post.text.toString(),
                padding: EdgeInsets.all(8.0),
                onLinkTap: (url) {
                  _launchURL();
                },
              ),
            ),
          ),
        ],
      ),
    ));

/*
  @override
  Widget build(BuildContext context) {
    // Use the Post to create the UI.
    return Scaffold(
      /*appBar: AppBar(
        title: Text(post.title),
      ),*/
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled)
        {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("Collapsing Toolbar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )
                  ),
                  background: Image.network(
                    "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                    fit: BoxFit.cover,
                  )
              ),
            ),
          ];
        }
            /*Container(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(post.text),
              ),
            )*/

    ),
    );*/
  }

  _launchURL() async {
    const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
