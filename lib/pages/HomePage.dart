import 'package:blogreal/models/Blog.dart';
import 'package:blogreal/pages/BlogDetail.dart';
import 'package:blogreal/pages/NewBlog.dart';
import 'package:flutter/material.dart';
import '../services/Storage.dart';
import '../services/ApiService.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _storage = new SecureStorage();
  final _api = new ApiService();
  bool _loading = true;
  bool _error = false;
  List<Blog> _blogs = [];

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) { 
      _api.getBlogs().then((val) => {
        if(val['statusload']){
          val['blogs'].forEach((blog){
            final Blog _article = Blog( title: blog['title'], description: blog['description'], creator: blog['creator']);
              setState(() {
                _blogs.add(_article);
              });
            }),
          setState(() {
            _loading = false;
          })
        }else{
          setState(() {
            _loading = false;
            _error = true;
          })
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BLOGS"),
        backgroundColor: Colors.purple.shade900,
        elevation: 0,
        centerTitle: true,
      ),

      body: Center(
        child :_loading? CircularProgressIndicator() : 
        _error? TextButton(child: Text('Error'), onPressed: _retry,) : 
        ListView.builder(
          itemCount: _blogs.length,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetail(blog:_blogs[index])));
                },
                child: Card(
                  color: Colors.white24,
                  child: ListTile(
                    title: Text(_blogs[index].title),
                    subtitle: Text(_blogs[index].description,maxLines: 1,),
                  ),
                ),
              ),
            );
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.purple.shade900,
        onPressed: () async {
          var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => NewBlog()));
          if(result['success']){
            Blog _newblog = new Blog(title: result['blog']['title'], description: result['blog']['description'], creator: result['blog']['creator']);
            setState(() {
              _blogs.add(_newblog);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 2),
                content: Text("Blog Added Successfully"),
                backgroundColor: Colors.purple.shade900,
              )
            );
          }
        },
      ),
    );
  }

  void _retry() {
    setState(() {
      _loading = true;
    });
    _api.getBlogs().then((val) => {
      if(val['statusload']){
        val['blogs'].forEach((blog){
          final Blog _article = Blog( title: blog['title'], description: blog['description'], creator: blog['creator']);
          setState(() {
            _blogs.add(_article);
          });
        }),
        setState(() {
          _loading = false;
        })
      }else{
        setState(() {
          _loading = false;
          _error = true;
        })
      }
    });
  }
}

