import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'change_password.dart';

class ChangePasswordConfirmstion extends StatefulWidget {
  const ChangePasswordConfirmstion({Key? key}) : super(key: key);

  @override
  State<ChangePasswordConfirmstion> createState() => _ChangePasswordConfirmstionState();
}

class _ChangePasswordConfirmstionState extends State<ChangePasswordConfirmstion> {
  final _emailController = TextEditingController();
  bool isLoading = false ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body:
     ListView(
       children: [
       const SizedBox(
       height: 50,
     ),
      Center(child: Text("enter your email...",style: TextStyle(
        fontSize: 30,
      ),)),
      SizedBox(
        height: 50,
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
         SizedBox(height: 20,),
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
                   final uri = Uri.parse("https://v-mesta.com/api/forget-password-send-code");
                   //initialize request
                   var request = http.Request('POST',uri);
                   // adding encoded json to the request body
                   final body = json.encode({
                     "email": _emailController.text,
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
                     if(decodedBody['key']=="success"){
                       Navigator.push(context,
                           MaterialPageRoute(
                               builder: (builder)=>ChangePassword(
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
                     child: Text('SEND',
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
     )
    );
  }
}
