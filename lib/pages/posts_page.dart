import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:grateful/models/post.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late double _deviceHeight, _deviceWidth;

  String? _newPostContent;
  Box? _box;

  _PostsPageState();

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
          _postView(),
          _addPostButton(),
        ],
      ),
    );
  }
    
  Widget _postView() {
    return Expanded(
      child: FutureBuilder(
        future: Hive.openBox('posts'),
        builder:(BuildContext _context, AsyncSnapshot _snapshot) {
          if (_snapshot.hasData) {
            _box = _snapshot.data;    
            return _postsList();
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      );
    }

  Widget _postsList() {
    List posts = _box!.values.toList();

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder:(BuildContext _context, int _index) {
        var post = Post.fromMap(posts[_index]);
        return ListTile(
          title: Text(
            post.content,
            style: TextStyle(
              decoration: post.done ? TextDecoration.lineThrough 
                                    : TextDecoration.none
            ),
          ),
          subtitle: Text(post.timestamp.toString()),
          trailing: Icon(
            post.done 
              ? Icons.check_box_outlined 
              : Icons.check_box_outline_blank
          ),
          onTap:() {
            setState(() {
              post.done = !post.done;
              _box!.putAt(_index, post.toMap());
            });
          },
          onLongPress:() {
            // TODO: "Delete" code here for deleting a Post.
          },
        );
      },
    );
  }
    
  Widget _addPostButton() {
    return FloatingActionButton(
      onPressed:() {
        UnimplementedError();
        // TODO: "Create" Code here for writing a new Post.
      },
      child: const Icon(Icons.add),
    );
  }
}