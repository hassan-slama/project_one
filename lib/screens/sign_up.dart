import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'otp_screen.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  bool isLoading = false;

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
                  controller: _nameController,
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
                  controller: _emailController,
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
                          const BorderSide(width: 2, color: Colors.blueAccent)),
                    )),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _passwordController,
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
                TextField(
                  controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      hintText: "Confirm Password",
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
                      // color: Color.fromARGB(255, 182, 48, 18),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      // boxShadow: [
                      //   BoxShadow(
                      //     // color: Color.fromARGB(255, 124, 34, 28),
                      //     // offset: Offset(0, 5),
                      //     blurRadius: 15,
                      //   )
                      // ]
                    ),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      isLoading
                          ?
                      CircularProgressIndicator()
                          :
                      InkWell(
                        onTap: ()async{
                          isLoading =true;
                          setState(() {});
                          //call register api
                          // prepare uri
                          final uri = Uri.parse("https://v-mesta.com/api/sign-up");
                          //initialize request
                          var request = http.Request('POST',uri);
                          // adding encoded json to the request body
                          final body = json.encode({
                            "name": _nameController.text,
                            "country_code":966 ,
                            "phone":_phoneController.text ,
                            "email": _emailController.text,
                            "password": _passwordController.text,
                            "password_confirmation": _confirmPasswordController.text,
                            "d_o_b": '13-10-2001',
                          });
                          print("request body is ::: $body");
                          request.body = body;
                          // adding headers to accept json format
                          request.headers.addAll({
                            "Content-Type": "application/json",
                          });
                          // send the request to the server
                          var response = await request.send();
                          // logging the status code
                          log(response.statusCode.toString(),name: "status code");
                          // check if the status code success
                          if (response.statusCode == 200) {
                            // receive the response body
                            String responseBody = await response.stream.bytesToString();
                            // logging response body
                            log(responseBody,name: "response body");
                            // decode response body to Map
                            final decodedBody = json.decode(responseBody);
                            log(decodedBody.toString(),name: " decoded response body");
                            isLoading =false;
                            setState(() {});
                            if(decodedBody['key']=="needActive"){
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (builder)=>OtpScreen(
                                        email:_emailController.text,
                                      )
                                  ));
                              // handle error stat
                            } else if(decodedBody['key']=="fail"){
                              showDialog(
                                  context: context,
                                  // barrierDismissible: false,
                                  builder: (ctx){
                                    return AlertDialog(
                                      title: Text("Error!"),
                                      content: Text(
                                        decodedBody['msg'].toString(),
                                      ),
                                    );
                                  }
                              );

                            }else{
                              print("error");
                            }
                          }
                          // navigate to otp screen
                        },
                        child: Container(
                          height: 44,
                          width: 101,
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
                            child: Text('SIGN UP',
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white ,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )

      ),
    );
  }
}
