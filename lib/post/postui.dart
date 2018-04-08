import 'package:flutter/material.dart';
import 'package:rutter/post/content.dart';
import 'body.dart';
import 'header.dart';

Widget postUI(Content post){
  return new Card(
    child: new Column(
      children: <Widget>[
        postHeaderUI(post),
        postBodyUI(post),
      ],
    ),
  );
}
