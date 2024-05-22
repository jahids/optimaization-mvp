// lib/src/explorer/features/users/controllers/user_controller.dart

import 'package:get/get.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:optimaizationmvp/src/explorer/features/users/models/user_model.dart';
import 'package:optimaizationmvp/src/explorer/features/users/repositories/user_repository.dart';

class UserController extends GetxController {
  final UserRepository repository;
  late final Query<List<User>> usersQuery;

  UserController({required this.repository}) {
    usersQuery = Query<List<User>>(
      key: 'users',
      queryFn: () async {
        print('Fetching users from API...');
        return repository.fetchUsers();
      },
    );
  }

  Stream<QueryState<List<User>>> get usersStream => usersQuery.stream;

  Future<void> createUser(User user) async {
    print({'Creating user--->': user.toJson()});
    final createUserMutation = Mutation<dynamic, dynamic>(
      key: 'createUser',
      queryFn: (newUser) => repository.createUser(newUser),
      invalidateQueries: ['users'],
    );
    await createUserMutation.mutate(user);
  }

  Future<void> updateUser(User user) async {
    final updateUserMutation = Mutation<User, User>(
      key: 'updateUser',
      queryFn: (updatedUser) => repository.updateUser(updatedUser),
      refetchQueries: ['users'],
    );
    await updateUserMutation.mutate(user);
  }

  Future<void> deleteUser(int id) async {
    final deleteUserMutation = Mutation<void, int>(
      key: 'deleteUser',
      queryFn: (userId) => repository.deleteUser(userId),
      invalidateQueries: ['users'],
    );
    await deleteUserMutation.mutate(id);
  }
}
