import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../search.dart';

class ProductDetails extends StatefulWidget {
  final String categoryName;
  final QueryDocumentSnapshot<Map<String, dynamic>> productDetails;
  const ProductDetails(this.categoryName,this.productDetails,{Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff171717),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xffA71E27),

        title:  Text(
          widget.categoryName,
          style: const TextStyle(
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

      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            child: Stack(

              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                    alignment: Alignment.bottomCenter,
                    height: 340,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.shopping_cart,size: 30,color: Color(0xffA71E27),),
                            Text("${widget.productDetails['cart_count']}",
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffA71E27)
                            ),)
                          ],
                        ),
                        const SizedBox(width: 30,),
                        Row(
                          children: [
                            const Icon(Icons.favorite,size: 30,color: Color(0xffA71E27),),
                            Text("${widget.productDetails['fav_count']}",
                              style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffA71E27)
                              ),)
                          ],
                        ),                      ],
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 15),
                    alignment: Alignment.bottomCenter,
                    height: 275,
                    color: const Color(0xffA71E27),
                    child: Row(
                      children: [
                        Text("${widget.productDetails['name']}",
                          style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.favorite_border,
                        size: 23,
                          color: Colors.white,
                        ),
                        const Spacer(),
                        ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(50)),
                          child: Container(
                            width: 120,
                            height: 40,
                            color: Colors.white,
                            child: Center(
                              child: Text("${widget.productDetails['price']} LE",
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
                  child:Image.network(
                    widget.productDetails['image'],
                    fit: BoxFit.fill,width: double.maxFinite,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30,),
          const Text("Like This",style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),),
          const SizedBox(height: 20,),



          FutureBuilder(
              future: FirebaseFirestore.instance.collection("products").where('id' ,isNotEqualTo: widget.productDetails['id']).
              where('category_id' ,isEqualTo: widget.productDetails['category_id']).

              get(),
              builder: (context, snapshot) {
                switch(snapshot.connectionState){

                  case ConnectionState.none:
                    return const Text("none");
                  case ConnectionState.waiting:
                return const Center(
                child: CircularProgressIndicator()
                );

                case ConnectionState.active:
                return const Center(
                child: CircularProgressIndicator()
                );

                case ConnectionState.done:
                   return   SizedBox(
                     height: 200,
                     child: ListView.builder(

                       physics: const BouncingScrollPhysics(),
                       scrollDirection: Axis.horizontal,

                       itemCount: snapshot.data?.docs.length,
                       itemBuilder: (context, index) {
                         return  Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 10),
                           child: ClipRRect(
                             borderRadius: const BorderRadius.only(
                                 bottomLeft: Radius.circular(20),
                                 bottomRight: Radius.circular(20)
                             ),
                             child: Container(
                               width: 200,
                               color: Colors.white,
                               child: Column(
                                 children: [
                                   SizedBox(
                                     height: 120,
                                     child:Image.network(
                                       snapshot.data?.docs[index]['image'],
                                       fit: BoxFit.fill,width: double.maxFinite,
                                     ),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.all(16.0),
                                     child: Row(
                                       children: [
                                         Column(
                                           children: [
                                              Text("${snapshot.data?.docs[index]['name']}",
                                               style: const TextStyle(
                                                   fontWeight: FontWeight.bold,
                                                   fontSize: 20
                                               ),),
                                              Text("${snapshot.data?.docs[index]['price']} LE",style:
                                             const TextStyle(
                                               fontSize: 20,
                                               fontWeight: FontWeight.bold,
                                               color: Color(0xffA71E27),

                                             ),),
                                           ],
                                         ),
                                         const Spacer(),
                                         const Icon(Icons.favorite_border,size: 35,color: Colors.grey,)
                                       ],
                                     ),
                                   )
                                 ],
                               ),
                             ),
                           ),
                         );
                       },),
                   );

                }
              },
          ),


          const SizedBox(height: 30,),

          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),topRight: Radius.circular(25)),
            child: Container(
              color: Colors.white,
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        color: const Color(0xffA71E27),
                        height: 35,
                        width: 100,
                        child: const Center(
                          child: Text("add to cart",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18
                          ),),
                        ),
                      ),

                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          if(counter>0){
                            counter--;
                          }
                        });
                      },
                      child: const Icon(Icons.indeterminate_check_box_outlined,
                        color: Color(0xffA71E27),
                      size: 35,),
                    ),

                    Text("$counter",
                    style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: (){

                          setState(() {
                            counter++;
                          });

                      },
                      child: const Icon(Icons.add_box_outlined,
                      color: Color(0xffA71E27),
                      size: 35,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
