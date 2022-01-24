class UserModel {
  final String email;
  final String ?password;
  String uid;

  UserModel({
     required this.uid,
     required this.email,
     this.password
  });

  set setUid(value) => uid = value;

  //Map est une sorte de tableau associatif, d'un coté la clé et de l'autre une valeur dynamique associée
  Map<String, dynamic> toJson() => {
    'uid': uid,
    'email':email,
    'password': password
  };

}