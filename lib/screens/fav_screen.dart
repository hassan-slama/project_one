import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_one/screens/product_details.dart';

import 'appbar.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff171717),
      appBar: CustomAppBarWidget(title: 'Favourites'),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection("favourites")
              .get(),
          builder: (context, snapshot) {

            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Text("none");
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
                return snapshot.data?.docs.length == 0
                    ? const Center(
                        child: Text(
                          'You Don\'t Favourites Items!',
                          style: TextStyle(
                              color: Color(0xffA71E27),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : ListView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        children: [

                          GridView.builder(
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: .6,
                                crossAxisCount: 2,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16
                            ),
                            physics:  const BouncingScrollPhysics(),
                            // padding: EdgeInsets.all(16),
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => ProductDetails("",
                                        snapshot.data!.docs[index]),));
                                },
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        topLeft: Radius.circular(15),
                                      ),
                                      child: SizedBox(
                                        height: 150,
                                        width: double.maxFinite,
                                        child: Image.network(snapshot.data?.docs[index]['image'],
                                          fit: BoxFit.fill,),
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                      ),
                                      child: Container(
                                        width: double.maxFinite,
                                        color: Colors.white,
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 5,),
                                            Text("${snapshot.data?.docs[index]['name']}"
                                              ,style: const TextStyle(color: Colors.black,
                                                  fontSize: 20,fontWeight: FontWeight.bold),),

                                            const SizedBox(height: 5,),
                                            Icon(Icons.favorite),
                                            const SizedBox(height: 5,)

                                          ],

                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );

                            },
                          ),
                        ]);
            }
          }),
    );
  }
}
