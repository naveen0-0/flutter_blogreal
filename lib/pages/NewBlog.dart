import 'package:blogreal/providers/auth.dart';
import 'package:blogreal/services/ApiService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewBlog extends StatefulWidget {
  const NewBlog({ Key? key }) : super(key: key);

  @override
  _NewBlogState createState() => _NewBlogState();
}

class _NewBlogState extends State<NewBlog> {
    final _formKey = GlobalKey<FormState>();
    bool _requestInProgress = false;
    String title = "";
    String description = "";
    final _apiService = new ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("New Blog"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.purple.shade900,
      ),
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value){
                          if (value == null || value.isEmpty) {
                            return 'Title cannot be empty';
                          }
                          return null;
                        },
                        onChanged: (value){
                          setState(() {
                            title = value;
                          });
                        },
                        decoration:InputDecoration(
                          prefixIcon: Icon(Icons.title,size: 20,color: Colors.purple.shade900,),
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          label: Text("Title"),
                          labelStyle: TextStyle(color: Colors.purple.shade900),
                          contentPadding: EdgeInsets.all(10),
                          filled: true,
                          fillColor: Colors.purple.shade100,
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
                        )
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        minLines: 1,
                        maxLines: 10,
                        onChanged: (value){
                          setState(() {
                            description = value;
                          });
                        },
                        validator: (value){
                          if (value == null || value.isEmpty) {
                            return 'Description cannot be empty';
                          }else if(value.length < 6){
                            return "Description should be atleast 6 characters";
                          }
                          return null;
                        },
                        decoration:InputDecoration(
                          label: Text("Description"),
                          labelStyle: TextStyle(color: Colors.purple.shade900),
                          prefixIcon: Icon(Icons.description,size: 20,color: Colors.purple.shade900,),
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          contentPadding: EdgeInsets.all(10),
                          filled: true,
                          fillColor: Colors.purple.shade100,
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),)
                        )
                      ),

                      SizedBox(height: 20,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Consumer<Auth>(
                            builder: (context, data, child){
                              return MaterialButton(
                                onPressed: _requestInProgress? () => null : (){
                                  if(_formKey.currentState!.validate()){
                                    setState(() {
                                      _requestInProgress = true;
                                    });
                                    //@ Make a request and print the response
                                    _apiService.newblog(title, description, data.getUsername()).then((val){
                                      if(val['statusload']){
                                        Navigator.pop(context, { "success" : true, "blog" : val['blog'] }); 
                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            duration: Duration(seconds: 2),
                                            content: Text(val['feedback']),
                                            backgroundColor: Colors.purple.shade900,
                                          )
                                        );
                                      }
                                      setState(() {
                                        _requestInProgress = false;
                                      });
                                    });
                                  }
                                },
                                child:  _requestInProgress ? SizedBox(width: 25, height: 25, child: Center(child: CircularProgressIndicator(color: Colors.white,))) :  Text("Create",style: TextStyle(fontSize: 18),),
                                color: Colors.purple.shade900,
                                textColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                              );
                            },
                          ),

                          MaterialButton(
                            onPressed: _requestInProgress? () => null : (){ 
                              Navigator.pop(context,{ "success":false }); 
                            },
                            child: Text("Cancel", style: TextStyle(fontSize: 18),),
                            color: Colors.red.shade900,
                            textColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
      ))
    );
  }
}