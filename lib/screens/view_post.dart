import 'package:blog/db/post_service.dart';
import 'package:blog/models/post.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'edit_post.dart';
import 'home.dart';

class PostView extends StatefulWidget {
  final Post post;

  PostView(this.post);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  void initState() {
    super.initState();
    timeago.setLocaleMessages('fr', timeago.FrMessages());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text(widget.post.title),
       ),
      body: Column(
        children: <Widget>[
           Row(
             children: <Widget>[
               Expanded(
                   child: Padding(
                     padding: const EdgeInsets.all(4.0),
                     child: Text(
                       timeago.format(DateTime.fromMillisecondsSinceEpoch(widget.post.date)),
                       style: TextStyle(color: Colors.grey, fontSize: 14.0),
                     ),
                   )),
               IconButton(icon: Icon(Icons.delete),onPressed: (){
                 _neverSatisfied();
               },),
               IconButton(icon: Icon(Icons.edit),onPressed: (){
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditPost(post:widget.post)));
               },),
             ],
           ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.post.body),
          ),
        ],
      ),
    );
  }

  Future<void> _neverSatisfied() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("Etes vous sûre de vouloir supprimer ce post ?")),
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Supprimer'),
              onPressed: () {
                PostService postService = new PostService(widget.post.toMap());
                postService.deletePost();
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                //Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }


}
