import 'package:blogreal/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/Storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _storage = new SecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Consumer<Auth>(
        builder: (context, data, child ){
          return  TextButton(child: Text("LOGOUT"), onPressed: (){
            _storage.delete('blogreal_auth_token');
            data.logout();
          },); 
        },
      )),
    );
  }
}

