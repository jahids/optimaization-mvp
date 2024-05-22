// lib/src/explorer/features/users/views/user_list_screen.dart

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:optimaizationmvp/src/explorer/features/users/controllers/user_controller.dart';
import 'package:optimaizationmvp/src/explorer/features/users/models/user_model.dart';
import 'package:optimaizationmvp/src/explorer/features/users/views/user_dialog.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showUserDialog(context, controller),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Force a cache invalidation and refetch users
          await controller.usersQuery.refetch();
        },
        child: StreamBuilder<QueryState<List<User>>>(
          stream: controller.usersStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data?.data == null) {
              return const Center(child: Text('No users found.'));
            }

            final queryState = snapshot.data!;
            final users = queryState.data ?? [];

            if (queryState.status == QueryStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (queryState.status == QueryStatus.error) {
              return Center(child: Text('Error: ${queryState.error}'));
            }

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () =>
                            _showUserDialog(context, controller, user),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _showDeleteConfirmationDialog(
                            context, controller, user.id),
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

  void _showUserDialog(BuildContext context, UserController controller,
      [User? user]) {
    showDialog(
      context: context,
      builder: (context) => UserDialog(
        user: user,
        onSave: (User editedUser) {
          if (user == null) {
            controller.createUser(editedUser);
          } else {
            controller.updateUser(editedUser);
          }
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, UserController controller, int userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete User'),
        content: Text('Are you sure you want to delete this user?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              controller.deleteUser(userId);
              Navigator.of(context).pop();
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
