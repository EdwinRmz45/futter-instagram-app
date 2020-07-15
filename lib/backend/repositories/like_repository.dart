import '../models/like.dart';

abstract class LikeRepository {
  Future<Like> add(Like newLike);
  Future<Like> update(Like likeToUpdate);
  Future<void> remove(int likeId);
  Future<Like> find(int likeId);
  Future<List<Like>> findAll();
  Future<List<Like>> findByUserId(int userId);
  Future<List<Like>> findByPostId(int postId);
  //List<Like> findByCommentId(int commentId);
}