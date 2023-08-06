import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


class FirebaseAuthService{
 static Future<UserCredential> SignIn({required String email,required String password})async{
   final credential  = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
   return credential;
 }

 static Future<UserCredential> SignUp({required String email,required String password})async{
   final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
   return credential;
 }
}