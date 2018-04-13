class Content {
  String _title;
  String _author;
  String _subreddit;
  String _postHint;
  String _permaLink;
  String _contentSrcUrl;
  num _upvotes;
  num _numOfComments;
  num _dateTime;
  bool _over18;

  Content(this._title, this._author, this._subreddit, this._postHint,
      this._permaLink, this._upvotes, this._numOfComments, this._dateTime,
      this._over18, this._contentSrcUrl);

  bool get over18 => _over18;

  num get dateTime => _dateTime;

  num get numOfComments => _numOfComments;

  num get upvotes => _upvotes;

  String get permaLink => _permaLink;

  String get postHint => _postHint;

  String get subreddit => _subreddit;

  String get author => _author;

  String get title => _title;

  String get contentSrcUrl => _contentSrcUrl;
}
