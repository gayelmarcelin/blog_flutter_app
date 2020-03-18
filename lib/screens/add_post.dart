import 'package:blog/db/post_service.dart';
import 'package:blog/models/post.dart';
import 'package:blog/screens/home.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final GlobalKey<FormState> formKey = new GlobalKey();
  Post post= Post(0, "", "");

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter un post"),
        elevation: 0.0,
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Titre du post",
                  border: OutlineInputBorder(),
                ),
                onSaved: (val)=>post.title = val,
                validator: (val){
                  if(val.isEmpty){
                    return "Le titre du post est obligatoire";
                  }
                  if(val.length<5){
                    return "Le titre du post doit avoir au moins 5 caractères";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Corps du post",
                  border: OutlineInputBorder(),
                ),
                onSaved: (val)=>post.body = val,
                validator: (val){
                  if(val.isEmpty){
                    return "Le corps du post est obligatoire";
                  }
                  if(val.length<10){
                    return "Le corps du post doit avoir au moins 10 caractères";
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          insertPost();
          //Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          Navigator.pop(context);
        },
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: Colors.red,
        tooltip: "Add a post",
      ),
    );

  }

  void insertPost() {
    final FormState form = formKey.currentState;
    if(form.validate()){
      form.save();
      form.reset();
      post.date = DateTime.now().millisecondsSinceEpoch;
      PostService postService;
      postService = new PostService(post.toMap());
      postService.addPost();
    }
  }

}
