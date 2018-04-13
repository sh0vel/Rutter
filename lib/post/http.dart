import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:rutter/post/json_tags.dart';
import 'package:rutter/post/content.dart';

final baseUrl = 'https://reddit.com/.json?limit=12';
var httpClient = new HttpClient();
var _after = "";

Future getFrontpage(List<Content> allPosts) async {
  var request = await httpClient.getUrl(Uri.parse(baseUrl + '&after=$_after'));
  var response = await request.close();
  if (response.statusCode == HttpStatus.OK) {
    var jsonString = await response.transform(utf8.decoder).join();
    Map decoded = jsonDecode(jsonString);
    if (decoded[data][after] != _after) {
      _after = decoded[data][after];
      List kids = decoded[data][children];

      for (var kid in kids) {
        var _contentSrcUrl;
        var _postHint = kid[data][postHint];

        switch(_postHint){
          case 'image': _contentSrcUrl = kid[data][url]; break;
          case 'rich:video':
            List ar = kid[data][preview][images];
            _contentSrcUrl = ar[0][variants][gif][source][url]; break;
        }

        allPosts.add(new Content(
            kid[data][title],
            kid[data][author],
            kid[data][subreddit],
            kid[data][postHint],
            kid[data][permalink],
            kid[data][upvotes],
            kid[data][numComments],
            kid[data][dateTime],
            kid[data][over18],
            _contentSrcUrl));
      }
    }
  }
}
