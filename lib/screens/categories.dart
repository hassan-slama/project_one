import 'package:flutter/material.dart';
import 'package:project_one/screens/home_screen.dart';

import '../search.dart';
import 'milk.dart';

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
      body: ListView(

          children: [
            Container(
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: HomeScreen().categoryImage.length,
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,),
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Milk())
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [

                            Image.network("${HomeScreen().categoryImage[index]}",
                              height: 150,width: 170,),
                            Container(
                              child: Text("${HomeScreen().categoryName[index]}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              )),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),

    );
  }
}
