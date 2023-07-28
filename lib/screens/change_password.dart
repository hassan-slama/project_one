import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:project_one/screens/sign_in.dart';
class ChangePassword extends StatefulWidget{
  final String email;
  const ChangePassword({required this.email, super.key});
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isLoading = false ;
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                    controller: _passwordController,
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

                  Center(
                    child: Pinput(
                        length: 4,
                        toolbarEnabled: false,
// inputFormatters: [Formatter()],
                        onCompleted: (pin) async {
// call activate endpoint
                          isLoading = true;
                          setState(() {});
// prepare uri
                          final uri = Uri.parse("https://v-mesta.com/api/reset-password");
//initialize request
                          var request = http.Request('POST', uri);
// adding encoded json to the request body
                          final body = json.encode({
                            "code": pin,
                            "email": "hassan74@gmail.com",
                            "password": _passwordController.text,
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
                          log(response.statusCode.toString(), name: "status code");
// check if the status code success
                          if (response.statusCode == 200) {
// receive the response body
                            String responseBody = await response.stream.bytesToString();
// logging response body
                            log(responseBody, name: "response body");
// decode response body to Map
                            final decodedBody = json.decode(responseBody);
                            log(decodedBody.toString(), name: " decoded response body");
                            isLoading = false;
                            setState(() {});
                            if (decodedBody['key'] == "success") {
// Obtain shared preferences.
                              final prefs = await SharedPreferences.getInstance();
                              await prefs.setString(
                                'token',
                                decodedBody['data']['user']['token'],
                              );
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) => SignIn(),
                                ),
                                    (route) => false,
                              );
// handle error stat
                            } else if (decodedBody['key'] == "fail") {
                              showDialog(
                                  context: context,
// barrierDismissible: false,
                                  builder: (ctx) {
                                    return AlertDialog(
                                      title: Text("Error!"),
                                      content: Text(
                                        decodedBody['msg'].toString(),
                                      ),
                                    );
                                  });
                            } else {
                              print("error");
                            }
                          }
                        }),
                  ),
                  SizedBox(height: 40,),
                  isLoading?CircularProgressIndicator():Container(
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

                    child:
                      Row(
                        children: [
                          TextButton(
                              onPressed: null,
                              child: Text(
                                "CHANGE PASSWORD",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              )),
                        ],
                      )

                  ),
                ],
              ),
            )

        ),
      ),
    );
  }
}