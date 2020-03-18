import 'package:firebase_database/firebase_database.dart';

class PostService{
  String modelname = "posts";
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference _databaseReference;
  final Map post;

  PostService(this.post);

  addPost(){
    //_databaseReference = database.reference().child(modelname);
    database.reference().child(modelname).push().set(post);
  }

  deletePost(){
    database.reference().child('$modelname/${post['key']}').remove();
  }

  updatePost(){
    database.reference().child('$modelname/${post['key']}').update(
      {"title":post['title'],"body":post['body'],"date":post['date']}
    );
  }
}