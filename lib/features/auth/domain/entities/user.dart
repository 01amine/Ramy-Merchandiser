class UserEntity {
  final String nom;
  final String prenom;
  final String email;
  final String date_naissance;
  final String numero_carte_identite;

  UserEntity({
    required this.nom,
    required this.prenom,
    required this.email,
    required this.date_naissance,
    required this.numero_carte_identite,
  });
}
