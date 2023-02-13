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

  final String _instructions = """✍🏾 write a new post by tapping the button below\n💌 practice gratitude by taking action on the post\n🗑️ delete a post by pressing down and holding it""";

  _PostsPageState();

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(_padding(context)),
      height: _deviceHeight,
      width: _deviceWidth,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _pageTitleBanner(colorScheme),
          _postView(context),
          _addPostButton(),
        ],
      ),
    );
  }

  double _padding(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return MediaQuery.of(context).size.width * 0.05;
    } else {
      return MediaQuery.of(context).size.width * 0.03;
    }
  }

  Column _pageTitleBanner(ColorScheme colorScheme) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
              "Posts", 
              style: TextStyle(
                fontSize: 20, 
                color: colorScheme.onPrimaryContainer,
                letterSpacing: 1.0,
              ),
        ),
        Text(
          _instructions,
        ),
      ],
    );
  }
    
  Widget _postView(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: Hive.openBox('posts'),
        builder:(BuildContext _context, AsyncSnapshot _snapshot) {
          if (_snapshot.hasData) {
            _box = _snapshot.data;    
            return _postsList(context);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      );
    }

  Widget _postsList(BuildContext context) {
    List posts = _box!.values.toList();
    var colorScheme = Theme.of(context).colorScheme;

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder:(BuildContext _context, int _index) {
        var post = Post.fromMap(posts[_index]);
        return ListTile(
          textColor: colorScheme.onPrimaryContainer,
          iconColor: colorScheme.onPrimaryContainer,
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
              : Icons.volunteer_activism
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