import './postgresql_connection_wrapper.dart';
import 'package:flutter_instagram_app/backend/models/post.dart';
import 'package:flutter_instagram_app/backend/repositories/post_repository.dart';

class PostPostgreSQLService implements PostRepository {
  
  // Attributes
  PostgreSQLConnectionWrapper _connectionWrapper;

  // Constructor
  PostPostgreSQLService(PostgreSQLConnectionWrapper this._connectionWrapper);
  
  @override
  Future<Post> add(Post newPost) async {
    if(newPost.postDate == null || newPost.id == null || newPost.userId == null) {
      throw new Exception("This post doesn't exists");
    }

    var result = await _connectionWrapper.connection.query("SELECT users.id FROM users WHERE user.id = ${newPost.userId}");
    if(result.first.elementAt(0) == null || result.first.elementAt(1) == null) {
      throw new Exception("User does not exists");
    }

    await _connectionWrapper.connection.query("INSERT INTO posts (user_id, description, photo_id, post_date) VALUES (@user_id, @description, @photo_id, @post_date)", substitutionValues: {
      "userId" : newPost.userId,
      "description" : newPost.description,
      "photoId" : newPost.photoId,
      "postDate" : newPost.postDate
      });

    result = await _connectionWrapper.connection.query("SELECT id FROM posts WHERE user_id =  @userId AND description = @description, photo_id = @photoId, post_date = @postDate", substitutionValues: {
      "userId" : newPost.userId,
      "description" : newPost.description,
      "photoId" : newPost.photoId,
      "postDate" : newPost.postDate
    });

    int newId = result.first.elementAt(0);
    return Post.fromNewPost(newId, newPost);
    
  }

  @override
  Future<Post> find(int postId) async{
    var result = await _connectionWrapper.connection.query("SELECT user_id, description, photo_id,post_date FROM posts WHERE user_id = $postId");
    var post = new Post();
    post.id = postId;
    post.userId = result.first.elementAt(0);
    post.description = result.first.elementAt(1);
    post.photoId = result.first.elementAt(2);
    post.postDate = result.first.elementAt(3);

    return post;
  }

  @override
  Future<List<Post>> findAll() async{
    
    List<Post> posts = [];
    var rows = await _connectionWrapper.connection.query("SELECT id, user_id, description, photo_id,post_date FROM posts");

    for(var row in rows) {
      var post = new Post();
      post.id = row.elementAt(0);
      post.userId = row.elementAt(1);
      post.description = row.elementAt(2);
      post.photoId = row.elementAt(3);
      post.postDate = row.elementAt(4);
      posts.add(post);
    }

    return posts;
  }

 // @override
  //Future<List<Post>> findByCommentId(int commentId) async{
    //List<Post> posts = [];
    //var rows = await _connectionWrapper.connection.query("SELECT id,user_id,description,photo_id,post_date FROM posts WHERE ");
  //}

  //@override
  //List<Post> findByLikeId(int likeId) {
    // TODO: implement findByLikeId
    //throw UnimplementedError();
  //}

  @override
  Future<List<Post>> findByUserId(int userId) async{
    List<Post> posts = [];
    var rows = await _connectionWrapper.connection.query("SELECT id, user_id, description, photo_id,post_date FROM posts WHERE user_id = $userId");

    for(var row in rows) {
      var post = new Post();
      post.id = row.elementAt(0);
      post.userId = userId;
      post.description = row.elementAt(1);
      post.photoId = row.elementAt(2);
      post.postDate = row.elementAt(3);
      posts.add(post);
    }

    return posts;
  }

  @override
  Future<void> remove(int postId) async{
    await _connectionWrapper.connection.query("DELETE FROM posts WHERE id = $postId");
  }

  @override
  Future<Post> update(Post postToUpdate) async{
    if(postToUpdate.id != null || postToUpdate.postDate == null || postToUpdate.description == null || postToUpdate.userId == null) {
      throw new Exception("This post contains null info");
    }

    var result = await _connectionWrapper.connection.query("SELECT post.id, users.id FROM posts, users WHERE post.id = ${postToUpdate.id} AND users.id =${postToUpdate.userId}");
    if(result.first.elementAt(0) == null || result.first.elementAt(1) == null) {
      throw new Exception ("User or post doesn't exist");
    }
  }

  @override
  Future<List<Post>> findByCommentId(int commentId) {
    
  }

}