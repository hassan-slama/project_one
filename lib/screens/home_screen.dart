import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget{
  List <String> categoryName = ["Milk","Vegetables","Meat","Sea Food","Eggs"];
  List <String> categoryImage = ["https://static5.depositphotos.com/1020804/534/i/450/depositphotos_5347226-stock-photo-splash-of-milk.jpg",
  "https://www.kindpng.com/picc/m/46-464150_vegetable-chicken-curry-food-fruit-vegetables-png-transparent.png",
  "https://www.kindpng.com/picc/m/139-1392294_veal-raw-meats-hd-png-download.png",
  "https://www.kindpng.com/picc/m/428-4285266_sea-food-in-pakistan-png-download-mumbai-bhaucha.png",
  "https://www.kindpng.com/picc/m/69-698063_egg-png-transparent-png.png",
  ];
  List <String> offers = ["https://www.gitsfood.com/wp-content/uploads/2021/11/Complete-Snackmix-Combo-600x600.jpg",
    "https://www.gitsfood.com/wp-content/uploads/2021/11/Complete-Snackmix-Combo-600x600.jpg"];
  List <String> popularProductsImage =[
    "https://www.thecookierookie.com/wp-content/uploads/2023/04/stovetop-burgers-recipe-2-960x1200.jpg",
    "https://www.thecookierookie.com/wp-content/uploads/2023/04/stovetop-burgers-recipe-2-960x1200.jpg",
    "https://www.thecookierookie.com/wp-content/uploads/2023/04/stovetop-burgers-recipe-2-960x1200.jpg",
    "https://www.thecookierookie.com/wp-content/uploads/2023/04/stovetop-burgers-recipe-2-960x1200.jpg",
    "https://www.thecookierookie.com/wp-content/uploads/2023/04/stovetop-burgers-recipe-2-960x1200.jpg",
    "https://www.thecookierookie.com/wp-content/uploads/2023/04/stovetop-burgers-recipe-2-960x1200.jpg",
    "https://www.thecookierookie.com/wp-content/uploads/2023/04/stovetop-burgers-recipe-2-960x1200.jpg",
    "https://www.thecookierookie.com/wp-content/uploads/2023/04/stovetop-burgers-recipe-2-960x1200.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff171717),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xffA71E27),
        title: Text("24 Express",style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),),
        actions: [
          Icon(Icons.search,color: Colors.white,size: 32,),
          SizedBox(width: 16,),
          Icon(Icons.shopping_cart_outlined,color: Colors.white,size: 32,),
          SizedBox(width: 8,)
        ],
      ),
      drawer: Drawer(

          child: Container(
            color: Color(0xff171717),
            child: ListView(
              children: [
                DrawerHeader(
                  padding: EdgeInsets.only(bottom: 0,top: 16,left: 16,right: 16),
                  decoration: BoxDecoration(
                    color: Color(0xffA71E27),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xff6B1319),
                        radius: 35,
                        child: Icon(Icons.person,color: Colors.white,size: 60,),

                      ),

                      Row(
                        children: [
                          Text("Hassan Slama",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                          Spacer(),
                          CircleAvatar(
                            backgroundColor: Color(0xff6B1319),
                            radius: 20,
                            child: Icon(Icons.edit,color: Colors.white,size: 20,)
                            ,
                          ),
                        ],
                      ),
                      Text("2023",style: TextStyle(
                        color: Color(0xff6B1319),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),)
                    ],
                  ),),
                ListTile(
                  leading: Icon(Icons.home_outlined,color: Color(0xff707070),size: 32,),
                  title: Text("Home",style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
                ListTile(
                  leading: Icon(Icons.category_outlined,color: Color(0xff707070),size: 32,),
                  title: Text("Categories",style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
                ListTile(
                  leading: Icon(Icons.favorite_border,color: Color(0xff707070),size: 32,),
                  title: Text("Like",style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
                ListTile(
                  leading: Icon(Icons.shopping_cart_outlined,color: Color(0xff707070),size: 32,),
                  title: Text("Home",style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
                ListTile(
                  leading: Icon(Icons.language_outlined,color: Color(0xff707070),size: 32,),
                  title: Text("Langouage",style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
                ListTile(
                  leading: Icon(Icons.login_outlined,color: Color(0xff707070),size: 32,),
                  title: Text("Log Out",style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ],
            ),
          ),
        
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
        ),

        child: BottomNavigationBar(
            selectedItemColor: Colors.red,
            currentIndex: 0,
            items: [
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
        physics: BouncingScrollPhysics(),
        children: [
          Padding(padding: EdgeInsets.all(16),
            child: Row(

              children: [
                Icon(Icons.category,color: Colors.white,size: 24,),
                SizedBox(width: 8,),
                Text("Categories",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff8B8B8B),
                  ),
                  child: Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("see all",style: TextStyle(color: Colors.white,fontSize: 15),),
                      Icon(Icons.arrow_forward_ios,color: Colors.white,size: 15,),
                    ],
                  ),
                  ),
                )
              ],
            ),

          ),
          SizedBox(height: 150,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 8),
            scrollDirection: Axis.horizontal,
            itemCount: categoryName.length,
            itemBuilder: (context, index) {

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 58,
                      backgroundImage: NetworkImage("${categoryImage[index]}"),

                    ),
                    SizedBox(height: 10,),
                    Text("${categoryName[index]}",style: TextStyle(color: Color(0xffC4C4C4),fontSize: 15,fontWeight: FontWeight.bold),)
                  ],
                ),
              );
            },

          ),
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
          child: Row(
            children: [
              Icon(Icons.percent,color: Colors.white,size: 32,),
              SizedBox(width: 8,),
              Text("Offers",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
            ],
          ),
          ),
          SizedBox(height: 160,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 8),
              scrollDirection: Axis.horizontal,
              itemCount: offers.length,
              itemBuilder: (context, index) {

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(

                    width: 290,
                    height: 148,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("${offers[index]}"),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                );
              },

            ),
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
            child: Row(
              children: [
                Icon(Icons.percent,color: Colors.white,size: 32,),
                SizedBox(width: 8,),
                Text("Popular",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
              ],
            ),
          ),
            Container(
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                  itemCount: popularProductsImage.length,
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,),
                  itemBuilder: (context,index){
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16,vertical: 20),
                child: Container(

                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("${popularProductsImage[index]}"),
                      fit: BoxFit.cover
                    ),

                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                );
                  }),
            )
          // Wrap(
          //   spacing: 20,
          //   alignment: WrapAlignment.center,
          //   direction: Axis.vertical,
          //   children: [
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.all(16),
          //           child: Container(
          //             width: 98,
          //             height: 107,
          //             decoration: BoxDecoration(
          //               color: Colors.red,
          //               borderRadius: BorderRadius.circular(20),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(16),
          //           child: Container(
          //             width: 98,
          //             height: 107,
          //             decoration: BoxDecoration(
          //               color: Colors.red,
          //               borderRadius: BorderRadius.circular(20),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(16),
          //           child: Container(
          //             width: 98,
          //             height: 107,
          //             decoration: BoxDecoration(
          //               color: Colors.red,
          //               borderRadius: BorderRadius.circular(20),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.all(16),
          //           child: Container(
          //             width: 98,
          //             height: 107,
          //             decoration: BoxDecoration(
          //               color: Colors.red,
          //               borderRadius: BorderRadius.circular(20),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(16),
          //           child: Container(
          //             width: 98,
          //             height: 107,
          //             decoration: BoxDecoration(
          //               color: Colors.red,
          //               borderRadius: BorderRadius.circular(20),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(16),
          //           child: Container(
          //             width: 98,
          //             height: 107,
          //             decoration: BoxDecoration(
          //               color: Colors.red,
          //               borderRadius: BorderRadius.circular(20),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.all(16),
          //           child: Container(
          //             width: 98,
          //             height: 107,
          //             decoration: BoxDecoration(
          //               color: Colors.red,
          //               borderRadius: BorderRadius.circular(20),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(16),
          //           child: Container(
          //             width: 98,
          //             height: 107,
          //             decoration: BoxDecoration(
          //               color: Colors.red,
          //               borderRadius: BorderRadius.circular(20),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(16),
          //           child: Container(
          //             width: 98,
          //             height: 107,
          //             decoration: BoxDecoration(
          //               color: Colors.red,
          //               borderRadius: BorderRadius.circular(20),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.all(16),
          //           child: Container(
          //             width: 98,
          //             height: 107,
          //             decoration: BoxDecoration(
          //               color: Colors.red,
          //               borderRadius: BorderRadius.circular(20),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(16),
          //           child: Container(
          //             width: 98,
          //             height: 107,
          //             decoration: BoxDecoration(
          //               color: Colors.red,
          //               borderRadius: BorderRadius.circular(20),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(16),
          //           child: Container(
          //             width: 98,
          //             height: 107,
          //             decoration: BoxDecoration(
          //               color: Colors.red,
          //               borderRadius: BorderRadius.circular(20),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.all(16),
          //           child: Container(
          //             width: 98,
          //             height: 107,
          //             decoration: BoxDecoration(
          //               color: Colors.red,
          //               borderRadius: BorderRadius.circular(20),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(16),
          //           child: Container(
          //             width: 98,
          //             height: 107,
          //             decoration: BoxDecoration(
          //               color: Colors.red,
          //               borderRadius: BorderRadius.circular(20),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(16),
          //           child: Container(
          //             width: 98,
          //             height: 107,
          //             decoration: BoxDecoration(
          //               color: Colors.red,
          //               borderRadius: BorderRadius.circular(20),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),

        ],
      ),
    );
  }


}