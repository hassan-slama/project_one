import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_one/screens/categories.dart';
// import 'package:project_one/screens/sign_in.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
import '../search.dart';
import 'category_products.dart';
import 'drawer_screen.dart';
import 'models/user_model.dart';
class HomeScreen extends StatefulWidget{

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int current = 0;


  List <String> offers = ["https://www.gitsfood.com/wp-content/uploads/2021/11/Complete-Snackmix-Combo-600x600.jpg",
    "https://www.gitsfood.com/wp-content/uploads/2021/11/Complete-Snackmix-Combo-600x600.jpg"];


  final userModel = UserModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.uid).
    get().then((value) {
      userModel.name  = value.data()?['name'];
      userModel.phone  = value.data()?['phone'];
      userModel.email  = value.data()?['email'];
      userModel.id  = value.data()?['id'];
      userModel.image  = value.data()?['image'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff171717),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xffA71E27),
        title: const Text("24 Express",style: TextStyle(
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
      drawerScrimColor: Colors.transparent.withOpacity(0.75),
      drawer: DrawerScreen(userModel: userModel,),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
        ),

        child: BottomNavigationBar(
            selectedItemColor: Colors.red,
            currentIndex: current,
            onTap: (index){
              current = index;
            },
            items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Categories",
            icon: Icon(Icons.category),
          ),
          BottomNavigationBarItem(
            label: "Favourites",
            icon: Icon(Icons.favorite_border),
          ),
        ]),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(padding: const EdgeInsets.all(16),
            child: Row(

              children: [
                const Icon(Icons.category,color: Colors.white,size: 24,),
                const SizedBox(width: 8,),
                const Text("Categories",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Categories())
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xff8B8B8B),
                    ),
                    child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("see all",style: TextStyle(color: Colors.white,fontSize: 15),),
                        Icon(Icons.arrow_forward_ios,color: Colors.white,size: 15,),
                      ],
                    ),
                    ),
                  ),
                )
              ],
            ),

          ),
         FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
             future: FirebaseFirestore.instance.collection("categories").get(),
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
                  return SizedBox(height: 150,
                     child: ListView.builder(
                       physics: const BouncingScrollPhysics(),
                       padding: const EdgeInsets.symmetric(horizontal: 8),
                       scrollDirection: Axis.horizontal,
                       itemCount: snapshot.data?.docs.length,
                       itemBuilder: (context, index) {

                         return InkWell(
                           onTap: (){
                             Navigator.push(context,
                                 MaterialPageRoute(builder: (context) => CategoryProducts(
                                   categoryID: snapshot.data?.docs[index]['id'],
                                   categoryName: snapshot.data?.docs[index]['name'],
                                 )
                                 )
                             );
                           },
                           child: Column(
                             children: [
                               Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 16),
                                 child: Column(
                                   children: [
                                     CircleAvatar(
                                       radius: 58,
                                       backgroundImage: NetworkImage(snapshot.data?.docs[index]["image"]),

                                     ),
                                     const SizedBox(height: 10,),
                                     Text(snapshot.data?.docs[index]["name"],style: const TextStyle(color: Color(0xffC4C4C4),fontSize: 15,fontWeight: FontWeight.bold),)
                                   ],
                                 ),
                               ),
                             ],
                           ),
                         );
                       },

                     ),
                   );
               }
             }

         ),

          Padding(padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
          child: Row(
            children: const [
              Icon(Icons.percent,color: Colors.white,size: 32,),
              SizedBox(width: 8,),
              Text("Offers",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
            ],
          ),
          ),

          FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance.collection("products").where('has_offer',isEqualTo: true).get(),
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
                    return  SizedBox(height: 160,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(

                              width: 290,
                              height: 148,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(snapshot.data?.docs[index]['image']),
                                    fit: BoxFit.cover,
                                  ),
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                            ),
                          );
                        },

                      ),
                    );
                }
              }

          ),

          Padding(padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
            child: Row(
              children: const [
                Icon(Icons.percent,color: Colors.white,size: 32,),
                SizedBox(width: 8,),
                Text("Popular",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
              ],
            ),
          ),
          FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance.collection("products").where('cart_count', isGreaterThan: 10).get(),
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
                    return GridView.builder(
                      padding: EdgeInsets.all(16),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data?.docs.length,
                        scrollDirection: Axis.vertical,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        mainAxisSpacing: 16,
                          crossAxisSpacing: 16
                        ),
                        itemBuilder: (context,index){
                          return ClipRRect(
                            borderRadius:  BorderRadius.circular(15),
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Image.network(
                                      snapshot.data?.docs[index]['image'],
                                      fit: BoxFit.fill,width: double.maxFinite,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("${snapshot.data?.docs[index]['name']}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15
                                          ),),
                                        Text("${snapshot.data?.docs[index]['price']} LE",style:
                                        const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffA71E27),

                                        ),),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });

                }
              }

          ),



        ],
      ),
    );
  }
}