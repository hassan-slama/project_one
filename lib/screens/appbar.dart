


import 'package:flutter/material.dart';

import '../search.dart';
class ConstAppbar{
  AppBar appbar =AppBar(
    iconTheme: const IconThemeData(color: Colors.white),
    backgroundColor: const Color(0xffA71E27),
    title: const Text("24 Express",style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),),
    actions: [
      IconButton(icon: const Icon(Icons.search), onPressed: (){
        var context;
        showSearch(context: context, delegate: Search());
      }),
      const SizedBox(width: 16,),
      const Icon(Icons.shopping_cart_outlined,color: Colors.white,size: 32,),
      const SizedBox(width: 8,)
    ],
  );

}