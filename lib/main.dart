import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one/business_logic_layer/auth_cubit/auth_cubit.dart';
// import 'package:project_one/screens/change_password.dart';
import 'package:project_one/screens/home_screen.dart';
import 'package:project_one/screens/sign_in.dart';
// import 'package:project_one/screens/sign_up.dart';
// import 'package:shared_preferences/shared_preferences.dart';
bool isLoggedIn = false;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // final pref = await SharedPreferences.getInstance();
  // var token =  pref.getString('token');
  // print("token is $token");
  // isLoggedIn = token==null?false:true;

  runApp( MultiBlocProvider(
    providers: [
      BlocProvider<AuthCubit>(
        create: (BuildContext context) => AuthCubit(),
      ),

    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.grey,
      ),
      home: FirebaseAuth.instance.currentUser!=null
        ?
        const HomeScreen()
        :
    const SignIn(),
    );
  }
}

