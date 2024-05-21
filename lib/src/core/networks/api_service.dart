// lib/core/network/api_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:optimaizationmvp/src/explorer/features/posts/models/post_model.dart';
import 'package:optimaizationmvp/src/core/utils/constants.dart';

class ApiService {
  static Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse(ApiConstants.baseUrl));
    if (response.statusCode == 200) {
      print(response.body);
      Iterable json = jsonDecode(response.body);
      return List<Post>.from(json.map((model) => Post.fromJson(model)));
    } else {
      throw Exception('Failed to load posts');
    }
  }

  static Future<Post> createPost(Post post) async {
    final response = await http.post(
      Uri.parse(ApiConstants.baseUrl),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(post.toJson()),
    );
    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create post');
    }
  }

  static Future<Post> updatePost(Post post) async {
    final response = await http.put(
      Uri.parse('${ApiConstants.baseUrl}/${post.id}'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(post.toJson()),
    );
    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update post');
    }
  }

  static Future<void> deletePost(int id) async {
    final response =
        await http.delete(Uri.parse('${ApiConstants.baseUrl}/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete post');
    }
  }
}
