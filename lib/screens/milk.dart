import 'package:flutter/material.dart';
import 'package:project_one/screens/home_screen.dart';
import 'package:project_one/screens/product_screen.dart';

import '../search.dart';

class Milk extends StatefulWidget {
  const Milk({Key? key}) : super(key: key);

  @override
  State<Milk> createState() => _MilkState();
}

class _MilkState extends State<Milk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff171717),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xffA71E27),
        title: const Text(
          "Milk",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: Search());
              }),
          const SizedBox(
            width: 16,
          ),
          const Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
            size: 32,
          ),
          const SizedBox(
            width: 8,
          )
        ],
      ),
      body: ListView(physics: const BouncingScrollPhysics(), children: [
        InkWell(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (builder) => ProductScreen(),
              ),
                  (route) => false,
            );
          },
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(10),
            scrollDirection: Axis.vertical,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    height: 150,
                    // padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20)),
                              child: Container(
                                height: 200,
                                child: Image.network(
                                  "https://static5.depositphotos.com/1020804/534/i/450/depositphotos_5347226-stock-photo-splash-of-milk.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Container(
                              width: double.maxFinite,
                              height: double.maxFinite,
                              child: Center(
                                  child: Text(
                                "Milk",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                              decoration: BoxDecoration(
                                color: Color(0xffA71E27),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              );
            },
          ),
        ),
      ]),
    );
  }
}
