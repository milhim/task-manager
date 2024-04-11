import 'package:flutter/material.dart';

class DetailsRow extends StatelessWidget {
  final String title;
  final String content;

  const DetailsRow({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              content,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
