
class ModelBookMark {
  num _id;
  String _title;
  String _description;
  String _url;
  String _publishedAt;
  String _author;
  String _source;
  String _content;
  String _imageUrl;
  String _category;
  bool _bookmarked;

  ModelBookMark(
      this._id, this._title, this._description, this._url, this._publishedAt, this._author, this._source, this._content, this._imageUrl,
        this._category, this._bookmarked);

  num get id=> _id;
  String get title=> _title;
  String get description=> _description;
  String get url=> _url;
  String get publishedAt=> _publishedAt;
  String get author=> _author;
  String get source=> _source;
  String get content=> _content;
  String get imageUrl=> _imageUrl;
  String get category=> _category;
  bool get bookmarked => _bookmarked;

  set id(num value) {
    _id = value;
  }

  set title(String value) {
    _title = value;
  }
  set description(String value) {
    _description = value;
  }
  set url(String value) {
    _url = value;
  }
  set publishedAt(String value) {
    _publishedAt = value;
  }
  set author(String value) {
    _author = value;
  }
  set source(String value) {
    _source = value;
  }
  set content(String value) {
    _content = value;
  }
  set imageUrl(String value) {
    _imageUrl = value;
  }
  set category(String value) {
    _category = value;
  }
  set bookmarked(bool value) {
    _bookmarked = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['url'] = _url;
    map['publishedAt'] = _publishedAt;
    map['author'] = _author;
    map['source'] = _source;
    map['content'] = _content;
    map['urlToImage'] = _imageUrl;
    map['category'] = _category;
    map['bookmarked'] = _bookmarked;
    return map;
  }
  ModelBookMark.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._url = map['url'];
    this._publishedAt = map['publishedAt'];
    this._author = map['author'];
    this._source = map['source'];
    this._content = map['content'];
    this._imageUrl = map['imageUrl'];
    this._category = map['category'];
    this._bookmarked = map['bookmarked'];
  }

}
