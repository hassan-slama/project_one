import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_one/screens/home_screen.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white,size: 25),
            backgroundColor: const Color(0xffA71E27),
            title: Text("Edit Information",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white)),
          ),

      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          SizedBox(height: 50,),
          TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Name",
                labelText: "Name",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 25,
                ),
                labelStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 25,
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 2, color: Colors.grey),
                    borderRadius: BorderRadius.circular(50)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide:
                    const BorderSide(width: 2, color: Color(0xffA71E27))),
              )),
          const SizedBox(
            height: 20,
          ),

          TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                hintText: "Phone",
                labelText: "Phone",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 25,
                ),
                labelStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 25,
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 2, color: Colors.grey),
                    borderRadius: BorderRadius.circular(50)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide:
                    const BorderSide(width: 2, color: Color(0xffA71E27))),
              )),
                SizedBox(height: 25,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isLoading
                  ?
              CircularProgressIndicator()
                  :
              InkWell(
                onTap: (){
                  setState(() {
                    isLoading = true;
                  });
                  FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.uid).
                  update({
                    "phone":_phoneController.text,
                    "name":_nameController.text
                  }).then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen(),), (route) => false)).
                  then((value) =>
                      setState(() {
                    isLoading = false;
                  }));
                },




                child: Container(
                  height: 50,
                  width: 120,
                  decoration: BoxDecoration(
                    color:Color(0xffA71E27),
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffA71E27),
                        blurRadius: 5.0, // soften the shadow
                        spreadRadius: 1.0, //extend the shadow
                      )
                    ],
                  ),
                  child: Center(
                    child: Text('Edit',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white ,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
