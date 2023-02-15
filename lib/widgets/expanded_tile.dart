import 'package:flutter/material.dart';

class ExpandedTile extends StatelessWidget {
  final String title;

  const ExpandedTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      elevation: 2,
      margin: EdgeInsets.all(_padding(context)),
      color: colorScheme.primaryContainer,
      child: Padding(
        padding: EdgeInsets.all(_padding(context)),
        child: ExpansionTile(
          title: _buildTile(context, title),
          trailing: const Icon(Icons.keyboard_arrow_down),
          children: <Widget> [
            Padding(
              padding: EdgeInsets.all(_padding(context)),
              child: Row(
                children: const <Widget> [
                  Expanded(
                    child: Text("Lorem ipsum dolor sit amet, consectetur"),
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
                color: Theme.of(context).colorScheme.onPrimaryContainer, 
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
