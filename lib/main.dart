import 'package:rutter/post/content.dart';
import 'package:flutter/material.dart';
import 'package:rutter/post/http.dart';
import 'package:rutter/post/postui.dart';

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
  final List<Content> allPosts = new List();

  _get() async {
    try {
      await getFrontpage(allPosts);
    } catch (exception) {
      print(exception.toString());
    }
    setState(() {
      allPosts;
    });
  }

  @override
  void initState() {
    _get();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Front Page'),
      ),
      body: _pageView(),
    );
  }

  Widget _pageView() {
    return new PageView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_cardBuilder, int index) {
          Content post = allPosts[index];
          print(post.contentSrcUrl);
          print(post.permaLink);
          if (index >= allPosts.length - 2) {
            _get();
          }
          return postUI(post);
        });
  }
}
