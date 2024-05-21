// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:optimaizationmvp/src/explorer/features/posts/models/post_model.dart';
import 'package:optimaizationmvp/src/explorer/features/posts/repositories/post_repository.dart';

class PostController extends GetxController {
  final PostRepository repository;
  late final Query<List<Post>> postsQuery;

  PostController({required this.repository}) {
    postsQuery = Query<List<Post>>(
      key: 'posts',
      queryFn: () async {
        print('Fetching posts from API...');
        return repository.fetchPosts();
      },
    );
  }

  Stream<QueryState<List<Post>>> get postsStream => postsQuery.stream;

  Future<void> createPost(Post post) async {
    print({'Creating post--->': post.toJson()});
    final createPostMutation = Mutation<dynamic, dynamic>(
      key: 'createPost',
      queryFn: (newPost) => repository.createPost(newPost),
      invalidateQueries: ['posts'],
    );
    await createPostMutation.mutate(post);
  }

  Future<void> updatePost(Post post) async {
    final updatePostMutation = Mutation<Post, Post>(
      key: 'updatePost',
      queryFn: (updatedPost) => repository.updatePost(updatedPost),
      refetchQueries: ['posts'],
    );
    await updatePostMutation.mutate(post);
  }

  Future<void> deletePost(int id) async {
    final deletePostMutation = Mutation<void, int>(
      key: 'deletePost',
      queryFn: (postId) => repository.deletePost(postId),
      invalidateQueries: ['posts'],
    );
    await deletePostMutation.mutate(id);
  }
}
