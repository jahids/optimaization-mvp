import 'package:get/get.dart';
import 'package:optimaizationmvp/src/explorer/features/posts/repositories/post_repository.dart';
import 'package:optimaizationmvp/src/explorer/features/posts/controllers/post_controller.dart';
import 'package:optimaizationmvp/src/explorer/features/users/controllers/user_controller.dart';
import 'package:optimaizationmvp/src/explorer/features/users/repositories/user_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostRepository>(() => PostRepository());
    Get.lazyPut<PostController>(() => PostController(repository: Get.find()));

    Get.lazyPut<UserRepository>(() => UserRepository());
    Get.lazyPut<UserController>(() => UserController(repository: Get.find()));
  }
}
