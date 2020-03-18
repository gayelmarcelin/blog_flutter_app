import 'package:blog/db/post_service.dart';
import 'package:blog/models/post.dart';
import 'package:blog/screens/home.dart';
import 'package:flutter/material.dart';

class EditPost extends StatefulWidget {
  final Post post;

  EditPost({this.post});

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  final GlobalKey<FormState> formKey = new GlobalKey();
  //Post post = new Post(0,"","");

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Modifier le post"),
        elevation: 0.0,
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: widget.post.title,
                decoration: InputDecoration(
                  labelText: "Titre du post",
                  border: OutlineInputBorder(),
                ),
                onSaved: (val)=>widget.post.title = val,
                validator: (val){
                  if(val.isEmpty){
                    return "Le titre du post est obligatoire";
                  }else if(val.length<5){
                    return "Le titre du post doit avoir au moins 5 caractères";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: widget.post.body,
                decoration: InputDecoration(
                  labelText: "Corps du post",
                  border: OutlineInputBorder(),
                ),
                onSaved: (val)=>widget.post.body = val,
                validator: (val){
                  if(val.isEmpty){
                    return "Le corps du post est obligatoire";
                  }else if(val.length<10){
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
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
          //Navigator.pop(context);
        },
        child: Icon(Icons.edit,color: Colors.white,),
        backgroundColor: Colors.red,
        tooltip: "Edit  post",
      ),
    );

  }

  void insertPost() {
    final FormState form = formKey.currentState;
    if(form.validate()){
      form.save();
      form.reset();
      widget.post.date = DateTime.now().millisecondsSinceEpoch;
      PostService postService;
      postService = new PostService(widget.post.toMap());
      postService.updatePost();
    }
  }

}
