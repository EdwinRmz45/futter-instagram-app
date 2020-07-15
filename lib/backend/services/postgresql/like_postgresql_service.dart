
import './postgresql_connection_wrapper.dart';
import '../../models/like.dart';
import '../../repositories/like_repository.dart';

class LikePostgreSQLService implements LikeRepository{
  
  // Attributes
  PostgreSQLConnectionWrapper _connectionWrapper;

  // Constructor
  LikePostgreSQLService(PostgreSQLConnectionWrapper this._connectionWrapper);

  @override
  Future<Like> add(Like newLike) async {
    if(newLike.likeDate == null || newLike.userId == null || newLike.postId==null){
      throw new Exception("This like doesn't exist or was deleted");
    }

    var result = await _connectionWrapper.connection.query("SELECT posts.id, users.id FROM posts, users WHERE post.id =${newLike.postId} AND users.id = ${newLike.userId}");
    if(result.first.elementAt(0) == null || result.first.elementAt(1) == null){
      throw new Exception("User or post doesnt exist");
    }

    await _connectionWrapper.connection.query("INSERT INTO likes (user_id, posts_id, like_date) VALUES (@userId, @postsId, @likeDate)", substitutionValues: {
      "userId" : newLike.userId,
      "postsId" : newLike.postId,
      "likeDate": newLike.likeDate
    });

    result = await _connectionWrapper.connection.query("SELECT id FROM likes WHERE user_id = @userId AND posts_id = @postsId, like_date = @likeDate", substitutionValues: {
      "userId" : newLike.userId,
      "postsId" : newLike.postId,
      "likeDate": newLike.likeDate
    });

    int newId = result.first.elementAt(0);
    return Like.fromNewLike(newId, newLike);
  }

  @override
  Future<Like> find(int likeId) async{
    
    var result = await _connectionWrapper.connection.query("SELECT user_id, posts_id, like_date FROM likes WHERE user_id = $likeId");
    var like = new Like();
    like.id = likeId;
    like.userId = result.first.elementAt(0);
    like.postId = result.first.elementAt(1);
    like.likeDate = result.first.elementAt(2);

    return like;
  }

  @override
  Future<List<Like>> findAll() async{
    
    List<Like> likes = [];
    var rows = await _connectionWrapper.connection.query("SELECT id, user_id, posts_id, like_date FROM likes");

    for(var row in rows) {
      var like = new Like();
      like.id = row.elementAt(0);
      like.userId = row.elementAt(1);
      like.postId = row.elementAt(2);
      like.likeDate = row.elementAt(3);
      likes.add(like);
    }

    return likes;
  }

  //@override
  //List<Like> findByCommentId(int commentId) {
    
  //}

  @override
  Future<List<Like>> findByPostId(int postId) async{
    List<Like> likes = [];
    var rows = await _connectionWrapper.connection.query("SELECT id, user_id, like_date FROM likes WHERE posts_id = $postId");

    for(var row in rows) {
      var like = new Like();
      like.id = row.elementAt(0);
      like.userId = row.elementAt(1);
      like.postId = postId;
      like.likeDate = row.elementAt(2);
      likes.add(like);
    }

    return likes;
  }

  @override
  Future<List<Like>> findByUserId(int userId) async{
    List<Like> likes = [];
    var rows = await _connectionWrapper.connection.query("SELECT id, posts_id, like_date FROM likes WHERE user_id = $userId");

    for(var row in rows) {
      var like = new Like();
      like.id = row.elementAt(0);
      like.userId = userId;
      like.postId = row.elementAt(1);
      like.likeDate = row.elementAt(2);
      likes.add(like);
    }

    return likes;
  }

  @override
  Future<void> remove(int likeId) async{
    await _connectionWrapper.connection.query("DELETE FROM likes WHERE id = $likeId");
  }

  @override
  Future<Like> update(Like likeToUpdate) async{
    if(likeToUpdate.id != null || likeToUpdate.userId == null || likeToUpdate.postId == null || likeToUpdate.likeDate == null){
      throw new Exception("This like doesn't exist");
    } 

    var result = await _connectionWrapper.connection.query("SELECT posts.id, users.id FROM posts, users WHERE posts.id = ${likeToUpdate.postId} AND users.id = ${likeToUpdate.userId}");   
    if(result.first.elementAt(0) == null || result.first.elementAt(1)){
      throw new Exception("User or post doesn't exist");
    }

    await _connectionWrapper.connection.query("UPDATE likes SET user_id = @userId, posts_id = @postId, like_date = @likeDate)",substitutionValues: {
      "userId" : likeToUpdate.userId,
      "postsId" : likeToUpdate.postId,
      "likeDate" : likeToUpdate.likeDate
    });
  }

}