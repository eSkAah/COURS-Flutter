import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttermanager/models/userModel.dart';


class UserService {
  //Method que l'on peut utiliser comme une Promise et utiliser mode ASYNC de NodeJS
   final FirebaseAuth _auth = FirebaseAuth.instance;

   Stream<UserModel> get user {
     return _auth.authStateChanges().asyncMap( (user) => UserModel(uid: user!.uid, email: user.email!));
   }

  Future<UserModel> auth(userModel) async { // Voir doc de la lib firebase_auth

    //Dans le UserCredential on récupère un Objet User avec le UID, Delete et d'autres methods
    UserCredential userCredential;

    //Utilisation d'un try&catch si l'user n'est pas enregistrer on l'inscris, sinon on le log.
    //Evite la vérification de doublon en base de données.
    try {
      print(userModel.toJson());
      userCredential = await _auth.signInWithEmailAndPassword(
          email: userModel.email,
          password: userModel.password);
    }catch(e){
      userCredential = await _auth.createUserWithEmailAndPassword(email: userModel.email, password: userModel.password);
    }

    userModel.setUid = userCredential.user?.uid;

    return userModel;


  }
}