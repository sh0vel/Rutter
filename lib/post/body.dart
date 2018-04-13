import 'package:flutter/material.dart';
import 'package:rutter/post/content.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';


Widget postBodyUI(Content post) {
  String postHint = post.postHint;
  if (postHint != null) {
    print(postHint);
    if (postHint == "image" || postHint == 'rich:video') {
      return new Image.network(post.contentSrcUrl);
    } else if(postHint.contains('video')){
      final playerWidget = new Chewie(
        new VideoPlayerController.network(
            'https://flutter.github.io/assets-for-api-docs/videos/butterfly.mp4'),
        aspectRatio: 3 / 2,
        autoPlay: true,
        looping: true,
      );
      return playerWidget;
    }

    else {
      return new Card(
        child: new Text("obbydoobydoo"),
      );
    }
  } else {
    return new Card(
      child: new Text("obbydooby"),
    );
  }
}
