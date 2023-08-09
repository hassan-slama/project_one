import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_one/screens/product_details.dart';

import '../search.dart';

class CategoryProducts extends StatefulWidget {
  final String categoryName;
  final String categoryID;
  const CategoryProducts({required  this.categoryName,required  this.categoryID  ,Key? key}) : super(key: key);

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff171717),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xffA71E27),
        title:  Text(
          "${widget.categoryName}",
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

      body:
      FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection("products").where('category_id' ,isEqualTo: widget.categoryID).get(),
    builder: (context, snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
          return Text("none");
        case ConnectionState.waiting:
          return Center(
            child: CircularProgressIndicator(),
          );
        case ConnectionState.active:
          return Center(
            child: CircularProgressIndicator(),
          );
        case ConnectionState.done:
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(10),
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    height: 150,
                    // padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => ProductDetails(widget.categoryName
                                ,snapshot.data!.docs[index]),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20)),
                                child: Container(
                                  height: 200,
                                  child: Image.network(
                                 snapshot.data?.docs[index]["image"],
                                  fit: BoxFit.fill,
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 2,
                              child: Container(
                                width: double.maxFinite,
                                height: double.maxFinite,
                                child: Center(
                                    child: Text(
                                      "${snapshot.data?.docs[index]["name"]}",
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
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              );
            },
          );
      }
    }
    )
    );
  }
}
