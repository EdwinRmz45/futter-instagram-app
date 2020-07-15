import '../models/post.dart';

abstract class PostRepository {
  Future<Post> add(Post newPost);
  Future<Post> update(Post postToUpdate);
  Future<void> remove(int postId);
  Future<Post> find(int postId);
  Future<List<Post>> findAll();
  //Future<List<Post>> findByUserId(int userId);
  //Future<List<Post>> findByLikeId(int likeId);
  Future<List<Post>> findByCommentId(int commentId);
}