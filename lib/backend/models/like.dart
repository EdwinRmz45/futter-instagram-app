class Like {
  int id;
  int userId;
  int postId;
  DateTime likeDate;

  static Like fromNewLike(int id, Like otherLike){
    var like = new Like();
    like.userId = otherLike.userId;
    like.postId = otherLike.postId;
    like.likeDate = otherLike.likeDate;
    like.id = id;
    return like;
  }
}