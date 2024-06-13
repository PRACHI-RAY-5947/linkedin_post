import 'package:flutter/material.dart';
import 'package:linkedin_post/routes/routes.dart';
import 'package:linkedin_post/screens/home_page/home_page.dart';
import 'package:linkedin_post/screens/post/post.dart';
import 'package:linkedin_post/screens/splash_page/splash_page.dart';

import 'detail_page/detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
        routes: {
          MyRoutes.splash_page: (context) => const SplashScreen(),
          MyRoutes.home_page: (context) => const HomePage(title: "",),
          MyRoutes.post_page: (context) => const CreatePost(),
          MyRoutes.detail_page: (context) => const DetailPage(),
        }
    );
  }
}

