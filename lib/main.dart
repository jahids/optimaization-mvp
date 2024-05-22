import 'package:cached_storage/cached_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:optimaizationmvp/src/core/bindings/initial_binding.dart';
import 'package:optimaizationmvp/src/explorer/features/posts/views/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Cached Storage to persist the cache to disk
  CachedQuery.instance.configFlutter(
    storage: await CachedStorage.ensureInitialized(),
    config: QueryConfigFlutter(
      cacheDuration: const Duration(days: 7), // Cache duration for the data
      // refetchDuration: Duration(seconds: 10), // Global refetch duration
      refetchDuration: const Duration(days: 7),
    ),
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
      home: const Dashboard(),
    );
  }
}
