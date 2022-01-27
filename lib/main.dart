import 'package:blogreal/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blogreal/providers/auth.dart';


void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Auth())
    ],
    builder:(context, child) {
      return MaterialApp(
        title: "BlogReal",
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      );
    },
  ));
}
