// lib/features/posts/repositories/post_repository.dart

import 'package:optimaizationmvp/src/core/networks/api_service.dart';
import 'package:optimaizationmvp/src/explorer/features/posts/models/post_model.dart';

class PostRepository {
  Future<List<Post>> fetchPosts() async {
    return ApiService.fetchPosts();
  }

  Future<Post> createPost(Post post) async {
    return ApiService.createPost(post);
  }

  Future<Post> updatePost(Post post) async {
    return ApiService.updatePost(post);
  }

  Future<void> deletePost(int id) async {
    return ApiService.deletePost(id);
  }
}
