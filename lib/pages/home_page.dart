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

  late double _deviceHeight, _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text("Grateful"), centerTitle: true,),
      bottomNavigationBar: gratefulBottomNavigationBar(),
      body: _pages[_currentPage],
    );
  }
  
  Widget gratefulBottomNavigationBar() {
    return Container(
      child: BottomNavigationBar(
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
      )
    );
  }
}