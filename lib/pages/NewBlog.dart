import 'package:flutter/material.dart';

class NewBlog extends StatefulWidget {
  const NewBlog({ Key? key }) : super(key: key);

  @override
  _NewBlogState createState() => _NewBlogState();
}

class _NewBlogState extends State<NewBlog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.purple.shade900,
      ),
      body: Center(child: Text("Details"),),
    );
  }
}