import 'package:blogreal/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './pages/Authentication.dart';
import './pages/HomePage.dart';
import './services/Storage.dart';
import './services/AuthService.dart';

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> {
  var loading = true;
  final _storage = new SecureStorage();
  final _auth = new AuthService();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_){
    var _authStore = Provider.of<Auth>(context,listen: false);
      _storage.read('blogreal_auth_token').then((token){
        _auth.getUser(token).then((val){
          if(val['statusload']){
            _authStore.login(val['user']);
            setState(() {
              loading = false;
            });
          }else{
            setState(() {
              loading = false;
            });
          }
        });
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    if(loading) return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("BLOGREAL",style: TextStyle(fontSize: 32),),),
          SizedBox(height: 10,),
          CircularProgressIndicator(color: Colors.red,)
        ],
      ),
    );

      return Consumer<Auth>(builder: (context, data, child) => data.getLoggedIn() ? HomePage() : Authentication()
    );
  }
}
