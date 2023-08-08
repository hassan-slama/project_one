import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_one/screens/sign_in.dart';

import 'edit_screen.dart';
import 'models/user_model.dart';

class DrawerScreen extends StatefulWidget {
  final UserModel userModel;
  const DrawerScreen({required this.userModel,super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final picker = ImagePicker();
  void pickImage()async{
    //for camera
    // final xFile = await picker.pickImage(source: ImageSource.camera);
    //for gallery
    final xFile = await picker.pickImage(source: ImageSource.gallery);
    if(xFile!=null){
      final uploadTask =  FirebaseStorage.instance.ref("userImages").putFile(
        File(xFile.path),
      );
      uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async{
        switch (taskSnapshot.state) {
          case TaskState.running:
            final progress =
                100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
            print("Upload is $progress% complete.");
            break;
          case TaskState.paused:
            print("Upload is paused.");
            break;
          case TaskState.canceled:
            print("Upload was canceled");
            break;
          case TaskState.error:
            print("Upload Error");
            break;
          case TaskState.success:
            print("success ${await taskSnapshot.ref.getDownloadURL()}");
            //update fire store  image field
            FirebaseFirestore.instance.collection("users")
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .update({
              "image":await taskSnapshot.ref.getDownloadURL(),
            }).then((val)async{
              widget.userModel.image=await taskSnapshot.ref.getDownloadURL();
              setState(() {});
            });
            break;
        }
      });
    }else{
      print("no selected File");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: Container(
        color: const Color(0xff171717),
        child: ListView(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.only(bottom: 0,top: 16,left: 16,right: 16),
              decoration: const BoxDecoration(
                color: Color(0xffA71E27),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: (){
                      pickImage();
                    },
                    child:  CircleAvatar(
                      radius: 35,
                          backgroundImage: NetworkImage(widget.userModel.image??""),
                    ),
                  ),

                  Row(
                    children:  [
                      Text(widget.userModel.name??"",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                      Spacer(),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditScreen(),));
                        },
                        child: CircleAvatar(
                          backgroundColor: Color(0xff6B1319),
                          radius: 20,
                          child: Icon(Icons.edit,color: Colors.white,size: 20,)
                          ,
                        ),
                      ),
                    ],
                  ),
                   Text(widget.userModel.phone??"",style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),)
                ],
              ),),
            const ListTile(
              leading: Icon(Icons.home_outlined,color: Color(0xff707070),size: 32,),
              title: Text("Home",style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),),
            ),
            const ListTile(
              leading: Icon(Icons.category_outlined,color: Color(0xff707070),size: 32,),
              title: Text("Categories",style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),),
            ),
            const ListTile(
              leading: Icon(Icons.favorite_border,color: Color(0xff707070),size: 32,),
              title: Text("Like",style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),),
            ),
            const ListTile(
              leading: Icon(Icons.shopping_cart_outlined,color: Color(0xff707070),size: 32,),
              title: Text("Home",style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),),
            ),
            const ListTile(
              leading: Icon(Icons.language_outlined,color: Color(0xff707070),size: 32,),
              title: Text("Language",style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),),
            ),
            ListTile(
              onTap: ()async{
                await FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn(),),
                          (route) => false);
                });
              },

              // onTap: () async{
              //   final uri = Uri.parse("https://v-mesta.com/api/sign-out");
              //
              //   var request = http.Request('DELETE', uri);
              //   final pref = await SharedPreferences.getInstance();
              //   final cachedToken = pref.getString('token');
              //
              //   request.headers.addAll({
              //     "Content-Type": "application/json",
              //     "Authorization":"Bearer $cachedToken"
              //   });
              //
              //   final response = await request.send();
              //   if(response.statusCode == 200){
              //     final String responseBody = await response.stream.bytesToString();
              //     final decodedResponseBody = json.decode(responseBody);
              //     if(decodedResponseBody['key']=="success"){
              //       pref.clear();
              //       Navigator.pushAndRemoveUntil(
              //         context,
              //         MaterialPageRoute(
              //           builder: (builder) => const SignIn(),
              //         ),
              //             (route) => false,
              //       );
              //     }
              //   }
              //
              // },
              leading: const Icon(Icons.login_outlined,color: Color(0xff707070),size: 32,),
              title: const Text("Log Out",style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),),
            ),
          ],
        ),
      ),

    );
  }
}
