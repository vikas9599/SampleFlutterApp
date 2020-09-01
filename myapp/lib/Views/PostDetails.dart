import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:myapp/Views/PostSummary.dart';
import 'package:myapp/models/Post.dart';

class PostDetail extends StatefulWidget {
  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  Future<List<Post>> _getPosts() async {
    var response =
        await http.get('https://jsonplaceholder.typicode.com/photos');
    var jsonData = json.decode(response.body);

    List<Post> posts = [];
    for (var p in jsonData) {
      Post post =
          Post(p["albumID"], p["id"], p["title"], p["url"], p["thumbnailUrl"]);
      posts.add(post);
    }
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Container(
          child: FutureBuilder(
        future: _getPosts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Text('Loading ....'),
              ),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(snapshot.data[index].url),
                      ),
                      title: Text(snapshot.data[index].title),
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    PostSummary(snapshot.data[index])));
                      },
                    ),
                  );
                });
          }
        },
      )),
    );
  }
}
