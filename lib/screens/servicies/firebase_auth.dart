import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


class FirebaseAuthService{
 static Future<UserCredential> SignIn({required String email,required String password})async{
   final credential  = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
   return credential;
 }

 static Future<UserCredential> SignUp({required String email,required String password,required String name,required phone})async{
   final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password,);
   await FirebaseFirestore.instance.collection("users").doc(credential.user?.uid).set({
     "id":credential.user?.uid,
     "email":email,
     "name":name,
     "phone":phone,
     "image":""
   });
   return credential;
 }
}