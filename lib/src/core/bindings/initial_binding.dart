import 'package:get/get.dart';
import 'package:optimaizationmvp/src/explorer/features/posts/repositories/post_repository.dart';
import 'package:optimaizationmvp/src/explorer/features/posts/controllers/post_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostRepository>(() => PostRepository());
    Get.lazyPut<PostController>(() => PostController(repository: Get.find()));
  }
}
