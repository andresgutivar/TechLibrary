class UserBook {
  final String name;
  final String lastName;
  final String dni;
  final String phone;

  factory UserBook.fromMap(Map<String, dynamic> map) {
    return UserBook(
      name: map['name'] as String,
      lastName: map['lastName'] as String,
      dni: map['dni'] as String,
      phone: map['phone'] as String,
    );
  }

  // Constructor regular
  UserBook(
      {required this.name,
      required this.lastName,
      required this.dni,
      required this.phone});
}
