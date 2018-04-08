import 'package:flutter/material.dart';
import 'package:rutter/post/content.dart';
import 'package:timeago/timeago.dart';

Widget postHeaderUI(Content post) {
  return new Padding(
    padding: new EdgeInsets.fromLTRB(2.0, 12.0, 2.0, 0.0),
    child: new ListTile(
      title: _title(post.title),
      subtitle: _subtitle(post.author, post.subreddit, post.dateTime),
      trailing: _trailing(post.upvotes),
    ),
  );
}

Widget _title(String title) {
  return new Text(
    title,
    textAlign: TextAlign.left,
    style: new TextStyle(fontSize: 16.5, fontWeight: FontWeight.w500),
  );
}

Widget _subtitle(String author, String subreddit, num dateTime) {
  return new Padding(
      padding: new EdgeInsets.only(top: 4.0),
      child: new Text('by u/$author in r/$subreddit\n'
          '${timeAgo(
              new DateTime.fromMillisecondsSinceEpoch(
                  dateTime.floor() * 1000,
                  isUtc: true))}'));
}

Widget _trailing(num upvotes) {
  return new Text(
    upvotes.toString(),
    textAlign: TextAlign.end,
    style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.w900),
  );
}
