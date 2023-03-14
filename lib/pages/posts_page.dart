import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:grateful/models/post.dart';
import 'package:intl/intl.dart';

const String _instructions = """✍🏾 write who/what you are grateful for\n💌 practice gratitude by taking action on that post\n🗑️ delete a post by swiping on it, or pressing & holding it""";

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  String? _newPostContent;
  Box? _box;

  _PostsPageState();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.primaryContainer,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(_padding(context)),
              child: _pageTitleBanner(colorScheme),
            ),
            _postView(),
            Padding(
              padding: EdgeInsets.all(_padding(context)),
              child: _addPostButton(context),
            ),
          ],
        ),
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
                fontSize: 18, 
                color: colorScheme.primary,
                decoration: TextDecoration.underline,
                letterSpacing: 1.0,
              ),
        ),
        Text(
          _instructions,
          textAlign: TextAlign.justify,
          style: TextStyle(
            color: colorScheme.onPrimaryContainer,
            fontSize: 14,
          )
        ),
      ],
    );
  }
    
  Widget _postView() {
    return Expanded(
      child: FutureBuilder(
        future: Hive.openBox('posts'),
        builder:(BuildContext _context, AsyncSnapshot _snapshot) {
          if (_snapshot.hasData) {
            _box = _snapshot.data;     
            return _postsList(_context);
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
      padding: EdgeInsets.all(_padding(context)),
      itemCount: posts.length,
      itemBuilder:(BuildContext _context, int _index) {
        var post = Post.fromMap(posts[_index]);
        return Dismissible(
          key: ValueKey<int>(_index),
          background: _backgroundContainerOnDismiss(colorScheme),
          onDismissed: (DismissDirection direction) {
            _box!.deleteAt(_index);
            setState(() {});
            ScaffoldMessenger.of(context).showSnackBar(
              _deleteConfirmationSnackBar(colorScheme)
            );
          },
          child: ListTile(
            contentPadding: EdgeInsets.all(_padding(context)),
            textColor: colorScheme.primary,
            iconColor: colorScheme.primary,
            title: _styledPostTitleContent(post),
            subtitle: _styledPostSubtitleDateTime(post, colorScheme),
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
              _box!.deleteAt(_index);
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Grateful Post Deleted."),
                  backgroundColor: colorScheme.primary,
                ),
              );
            },
          ),
        );
      },
    );
  }

  Row _styledPostSubtitleDateTime(Post post, ColorScheme colorScheme) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMEEEEd().format(post.timestamp).toString(),
                textAlign: TextAlign.left,
                style: TextStyle(color: colorScheme.secondary)
              ),
              Text("\tat\t", style: TextStyle(color: colorScheme.secondary)),
              Text(
                DateFormat.jm().format(post.timestamp).toString(),
                textAlign: TextAlign.right,
                style: TextStyle(color: colorScheme.secondary)
              )
            ],
          );
  }

  Text _styledPostTitleContent(Post post) {
    return Text(
            post.content,
            style: TextStyle(
              decoration: post.done ? TextDecoration.lineThrough 
                                    : TextDecoration.none
            ),
          );
  }

  SnackBar _deleteConfirmationSnackBar(ColorScheme colorScheme) {
    return SnackBar(
              content: const Text("Grateful Post Deleted."),
              backgroundColor: colorScheme.primary,
            );
  }

  Container _backgroundContainerOnDismiss(ColorScheme colorScheme) {
    return Container(
          color: colorScheme.error,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(
                Icons.delete,
                color: colorScheme.onError,
              ),
            ]
          )
        );
  }
    
  Widget _addPostButton(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return FloatingActionButton(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      tooltip: "Tap to write a new Grateful post",
      onPressed:() {
        _displayCreatePostPopup(colorScheme);
      },
      child: const Icon(Icons.add),
    );
  }

  void _displayCreatePostPopup(ColorScheme colorScheme) {
    showDialog(
      context: context, 
      builder: (BuildContext _context) {
        return AlertDialog(
          backgroundColor: colorScheme.primaryContainer,
          icon: const Icon(Icons.volunteer_activism),
          iconColor: colorScheme.primary,
          scrollable: true,
          title: _styledAlertDialogTitle(colorScheme),
          content: TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "I'm grateful for...",
              labelStyle: TextStyle(color: colorScheme.primary),
            ),
            onChanged: (_value) {
              setState(() => _newPostContent = _value);
            },
            onSubmitted: (_) {
              _setNewPost(); 
            },
          ),
          actions: <Widget> [
            TextButton( 
              onPressed: () => Navigator.of(context).pop(), 
              child: Text(
                "Cancel", 
                style: TextStyle(
                  color: colorScheme.error,
                )
              ),
            ),
            TextButton(
              onPressed: () => _setNewPost(), 
              child: const Text(
                "Save", 
                style: 
                TextStyle(color: Colors.blue)
              ),
            )
          ],
        );
      }     
    );
  }

  Text _styledAlertDialogTitle(ColorScheme colorScheme) {
    return Text(
          "New Grateful Post", 
          style: TextStyle(
            color: colorScheme.primary,
            )
        );
  }

  void _setNewPost() {
    if (_newPostContent != null) {
      var _post = Post(
        content: _newPostContent!, 
        timestamp: DateTime.now(), 
        done: false,
      );
      _box!.add(_post.toMap());
      setState(() {
        _newPostContent = null;
        Navigator.pop(context);
      });
    } 
  }
}
