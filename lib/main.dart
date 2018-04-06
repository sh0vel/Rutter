import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:rutter/post/json_tags.dart';
import 'package:rutter/post/content.dart';
import 'package:flutter/material.dart';
import 'package:rutter/post/post_data.dart' as postData;
import 'package:timeago/timeago.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Posts(),
    );
  }
}

class Posts extends StatefulWidget {
  @override
  State createState() => new PostState();
}

class PostState extends State<Posts> {
  final baseUrl = 'https://reddit.com/.json?limit=12';
  var httpClient = new HttpClient();
  final List<Content> allPosts = new List();
  var _after = "";

  _get(String z) async {
    try {
      var request =
          await httpClient.getUrl(Uri.parse(baseUrl + '&after=$_after'));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var jsonString = await response.transform(utf8.decoder).join();
        Map decoded = jsonDecode(jsonString);
        if (decoded[data][after] != _after) {
          print('after: $_after, z: $z');
          _after = decoded[data][after];
          List kids = decoded[data][children];
          for (var kid in kids) {
            allPosts.add(new Content(
                kid[data][title],
                kid[data][author],
                kid[data][subreddit],
                kid[data][postHint],
                kid[data][permalink],
                kid[data][upvotes],
                kid[data][numComments],
                kid[data][dateTime],
                kid[data][over18]));
          }
        }
      }
    } catch (exception) {
      //failedd =(
    }
    setState(() {
      allPosts;
    });
  }

  @override
  void initState() {
    _get('a');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Front Page'),
      ),
      body: new PageView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (_cardBuilder, int index) {
            Content post = allPosts[index];
            if (index >= allPosts.length - 2) {
              _get(index.toString());
            }
            return new Card(
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.fromLTRB(2.0, 12.0, 2.0, 0.0),
                    child: new ListTile(
                      title: new Text(
                        post.title,
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                            fontSize: 16.5, fontWeight: FontWeight.w500),
                      ),
                      subtitle: new Padding(
                          padding: new EdgeInsets.only(top: 4.0),
                          child: new Text(
                              'by u/${post.author} in r/${post.subreddit}\n'
                              '${timeAgo(

                                  new DateTime.fromMillisecondsSinceEpoch(
                                      post.dateTime.floor() * 1000,
                                      isUtc: true))}'
                          )
                      ),
                      trailing: new Text(
                        post.upvotes.toString(),
                        style: new TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w900),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
