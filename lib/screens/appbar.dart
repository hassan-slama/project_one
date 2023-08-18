import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:project_one/screens/user_cart_screen.dart';
class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  const CustomAppBarWidget({this.title,super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: const Color(0xffA71E27),
      title:title==null?null: Text(title??"",
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),),
      actions: [
        IconButton(icon: const Icon(Icons.search), onPressed: (){
          // var context;
          // showSearch(context: context, delegate: Search());
        }),
        const SizedBox(width: 16,),
        badges.Badge(
          badgeContent: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance.collection('users')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .collection('cart').snapshots(),
              builder: (context, snapshot) {
                switch(snapshot.connectionState){
                  case ConnectionState.none:
                    break;
                  case ConnectionState.waiting:
                    break;
                  case ConnectionState.active:
                    return Text('${snapshot.data?.docs.length??0}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    );
                  case ConnectionState.done:
                    break;
                }
                return SizedBox();
              }
          ),
          position: badges.BadgePosition.custom(
              top: 0,
              end: 0
          ),
          child:Center(
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserCart(),));
              },
              child: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,size: 32,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8,)
      ],
    );
  }

  @override
  Size get preferredSize => Size(360, 56);
}