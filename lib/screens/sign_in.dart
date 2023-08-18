
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project_one/business_logic_layer/auth_cubit/sign_in_cubit.dart';
import 'package:project_one/screens/change_password_confirmation.dart';
// import 'package:project_one/screens/servicies/firebase_auth.dart';
import 'package:project_one/screens/sign_up.dart';

import 'home_screen.dart';
// import 'change_password.dart';
// import 'home_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';




class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();

}
class _SignInState extends State<SignIn>{
  bool isObscured = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
@override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      // ),
      body:
      BlocListener<SignInCubit, SignInState>(
  listener: (context, state) {
    if(state is SignInSuccessState){
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(
              builder: (builder) => const HomeScreen()
          ),
      (route) => false,
      );
    }
  },
  child: SingleChildScrollView(child: Container(
        margin: const EdgeInsets.only(left: 20, top: 50, right: 20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 100),
              child: const Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            BlocBuilder<SignInCubit,SignInState>(
                builder:  (context, state) {
                  return state is SignInErrorState
                  ?
                 Text(state.errmsg,style: const TextStyle(fontSize: 20,color: Colors.red),)
                      :
                  const SizedBox();

                },
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Enter your Email",
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 25,
                  ),
                  enabled: true,
                  labelText: "Email,User",
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 25,
                  ),
                  floatingLabelStyle: const TextStyle(color: Colors.red),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.circular(50)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(width: 2, color: Colors.red)),
                )),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _passwordController,
              obscureText: isObscured,
              decoration: InputDecoration(
                suffixIcon:  IconButton(
                  icon: isObscured?const Icon(Icons.visibility_off):const Icon(Icons.visibility),
                  onPressed: () {
                    setState(() {
                      isObscured =!isObscured;
                    });
                  },
                ),
                hintText: "Enter your password",
                labelText: "password",
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 25,
                ),
                labelStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 25,
                ),
                floatingLabelStyle: const TextStyle(color: Colors.red),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 2, color: Colors.grey),
                    borderRadius: BorderRadius.circular(50)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(width: 2, color: Colors.red)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                alignment: Alignment.topRight,
                child: TextButton(
                    onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const ChangePasswordConfirmstion();
                    },),);
                    },
                    child:const Text(
                  "Forget Password! ",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                )), ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<SignInCubit,SignInState>(
                builder: (context, state) {
                  print('current state is${state}');
                 return state is SignInLoadingState
                      ?
                  const CircularProgressIndicator()
                      :
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.center,
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

                    InkWell(
                        onTap: (){
                     BlocProvider.of<SignInCubit>(context).signIn(
                         _emailController.text,
                         _passwordController.text,
                         context);
                        },
                        // onTap: ()async{
                        //   isLoading =true;
                        //   setState(() {});
                        //   //call register api
                        //   // prepare uri
                        //   final uri = Uri.parse("https://v-mesta.com/api/sign-in");
                        //   //initialize request
                        //   var request = http.Request('POST',uri);
                        //   // adding encoded json to the request body
                        //   final body = json.encode({
                        //     "email": _emailController.text,
                        //     "password": _passwordController.text,
                        //     "device_id": "111",
                        //     "device_type": Platform.isIOS ? "ios" : "android",
                        //   });
                        //   print("request body is ::: $body");
                        //   request.body = body;
                        //   // adding headers to accept json format
                        //   request.headers.addAll({
                        //     "Content-Type": "application/json",
                        //   });
                        //   // send the request to the server
                        //   var response = await request.send();
                        //   // logging the status code
                        //   log(response.statusCode.toString(),name: "status code");
                        //   // check if the status code success
                        //   if (response.statusCode == 200) {
                        //     // receive the response body
                        //     String responseBody = await response.stream.bytesToString();
                        //     // logging response body
                        //     log(responseBody,name: "response body");
                        //     // decode response body to Map
                        //     final decodedBody = json.decode(responseBody);
                        //     log(decodedBody.toString(),name: " decoded response body");
                        //     isLoading =false;
                        //     setState(() {});
                        //     if(decodedBody['key']=="success"){
                        //       Navigator.pushAndRemoveUntil(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (builder) => HomeScreen(),
                        //         ),
                        //             (route) => false,
                        //       );
                        //       // handle error stat
                        //     } else if(decodedBody['key']=="fail"){
                        //       showDialog(
                        //           context: context,
                        //           // barrierDismissible: false,
                        //           builder: (ctx){
                        //             return AlertDialog(
                        //               title: Text("Error!"),
                        //               content: Text(
                        //                 decodedBody['msg'].toString(),
                        //               ),
                        //             );
                        //           }
                        //       );
                        //
                        //     }else{
                        //       print("error");
                        //     }
                        //   }
                        //   // navigate to otp screen
                        // },
                        child: const Text(
                          "SIGN IN",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  );
                },
            ),

            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don\'t have an account?  ",
                  style: TextStyle(fontSize: 15),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(builder:(context){
                          return const SignUp();
                        },),
                      );
                    },
                    child:  const Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Color.fromARGB(255, 183, 49, 40), fontSize: 15),
                    )

                )
              ],
            )
          ],
        ),
      ),),
),

    );
  }
}
