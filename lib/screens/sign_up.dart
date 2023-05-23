import 'package:flutter/material.dart';




class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      // ),
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
                Container(
                    width: 100,
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                const SizedBox(
                  height: 40,
                ),
                TextField(
                    decoration: InputDecoration(
                      hintText: "Name",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 25,
                      ),
                      labelText: "Name",
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
                          const BorderSide(width: 2, color: Colors.blueAccent)),
                    )),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                    decoration: InputDecoration(
                      hintText: "Email",
                      labelText: "Email",
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
                          const BorderSide(width: 2, color: Colors.blueAccent)),
                    )),
                const SizedBox(
                  height: 20,
                ),
                TextField(
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
                          const BorderSide(width: 2, color: Colors.blueAccent)),
                    )),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Password",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 25,
                      ),
                      suffixIcon: const Icon(Icons.visibility_off),
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 25,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(50)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide:
                          const BorderSide(width: 2, color: Colors.blueAccent)),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
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
                        "SIGN UP",
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
