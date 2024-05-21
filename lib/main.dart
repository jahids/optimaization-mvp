import 'package:cached_storage/cached_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:optimaizationmvp/src/core/bindings/initial_binding.dart';
import 'package:optimaizationmvp/src/explorer/features/posts/views/post_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure CachedQuery with persistent storage
  CachedQuery.instance.configFlutter(
    config: QueryConfigFlutter(
      refetchDuration: Duration(seconds: 4),
    ),
    storage: await CachedStorage.ensureInitialized(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Posts App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: InitialBinding(),
      home: PostListScreen(),
    );
  }
}
