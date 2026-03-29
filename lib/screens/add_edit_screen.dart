import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/api_service.dart';

class AddEditScreen extends StatefulWidget {
  final Post? post;

  const AddEditScreen({super.key, this.post});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();

    if (widget.post != null) {
      titleController.text = widget.post!.title;
      bodyController.text = widget.post!.body;
    }
  }

  void save() async {
    final post = Post(title: titleController.text, body: bodyController.text);

    if (widget.post == null) {
      await apiService.createPost(post);
    } else {
      await apiService.updatePost(widget.post!.id!, post);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post == null ? "Add Post" : "Edit Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(labelText: "Body"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: save, child: const Text("Save")),
          ],
        ),
      ),
    );
  }
}
