import 'package:flutter/material.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late double _deviceHeight, _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _deviceWidth * 0.05,
        vertical: _deviceHeight * 0.02,
      ),
      height: _deviceHeight,
      width: _deviceWidth,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text("Posts", style: TextStyle(fontSize: 20)),
          _postsList(), //needs to be a postsView eventually to return a FutureBuilder
          _addPostButton(),
        ],
      ),
    );
  }
  
  Widget _postsList() {
    List posts = ["Placeholder", "Placeholder", "Placeholder"];

    return Expanded(
      child: ListView.builder(
        itemCount: posts.length,
        itemBuilder:(context, _index) {
          return ListTile(
            title: Text("${posts[_index]}"),
            subtitle: const Text("subtitle placeholder text"),
            trailing: const Icon(Icons.check_box_outline_blank),
            onTap:() {
              
            },
            onLongPress:() {
              
            },
          );
        },
      ),
    );
  }
  
  Widget _addPostButton() {
    return FloatingActionButton(
      onPressed:() {
      },
      child: const Icon(Icons.add),
    );
  }
}