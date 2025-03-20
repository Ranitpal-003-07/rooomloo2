import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PostUpdateScreen extends StatefulWidget {
  const PostUpdateScreen({super.key});

  @override
  State<PostUpdateScreen> createState() => _PostUpdateScreenState();
}

class _PostUpdateScreenState extends State<PostUpdateScreen> {
  final TextEditingController _postController = TextEditingController();
  File? _image;
  final List<Map<String, dynamic>> _posts = [];

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _postUpdate() {
    if (_postController.text.isNotEmpty || _image != null) {
      setState(() {
        _posts.insert(0, {
          'text': _postController.text,
          'image': _image,
          'likes': 0,
          'comments': [],
        });
        _postController.clear();
        _image = null;
      });
    }
  }

  void _likePost(int index) {
    setState(() {
      _posts[index]['likes'] += 1;
    });
  }

  void _addComment(int index, String comment) {
    setState(() {
      _posts[index]['comments'].add(comment);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Post Update")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextField(
                  controller: _postController,
                  decoration: const InputDecoration(
                    hintText: "What's on your mind?",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: _pickImage,
                      icon: const Icon(Icons.image),
                      label: const Text("Add Image"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _postUpdate,
                      child: const Text("Post"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_posts[index]['text'], style: const TextStyle(fontSize: 16)),
                        if (_posts[index]['image'] != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Image.file(_posts[index]['image'], height: 150),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.thumb_up),
                              onPressed: () => _likePost(index),
                            ),
                            Text("${_posts[index]['likes']} Likes"),
                            IconButton(
                              icon: const Icon(Icons.comment),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    TextEditingController commentController = TextEditingController();
                                    return AlertDialog(
                                      title: const Text("Add Comment"),
                                      content: TextField(controller: commentController),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            _addComment(index, commentController.text);
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Post"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            Text("${_posts[index]['comments'].length} Comments"),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
