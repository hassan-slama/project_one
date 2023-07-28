import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({required this.email, super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 40,
            ),
          )),
      body: ListView(
        padding: EdgeInsets.all(32),
        children: [
          SizedBox(
            height: 64,
          ),
          Center(
            child: Text(
              'please enter otp sent to your mail',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 64,
          ),
          Pinput(
              length: 4,
              toolbarEnabled: false,
// inputFormatters: [Formatter()],
              onCompleted: (pin) async {
// call activate endpoint
                isLoading = true;
                setState(() {});
// prepare uri
                final uri = Uri.parse("https://v-mesta.com/api/activate");
//initialize request
                var request = http.Request('PATCH', uri);
// adding encoded json to the request body
                final body = json.encode({
                  "code": pin,
                  "email": widget.email,
                  "device_id": "111",
                  "device_type": Platform.isIOS ? "ios" : "android",
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
                        builder: (builder) => HomeScreen(),
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
//   // navigate to otp screen
              }),
          SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isLoading ? CircularProgressIndicator() : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
