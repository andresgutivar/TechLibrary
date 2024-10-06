import 'package:cloud_firestore/cloud_firestore.dart';

class UserBookModel {
  static const String tableName = "usersBook";

  final String? name;
  final String? lastName;
  final String? dni;
  final String? phone;

  UserBookModel({this.name, this.lastName, this.dni, this.phone});

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
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (lastName != null) "lastName": lastName,
      if (dni != null) "dni": dni,
      if (phone != null) "phone": phone,
    };
  }
}
