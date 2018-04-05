import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'content.dart';

import 'json_tags.dart';

final baseUrl = 'https://reddit.com/.json?limit=10';
var httpClient = new HttpClient();
List<Content> allPosts = new List();
var _after;

Future<String> get(String url) async {
  var request = await httpClient.getUrl(Uri.parse(url+'&after=$_after'));
  print(url+'&after=$_after');
  var response = await request.close();
  var jsonString = "";
  if (response.statusCode == HttpStatus.OK) {
    jsonString = await response.transform(utf8.decoder).join();
    Map decoded = jsonDecode(jsonString);
    _after = decoded[data][after];
    List kids = decoded[data][children];
    for (var kid in kids){
      allPosts.add(new Content(kid[data][title], kid[data][author], kid[data][subreddit],
          kid[data][postHint], kid[data][permalink], kid[data][upvotes],
          kid[data][numComments], kid[data][over18]));
    }
    return 'Success';
  }
}


