import 'package:flutter/material.dart';

const placeholderText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sit amet tristique neque, vel rhoncus est. Donec nisl tortor, hendrerit vitae eleifend nec, mattis sit amet tortor. Curabitur neque neque, accumsan id orci eu, dignissim molestie orci. Vivamus dui magna, lacinia ut tellus vitae, pellentesque tincidunt magna. Cras ac eros vitae neque eleifend semper. Ut a elit quis justo venenatis bibendum a fermentum ex. Maecenas sed lorem iaculis, luctus sem eu, semper massa. Maecenas a sagittis ante. In mollis sapien odio, nec vulputate purus pharetra sit amet.";

class ExpandedTile extends StatelessWidget {
  final String title;
  final String content;
  final String author;

  const ExpandedTile({
    super.key, 
    required this.title,
    required this.content,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      elevation: 4,
      margin: EdgeInsets.all(_padding(context)),
      color: colorScheme.onPrimary,
      child: Padding(
        padding: EdgeInsets.all(_padding(context)),
        child: ExpansionTile(
          title: _buildTile(context, title),
          subtitle: Text(author),
          trailing: Icon(
            Icons.keyboard_arrow_down,
            color: colorScheme.primary,
          ),
          children: <Widget> [
            Padding(
              padding: EdgeInsets.all(_padding(context)),
              child: Row(
                children: <Widget> [
                  Expanded(
                    child: Text(
                      content,
                      style: const TextStyle(
                        color: Colors.black,
                      )
                    ),
                  )
                ]
              ),
            )
          ]
        ),
      ),
    );
  }

  double _padding(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return MediaQuery.of(context).size.width * 0.03;
    } else {
      return MediaQuery.of(context).size.width * 0.01;
    }
  }
  
  Widget _buildTile(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row( 
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary, 
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ],
    );
  }
}
