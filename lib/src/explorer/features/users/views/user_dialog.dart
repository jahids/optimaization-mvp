// lib/src/explorer/features/users/views/user_dialog.dart

import 'package:flutter/material.dart';
import 'package:optimaizationmvp/src/explorer/features/users/models/user_model.dart';

class UserDialog extends StatefulWidget {
  final User? user;
  final Function(User) onSave;

  const UserDialog({super.key, this.user, required this.onSave});

  @override
  _UserDialogState createState() => _UserDialogState();
}

class _UserDialogState extends State<UserDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _email;

  @override
  void initState() {
    super.initState();
    _name = widget.user?.name ?? '';
    _email = widget.user?.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.user == null ? 'Add User' : 'Edit User'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: _name,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
              onSaved: (value) {
                _name = value!;
              },
            ),
            TextFormField(
              initialValue: _email,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email';
                }
                return null;
              },
              onSaved: (value) {
                _email = value!;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              widget.onSave(
                User(id: widget.user?.id ?? 0, name: _name, email: _email),
              );
              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
