import 'package:flutter/material.dart';
class ChangePassword extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
          margin: const EdgeInsets.only(left: 20, top: 50, right: 20),
          child:
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back,color: Colors.black,size: 40,),
                ),
                const SizedBox(
                  height: 30,
                ),
                  Text("Change \nPassword",style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),),
          const SizedBox(
            height: 30,
          ),
                TextField(
                    decoration: InputDecoration(
                      hintText: "New password",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(30)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                          const BorderSide(width: 2, color: Colors.blueAccent)),
                    )),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                    decoration: InputDecoration(
                      hintText: "Confirm password",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(30)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                          const BorderSide(width: 2, color: Colors.blueAccent)),
                    )),
                SizedBox(height: 30,),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 182, 48, 18),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 124, 34, 28),
                          offset: Offset(0, 5),
                          blurRadius: 15,
                        )
                      ]),
                  child: const TextButton(
                      onPressed: null,
                      child: Text(
                        "CHANGE PASSWORD",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                ),
              ],
            ),
          )

      ),
    );
  }
}