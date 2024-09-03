// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskproject/future/data/repository/store_repository.dart';
import 'package:taskproject/future/presentation/provider/store_provider.dart';
import 'package:taskproject/future/presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StoreProvider(
        storeRepo: StoreRepo(dio: Dio()),
      ),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home:  HomeScreen()),
    );
  }
}








/*

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:taskproject/future/presentation/provider/post_providers.dart';
import 'package:taskproject/future/presentation/screens/widgets/myListTile_item.dart';

import 'future/data/repository/post_repo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PostProvider(postRepo: PostRepo()),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Http Get Posts On Provider',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage()),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PostProvider>();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                // PostRepo().getPosts();
                vm.getPosts();
                PostProvider(postRepo: PostRepo()).getPosts();
              },
              icon: const Icon(Icons.get_app))
        ],
      ),
      body: ListView(padding: const EdgeInsets.all(12), children: [
        if (vm.isLoading) const CircularProgressIndicator(),
        if (vm.errorMessage.isEmpty && vm.posts.isEmpty && !vm.isLoading)
          const Text(
            'Список пусто, Загрузите данные',
            textAlign: TextAlign.center,
          ),
        if (vm.errorMessage.isEmpty && vm.posts.isNotEmpty && !vm.isLoading)
          ...vm.posts
              .map(
                (e) => MyListTileItem(
                    id: e.id.toString(), title: e.title, subtitle: e.subtitle),
              )
              .toList(),
        if (vm.errorMessage.isNotEmpty && !vm.isLoading)
          Text(
            vm.errorMessage,
            textAlign: TextAlign.center,
          )
      ]),

      //body: ListView.separated(
      //   itemBuilder: (context, index) => MyListTileItem(
      //       id: vm.posts[index].id.toString(),
      //       title: vm.posts[index].title,
      //       subtitle: vm.posts[index].subtitle),
      //   separatorBuilder: (context, index) => SizedBox(height: 10),
      //   itemCount: vm.posts.length,
      // ),
    );
  }
}






 */
