import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:optimaizationmvp/src/explorer/features/posts/controllers/post_controller.dart';
import 'package:optimaizationmvp/src/explorer/features/posts/models/post_model.dart';
import 'package:optimaizationmvp/src/explorer/features/posts/views/post_dialog.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PostController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showPostDialog(context, controller),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Force a cache invalidation and refetch posts
          controller.postsQuery.refetch();
        },
        child: StreamBuilder<QueryState<List<Post>>>(
          stream: controller.postsStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data?.data == null) {
              return const Center(child: Text('No posts found.'));
            }

            final posts = snapshot.data!.data!;

            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () =>
                            _showPostDialog(context, controller, post),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _showDeleteConfirmationDialog(
                            context, controller, post.id),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showPostDialog(BuildContext context, PostController controller,
      [Post? post]) {
    showDialog(
      context: context,
      builder: (context) => PostDialog(
        post: post,
        onSave: (Post editedPost) {
          if (post == null) {
            controller.createPost(editedPost);
          } else {
            controller.updatePost(editedPost);
          }
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, PostController controller, int postId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Post'),
        content: Text('Are you sure you want to delete this post?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              controller.deletePost(postId);
              Navigator.of(context).pop();
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
