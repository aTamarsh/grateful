import 'package:flutter/material.dart';
import 'package:grateful/pages/feed_page.dart';
import 'package:grateful/pages/posts_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  final List<Widget> _pages = [
    const FeedPage(),
    const PostsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Grateful"), centerTitle: true,),
      bottomNavigationBar: gratefulBottomNavigationBar(),
      body: _pages[_currentPage],
    );
  }
  
  Widget gratefulBottomNavigationBar() {
    return BottomNavigationBar(
        onTap: (_index) {
          setState(() {
           _currentPage = _index; 
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Feed",
            activeIcon: Icon(Icons.home_filled),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.volunteer_activism_outlined),
            label: "Posts",
            activeIcon: Icon(Icons.volunteer_activism),
          ),
        ],
        currentIndex: _currentPage,
    );
  }
}