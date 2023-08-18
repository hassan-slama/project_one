import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_one/screens/user_cart_screen.dart';

import 'appbar.dart';

class ProductDetails extends StatefulWidget {
  final String categoryName;
  QueryDocumentSnapshot<Map<String, dynamic>> productDetails;
  ProductDetails(this.categoryName, this.productDetails, {Key? key})
      : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int counter = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff171717),
      appBar: CustomAppBarWidget(title: widget.categoryName),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        child: Container(
          color: Colors.white,
          height: 70,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .collection("cart")
                    .where('id', isEqualTo: widget.productDetails['id'])
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
                      return snapshot.data?.docs.length!=0
                          ? Center(
                            child: Text(
                                'You have ${snapshot.data?.docs[0]['quantity']} of this item in your cart'
                      ,style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xffA71E27)
                      ),),
                          )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(10)),
                                    child: InkWell(
                                      onTap: () {
                                        Map<String, dynamic> cartItem =
                                            widget.productDetails.data();
                                        cartItem.addAll({
                                          "quantity": counter,
                                          "all_cost": counter*widget.productDetails['price']
                                        });
                                        var newCartCount = widget.productDetails['cart_count']+counter;
                                        FirebaseFirestore.instance
                                            .collection("users")
                                            .doc(FirebaseAuth
                                                .instance.currentUser?.uid)
                                            .collection('cart')
                                            .add(cartItem);
                                       FirebaseFirestore.instance
                                           .collection('products')
                                        .doc(widget.productDetails.id).update({
                                           'cart_count': newCartCount
                                         });
                                        counter = 1;
                                        setState(() {

                                        });
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text("Added To Cart"),
                                              actions: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(10),
                                                      color: const Color(0xffA71E27),
                                                      child: const Text(
                                                        'Dismiss',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const UserCart(),
                                                        ));
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(10),
                                                      color: const Color(0xffA71E27),
                                                      child: const Text(
                                                        'To The Cart',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        color: const Color(0xffA71E27),
                                        height: 38,
                                        width: 100,
                                        child: const Center(
                                          child: Text(
                                            "add to cart",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (counter > 1) {
                                              counter--;
                                            }
                                          });
                                        },
                                        child: const Icon(
                                          Icons
                                              .indeterminate_check_box_outlined,
                                          color: Color(0xffA71E27),
                                          size: 38,
                                        ),
                                      ),
                                      Text(
                                        "$counter",
                                        style: const TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            counter++;
                                          });
                                        },
                                        child: const Icon(
                                          Icons.add_box_outlined,
                                          color: Color(0xffA71E27),
                                          size: 38,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                  }
                }),
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    alignment: Alignment.bottomCenter,
                    height: 340,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.shopping_cart,
                              size: 30,
                              color: Color(0xffA71E27),
                            ),
                            Text(
                              "${widget.productDetails['cart_count']}",
                              style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffA71E27)),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.favorite,
                              size: 30,
                              color: Color(0xffA71E27),
                            ),
                            Text(
                              "${widget.productDetails['fav_count']}",
                              style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffA71E27)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 15),
                    alignment: Alignment.bottomCenter,
                    height: 275,
                    color: const Color(0xffA71E27),
                    child: Row(
                      children: [
                        Text(
                          "${widget.productDetails['name']}",
                          style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Map<String, dynamic> lovedItem =
                            widget.productDetails.data();
                            lovedItem.addAll({
                              "is_loved": 1,
                            });

                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(FirebaseAuth
                                .instance.currentUser?.uid)
                                .collection('favourites')
                                .add(lovedItem);


                          },
                          child:

                          // widget.productDetails['is_loved']==1
                          //     ?
                          //     const Icon(
                          //     Icons.favorite,
                          //     size: 23,
                          //     color: Colors.white,
                          //     )
                          //     :

                          const Icon(
                            Icons.favorite_border,
                            size: 23,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          child: Container(
                            width: 120,
                            height: 40,
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                "${widget.productDetails['price']} LE",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Color(0xffA71E27),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: Image.network(
                    widget.productDetails['image'],
                    fit: BoxFit.fill,
                    width: double.maxFinite,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Like This",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("products")
                .where('id', isNotEqualTo: widget.productDetails['id'])
                .where('category_id',
                    isEqualTo: widget.productDetails['category_id'])
                .get(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const Text("none");
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());

                case ConnectionState.active:
                  return const Center(child: CircularProgressIndicator());

                case ConnectionState.done:
                  return SizedBox(
                    height: 200,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            child: InkWell(
                              onTap: () {
                                widget.productDetails =
                                    snapshot.data!.docs[index];
                                setState(() {});
                              },
                              child: Container(
                                width: 200,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 120,
                                      child: Image.network(
                                        snapshot.data?.docs[index]['image'],
                                        fit: BoxFit.fill,
                                        width: double.maxFinite,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                "${snapshot.data?.docs[index]['name']}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              Text(
                                                "${snapshot.data?.docs[index]['price']} LE",
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xffA71E27),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          const Icon(
                                            Icons.favorite_border,
                                            size: 35,
                                            color: Colors.grey,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
              }
            },
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
