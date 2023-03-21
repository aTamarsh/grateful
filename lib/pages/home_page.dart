import 'package:flutter/material.dart';
import 'package:grateful/pages/feed_page.dart';
import 'package:grateful/pages/posts_page.dart';

// HomePage houses routes to each BottomNavigationTab.
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
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primaryContainer,
        title: Text(
          "Grateful", 
          style: TextStyle(
            fontFamily: "LibreBaskerville",
            color: colorScheme.primary,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.0
          ),
        ), 
        centerTitle: true,
      ),
      bottomNavigationBar: gratefulBottomNavigationBar(context),
      body: _pages[_currentPage],
      backgroundColor: colorScheme.primaryContainer,
    );
  }
  
  Widget gratefulBottomNavigationBar(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.primary,
        border: Border(
          top: BorderSide(
            color: colorScheme.primary, 
            width: 1.0
          ),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: colorScheme.primaryContainer,
        unselectedItemColor: colorScheme.primary,
        selectedItemColor: colorScheme.primary,
        showUnselectedLabels: false,
          onTap: (_index) {
            setState(() {
             _currentPage = _index; 
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Feed",
              activeIcon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.volunteer_activism_outlined),
              label: "Posts",
              activeIcon: Icon(Icons.volunteer_activism),
            ),
          ],
          currentIndex: _currentPage,
      ),
    );
  }
}