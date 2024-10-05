import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? uid;
  final String? email;
  final String? name;
  final String? lastName;
  final String? dni;
  final String? phone;

  UserModel({
    this.uid,
    this.email,
    this.name,
    this.lastName,
    this.dni,
    this.phone,
  });

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
      uid: data?['uid'],
      email: data?['email'],
      name: data?['name'],
      lastName: data?['lastName'],
      dni: data?['dni'],
      phone: data?['phone'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) "uid": uid,
      if (email != null) "email": email,
      if (name != null) "name": name,
      if (lastName != null) "lastName": lastName,
      if (dni != null) "dni": dni,
      if (phone != null) "phone": phone,
    };
  }
}
