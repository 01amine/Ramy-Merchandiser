class SignupReqParams {
  final String nom;
  final String prenom;
  final String email;
  final String password;
  final String date_naissance;
  final String sexe;
  final String numero_carte_identite;
  final bool permission_parentale;

  SignupReqParams(
      {required this.nom,
      required this.prenom,
      required this.email,
      required this.password,
      required this.date_naissance,
      required this.sexe,
      required this.numero_carte_identite,
      required this.permission_parentale});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'password': password,
      'date_naissance': date_naissance,
      'sexe': sexe,
      'numero_carte_identite': numero_carte_identite,
      'permission_parentale': permission_parentale
    };
  }
}
