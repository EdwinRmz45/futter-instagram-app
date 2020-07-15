class Post {
  int id;
  String description;
  int photoId;
  int userId;
  DateTime postDate;

  static Post fromNewPost(int id, Post otherPost) {
    var post = new Post();
    post.id = id;
    post.userId = otherPost.userId;
    post.description = otherPost.description;
    post.photoId = otherPost.photoId;
    post.postDate = otherPost.postDate;
  }
}