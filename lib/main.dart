import 'package:flutter/material.dart';
import 'package:project_one/screens/change_password.dart';
import 'package:project_one/screens/sign_in.dart';
import 'package:project_one/screens/sign_up.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.grey,
      ),
      home: Scaffold(
            backgroundColor: Colors.white,
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   title: const Text("My Shop"),
        //   leading: const Icon(Icons.menu,size: 32,),
        //   actions: const [
        //     Icon(Icons.search,size: 40,color: Colors.grey,),
        //     SizedBox(width: 20,),
        //     // Icon(Icons.shopping_cart),
        //     // SizedBox(width: 16,)
        //   ],
        // ),
        body: SignIn(),

        ),
    );
  }
}

