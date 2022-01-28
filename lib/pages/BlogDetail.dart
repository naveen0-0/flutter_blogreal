import 'package:blogreal/models/Blog.dart';
import 'package:flutter/material.dart';

class BlogDetail extends StatefulWidget {
  final Blog blog;
  const BlogDetail({ Key? key, required this.blog }) : super(key: key);

  @override
  _BlogDetailState createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.blog.title),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.purple.shade900,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(widget.blog.description,style: TextStyle(fontSize: 20),),
              Text(widget.blog.creator,style: TextStyle(fontSize: 20,color: Colors.purple.shade900,fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
    );
  }
}