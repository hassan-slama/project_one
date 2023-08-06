import 'package:flutter/material.dart';

import '../search.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int counter = 0;
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

      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            child: Stack(

              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                    alignment: Alignment.bottomCenter,
                    height: 340,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.shopping_cart,size: 30,color: Color(0xffA71E27),),
                            Text("100",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffA71E27)
                            ),)
                          ],
                        ),
                        SizedBox(width: 30,),
                        Row(
                          children: [
                            Icon(Icons.favorite,size: 30,color: Color(0xffA71E27),),
                            Text("100",
                              style: TextStyle(
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
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 25,horizontal: 15),
                    alignment: Alignment.bottomCenter,
                    height: 275,
                    color: Color(0xffA71E27),
                    child: Row(
                      children: [
                        Text("ALmarai Milk",
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.favorite_border,
                        size: 23,
                          color: Colors.white,
                        ),
                        Spacer(),
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          child: Container(
                            width: 120,
                            height: 40,
                            color: Colors.white,
                            child: Center(
                              child: Text("36.59 SAR",
                              style: TextStyle(
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
                Container(
                  height: 200,
                  child:Image.network(
                    "https://img.freepik.com/premium-psd/glass-milk-bottle-mockup-psd-with-label-product-packaging_53876-138348.jpg?w=2000",
                    fit: BoxFit.fill,width: double.maxFinite,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30,),
          Text("Like This",style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),),
          SizedBox(height: 20,),

          SizedBox(
            height: 200,
            child: ListView.builder(

              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,

              itemCount: 3,
              itemBuilder: (context, index) {
            return  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)
                ),
                child: Container(
                  width: 200,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        child:Image.network(
                          "https://img.freepik.com/premium-psd/glass-milk-bottle-mockup-psd-with-label-product-packaging_53876-138348.jpg?w=2000",
                          fit: BoxFit.fill,width: double.maxFinite,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text("ALmarai Milk",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                                ),),
                                Text("36.59 SAR",style:
                                  TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffA71E27),

                                  ),),
                              ],
                            ),
                            Spacer(),
                            Icon(Icons.favorite_border,size: 35,color: Colors.grey,)
                          ],
                        ),
                      )
                    ],
                  ),
                  ),
              ),
            );
            },),
          ),

          SizedBox(height: 30,),

          ClipRRect(
            borderRadius: BorderRadius.only(
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
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        color: Color(0xffA71E27),
                        height: 35,
                        width: 100,
                        child: Center(
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
                      child: Icon(Icons.indeterminate_check_box_outlined,
                        color: Color(0xffA71E27),
                      size: 35,),
                    ),

                    Text("$counter",
                    style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: (){

                          setState(() {
                            counter++;
                          });

                      },
                      child: Icon(Icons.add_box_outlined,
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
