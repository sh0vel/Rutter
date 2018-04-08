import 'package:flutter/material.dart';
import 'package:rutter/post/content.dart';

Widget postBodyUI(Content post){
  if (post.postHint != null)
    return new Text(post.postHint);
  else
    return new Text("");
}