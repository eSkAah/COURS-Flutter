import 'package:cloud_firestore/cloud_firestore.dart';

class CommonService {

  /*Initialiser Firestore*/

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String> get terms async {
    String content = '';

    /*Récupérer une collection*/

   DocumentReference documentReference = _firebaseFirestore.collection('commons').doc('terms');

   /*Récupration des informations du documentReference et retourner a l'interface */

   content = (await documentReference.get()).get('content');

    return content.replaceAll('\\n', "\n");
  }



}


