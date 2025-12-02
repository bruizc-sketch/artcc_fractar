import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> login(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      
      if (result.user != null) {
        await _firestore.collection('users').doc(result.user!.uid).update({
          'ultimo_acceso': DateTime.now().toIso8601String(),
        }).catchError((e) {}); 
      }
      
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<User?> registro(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      User? user = result.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': email,
          'fecha_registro': DateTime.now().toIso8601String(),
          'rol': 'usuario', 
          'activo': true,
        });
      }

      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  

  Future<void> signOut() async {
    await _auth.signOut();
  }
  
  User? get currentUser => _auth.currentUser;
}