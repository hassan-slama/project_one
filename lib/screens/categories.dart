import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_one/screens/home_screen.dart';

import '../search.dart';
import 'category_products.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff171717),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xffA71E27),
        title: const Text("Categories",style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: (){
            showSearch(context: context, delegate: Search());
          }),
          const SizedBox(width: 16,),
          const Icon(Icons.shopping_cart_outlined,color: Colors.white,size: 32,),
          const SizedBox(width: 8,)
        ],
      ),
      body:
          FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance.collection('categories').where('category_id',).get(),
              builder: (context, snapshot) {
            switch(snapshot.connectionState){

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
              return  GridView.builder(
                padding: EdgeInsets.all(16),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data?.docs.length,
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16
                  ),
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => CategoryProducts(
                          categoryID: snapshot.data?.docs[index]['id'],
                        categoryName: snapshot.data?.docs[index]['name'],
                        )
                        )
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [

                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                ),

                                child: Image.network("${snapshot.data?.docs[index]['image']}",
                                  fit: BoxFit.cover,),
                              ),
                            ),
                            Container(
                              height: 30,
                              child: Text("${snapshot.data?.docs[index]['name']}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  )),
                            ),
                          ],
                        ),
                      ),
                    );
                  });

            }
              },
          )


    );
  }
}
