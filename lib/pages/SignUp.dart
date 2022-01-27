import 'package:blogreal/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../services/AuthService.dart';
import '../services/Storage.dart';

class SignUp extends StatefulWidget {
  final changeTab;
  const SignUp(this.changeTab, { Key? key }) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _storage = new SecureStorage();
  bool _hidePassword = true;
  String? _errorText = null;
  bool _requestInProgress = false;

  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text("Sign Up",style: TextStyle(fontSize: 32),),
              ),

              Center(child: SvgPicture.asset('assets/images/signup.svg',height: 200,)),

              Padding(
                padding: const EdgeInsets.all(30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value){
                          if (value == null || value.isEmpty) {
                            return 'Username cannot be empty';
                          }
                          return null;
                        },
                        onChanged: (value){
                          setState(() {
                            username = value;
                          });
                        },
                        decoration:InputDecoration(
                          errorText: _errorText,
                          errorStyle: TextStyle(fontSize: 14),
                          prefixIcon: Icon(Icons.person,size: 20,color: Colors.purple,),
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),borderSide: BorderSide.none),
                          hintText: "Username",
                          contentPadding: EdgeInsets.all(0),
                          filled: true,
                          fillColor: Colors.purple.shade100,
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),borderSide: BorderSide.none)
                        )
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        onChanged: (value){
                          setState(() {
                            password = value;
                          });
                        },
                        validator: (value){
                          if (value == null || value.isEmpty) {
                            return 'Password cannot be empty';
                          }else if(value.length < 6){
                            return "Password should be atleast 6 characters";
                          }
                          return null;
                        },
                        obscureText: _hidePassword,
                        decoration:InputDecoration(
                          errorStyle: TextStyle(fontSize: 14),
                          suffixIcon: IconButton(
                            splashRadius: 1,
                            icon: Icon(_hidePassword? Icons.visibility_off : Icons.visibility,color: Colors.purple,), 
                            onPressed: (){ setState(() => _hidePassword = !_hidePassword );
                          },),
                          prefixIcon: Icon(Icons.security,size: 20,color: Colors.purple,),
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),borderSide: BorderSide.none),
                          hintText: "Password",
                          contentPadding: EdgeInsets.all(0),
                          filled: true,
                          fillColor: Colors.purple.shade100,
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),borderSide: BorderSide.none)
                        )
                      ),

                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account? "),
                            InkWell(                        
                              child: Text("login",style: TextStyle(color: Colors.purple,fontWeight: FontWeight.w900),),                        
                              onTap: () => widget.changeTab(),                      
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Consumer<Auth>(
                        builder: (context, data, child){
                          return MaterialButton(
                          onPressed: (){
                            if(_formKey.currentState!.validate()){
                              setState(() {
                                _requestInProgress = true;
                              });
                              AuthService().signup(username, password).then((val){
                                if(val['statusload']){
                                  print(val);
                                  //@ Store token in device (TODO)
                                  _storage.write('blogreal_auth_token', val['token'].toString());
                                  data.login(val['user']);
                                  setState(() {
                                    _requestInProgress = false;
                                  });
                                }else{
                                  //@ Show a Snack bar
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 2),
                                      content: Text(val['feedback']),
                                      backgroundColor: Colors.purple.shade900,
                                    )
                                  );
                                  setState(() {
                                    _requestInProgress = false;
                                  });
                                }
                              });
                            }
                          },
                          child:  _requestInProgress ? SizedBox(width: 25, height: 25, child: Center(child: CircularProgressIndicator(color: Colors.white,))) :  Text("SIGN UP",style: TextStyle(fontSize: 18),),
                          color: Colors.purple.shade900,
                          textColor: Colors.white,
                          minWidth:MediaQuery.of(context).size.width / 2,
                          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                        );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}