import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class ApiService {
  final String baseUrl = "https://jsonplaceholder.typicode.com/posts";

  // GET
  Future<List<Post>> fetchPosts() async {
    try {
      final response = await http
          .get(Uri.parse(baseUrl))
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        return data.map((e) => Post.fromJson(e)).toList();
      } else {
        throw Exception("Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }

  // POST
  Future<Post> createPost(Post post) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(post.toJson()),
    );

    return Post.fromJson(jsonDecode(response.body));
  }

  // PUT
  Future<Post> updatePost(int id, Post post) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(post.toJson()),
    );

    return Post.fromJson(jsonDecode(response.body));
  }

  // DELETE
  Future<void> deletePost(int id) async {
    await http.delete(Uri.parse("$baseUrl/$id"));
  }
}
