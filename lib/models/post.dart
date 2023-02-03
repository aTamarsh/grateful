class Post {
  /// Post class models the data of a Grateful post.
  String content;
  DateTime timestamp;
  bool done;

  Post({
    required this.content,
    required this.timestamp,
    required this.done,
  });

  factory Post.fromMap(Map post) {
    return Post(
      content: post['content'], 
      timestamp: post['timestamp'], 
      done: post['done'],
    );
  }

  Map toMap() {
    return {
      "content": content,
      "timestamp": timestamp,
      "done": done,
    };
  }
}
