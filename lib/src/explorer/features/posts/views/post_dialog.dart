// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:optimaizationmvp/src/explorer/features/posts/models/post_model.dart';

class PostDialog extends StatefulWidget {
  final Post? post;
  final void Function(Post) onSave;

  const PostDialog({Key? key, this.post, required this.onSave})
      : super(key: key);

  @override
  _PostDialogState createState() => _PostDialogState();
}

class _PostDialogState extends State<PostDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _body;

  @override
  void initState() {
    super.initState();
    _title = widget.post?.title ?? '';
    _body = widget.post?.body ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.post == null ? 'Add Post' : 'Edit Post'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: _title,
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
              onSaved: (value) => _title = value!,
            ),
            TextFormField(
              initialValue: _body,
              decoration: InputDecoration(labelText: 'Body'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the body';
                }
                return null;
              },
              onSaved: (value) => _body = value!,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              _formKey.currentState?.save();
              widget.onSave(Post(
                id: widget.post?.id ?? 0,
                title: _title,
                body: _body,
                userId:
                    widget.post?.userId ?? 1, // Replace with the actual userId
              ));
              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
