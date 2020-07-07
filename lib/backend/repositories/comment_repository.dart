import '../models/comment.dart';

abstract class CommentRepository {
  Comment add(Comment newComment);
  Comment update(Comment commentToUpdate);
  bool remove(int commentId);
  Comment find(int commentId);
  List<Comment> findAll();
  List<Comment> findByPostId(int postId);  
}