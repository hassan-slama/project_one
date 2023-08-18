
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_one/screens/home_screen.dart';
import 'package:project_one/screens/product_details.dart';

class UserCart extends StatefulWidget {
  const UserCart({Key? key}) : super(key: key);

  @override
  State<UserCart> createState() => _UserCartState();
}

class _UserCartState extends State<UserCart> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xff171717),
      appBar: AppBar(
        backgroundColor: const Color(0xffA71E27),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Your Cart",
            style:TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.bold) ),
          actions: [
      IconButton(icon: const Icon(Icons.search,size: 26,), onPressed: (){
      // var context;
      // showSearch(context: context, delegate: Search());
    }),
            IconButton(icon: const Icon(Icons.home_outlined,size: 26,), onPressed: (){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
              (context) => const HomeScreen(),), (route) => false);
            }),
    ]
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance.collection("users")
              .doc(FirebaseAuth.instance.currentUser?.uid).collection("cart").get(),
          builder: (context, snapshot) {
            num? orderCost ;

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

                return
                  snapshot.data?.docs.length==0
                  ? const Center(
                    child: Text('You Don\'t Have Items In Your Cart!' ,style: TextStyle(color: Color(0xffA71E27),
                        fontSize: 20,fontWeight: FontWeight.bold),),
                  )
                  :ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
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
                                      Text('Quantity: ${snapshot.data?.docs[index]['quantity']}',style: const TextStyle(color: Color(0xffA71E27),
                                          fontSize: 20,fontWeight: FontWeight.bold),),

                                      const SizedBox(height: 5,),
                                      Text('Total Cost: ${snapshot.data?.docs[index]['all_cost']}'
                                        ,style: const TextStyle(color: Color(0xffA71E27),
                                            fontSize: 18,fontWeight: FontWeight.bold),),

                                      const SizedBox(height: 5,),
                                      InkWell(
                                        onTap: () {
                                          showDialog(context: context, builder: (context) {
                                          return  AlertDialog(
                                              title: const Text('Delete This Item?'),
                                              actions: [
                                                InkWell(
                                                  onTap: () {
                                                 Navigator.pop(context);
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(10),
                                                    child: Container(
                                                      padding: const EdgeInsets.all(10),
                                                      color:  const Color(0xffA71E27),
                                                      child:  const Text('Cancel',style:
                                                      TextStyle(color: Colors.white,
                                                          fontSize: 20,fontWeight: FontWeight.bold),),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    FirebaseFirestore.instance.
                                                    collection("users")
                                                        .doc(FirebaseAuth.instance.currentUser?.uid)
                                                        .collection("cart")
                                                        .doc(snapshot.data?.docs[index].id).delete();
                                                    setState(() {
                                                    });
                                                    Navigator.pop(context);

                                                  },
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(10),
                                                    child: Container(
                                                      padding: const EdgeInsets.all(10),
                                                      color:  const Color(0xffA71E27),
                                                      child:  const Text('Delete',style:
                                                      TextStyle(color: Colors.white,
                                                          fontSize: 20,fontWeight: FontWeight.bold),),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },);


                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            color:  const Color(0xffA71E27),
                                            child: Icon(Icons.delete_forever_rounded,size: 20,color: Colors.white,)
                                            // const Text('Delete',style:
                                            // TextStyle(color: Colors.white,
                                            //     fontSize: 20,fontWeight: FontWeight.bold),),
                                          ),
                                        ),
                                      ),
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
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            color:  const Color(0xffA71E27),
                            child:  Center(
                              child: Text('$orderCost',style:
                              const TextStyle(color: Colors.white,
                                  fontSize: 20,fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            color:  const Color(0xffA71E27),
                            child:  Center(
                              child: Text('Checkout',style:
                              const TextStyle(color: Colors.white,
                                  fontSize: 20,fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ),

                      ],
                    ),
                  
                  ],
                );


            }
          }
      ),
    );

  }
}
