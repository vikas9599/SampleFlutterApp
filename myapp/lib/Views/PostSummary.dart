import 'package:flutter/material.dart';
import 'package:myapp/models/Post.dart';
import 'package:share/share.dart';

class PostSummary extends StatelessWidget {
  final Post post;

  PostSummary(this.post);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo App'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Share.share(post.title);
              },
              child: Icon(
                Icons.share,
                size: 20,
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(post.title),
          ),
        ),
      ),
    );
  }
}
