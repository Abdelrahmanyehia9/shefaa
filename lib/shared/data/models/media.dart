class Media {
  final String url;

  Media(this.url);

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(json['url']);
  }
}
