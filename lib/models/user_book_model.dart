import 'package:cloud_firestore/cloud_firestore.dart';

class UserBookModel {
  static const String tableName = "usersBook";

  final String? name;
  final String? lastName;
  final String? dni;
  final String? phone;
  final String? email;
  final String? year;
  final String? div;
  final String? career;
  final String? rol;

  UserBookModel(
      {this.name,
      this.lastName,
      this.dni,
      this.phone,
      this.email,
      this.year,
      this.div,
      this.career,
      this.rol});

  factory UserBookModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserBookModel(
        name: data?['name'],
        lastName: data?['lastName'],
        dni: data?['dni'],
        phone: data?['phone'],
        email: data?['email'],
        year: data?['year'],
        div: data?['div'],
        career: data?['career'],
        rol: data?['rol']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (lastName != null) "lastName": lastName,
      if (dni != null) "dni": dni,
      if (rol != null) "rol": rol,
      if (email != null) "email": email,
      if (phone != null) "phone": phone else "phone": "",
      if (year != null) "year": year else "year": "",
      if (div != null) "div": div else "div": "",
      if (career != null) "career": career else "career": "",
    };
  }
}
