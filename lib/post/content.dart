class Content {
  String _title;
  String _author;
  String _subreddit;
  String _postHint;
  String _permaLink;
  num _ups;
  num _numOfComments;
  bool _over18;

  Content(this._title, this._author, this._subreddit, this._postHint,
      this._permaLink, this._ups, this._numOfComments, this._over18);

  bool get over18 => _over18;

  num get numOfComments => _numOfComments;

  num get ups => _ups;

  String get permaLink => _permaLink;

  String get postHint => _postHint;

  String get subreddit => _subreddit;

  String get author => _author;

  String get title => _title;

  @override
  String toString() {
    return '_author: $_author';
  }


}
