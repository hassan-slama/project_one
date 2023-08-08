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
  List <String> categoryName = ["Milk","Vegetables","Meat","Sea Food","Eggs"];

  List <String> categoryImage = ["https://static5.depositphotos.com/1020804/534/i/450/depositphotos_5347226-stock-photo-splash-of-milk.jpg",
    "https://www.kindpng.com/picc/m/46-464150_vegetable-chicken-curry-food-fruit-vegetables-png-transparent.png",
    "https://www.kindpng.com/picc/m/139-1392294_veal-raw-meats-hd-png-download.png",
    "https://www.kindpng.com/picc/m/428-4285266_sea-food-in-pakistan-png-download-mumbai-bhaucha.png",
    "https://www.kindpng.com/picc/m/69-698063_egg-png-transparent-png.png",
  ];
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
                  itemCount: categoryImage.length,
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

                            Image.network("${categoryImage[index]}",
                              height: 150,width: 170,),
                            Container(
                              child: Text("${categoryName[index]}",
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
