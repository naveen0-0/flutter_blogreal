import 'package:flutter/material.dart';

class BlogDetail extends StatefulWidget {
  const BlogDetail({ Key? key }) : super(key: key);

  @override
  _BlogDetailState createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
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