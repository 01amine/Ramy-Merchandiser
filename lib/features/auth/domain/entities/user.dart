class UserEntity {
  final String nom;
  final String prenom;
  final String email;
  final String date_naissance;
  final String sexe;
  final String numero_carte_identite;
  final bool permission_parentale;

  UserEntity(
      {required this.nom,
      required this.prenom,
      required this.email,
      required this.date_naissance,
      required this.sexe,
      required this.numero_carte_identite,
      required this.permission_parentale});
}
