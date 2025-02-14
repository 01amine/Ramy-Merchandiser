import '../../domain/entities/user.dart';

class UserModel {
  final String nom;
  final String prenom;
  final String email;
  final String date_naissance;
  final String sexe;
  final String numero_carte_identite;
  final bool permission_parentale;

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      nom: map['nom'] as String,
      prenom: map['prenom'] as String,
      email: map['email'] as String,
      date_naissance: map['date_naissance'] as String,
      sexe: map['sexe'] as String,
      numero_carte_identite: map['numero_carte_identite'] as String,
      permission_parentale: map['permission_parentale'] as bool,
    );
  }

  UserModel(
      {required this.nom,
      required this.prenom,
      required this.email,
      required this.date_naissance,
      required this.sexe,
      required this.numero_carte_identite,
      required this.permission_parentale});
}

extension UserXModel on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      nom: nom,
      prenom: prenom,
      email: email,
      date_naissance: date_naissance,
      numero_carte_identite: numero_carte_identite,
    );
  }
}
