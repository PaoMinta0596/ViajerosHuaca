import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;
  const ExpandableText({this.maxLines, this.text});
  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = true;
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Text(widget.text,
            overflow: TextOverflow.fade,
            maxLines: _isExpanded ? 7 : widget.maxLines,
            style: TextStyle(fontSize: 17.0),
            textAlign: TextAlign.justify),
      );
}
