import 'package:flutter/material.dart';
import 'package:project_one/screens/sign_up.dart';
import 'change_password.dart';
import 'home_screen.dart';





class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      // ),
      body:
      SingleChildScrollView(child: Container(
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
            TextField(
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
              obscureText: true,
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.visibility_off,
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
                      return ChangePassword();
                    },),);
                    },
                    child:Text(
                  "Forget Password! ",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                )), ),
            const SizedBox(
              height: 20,
            ),
            Container(
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
              child:  TextButton(
                  onPressed: (){
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context)=> HomeScreen())
                    , (route) => false);
                  },
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
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
                          return SignUp();
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

    );
  }
}
