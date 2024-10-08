import 'package:cloud_firestore/cloud_firestore.dart';

class BookModel {
  static const String tableName = "books";

  final String? author;
  final String? editingPlace;
  final String? edition;
  final String? editorial;
  final Timestamp? entryDate;
  final String? isbn;
  final String? lenderId;
  final String? location;
  final String? notes;
  final String? pagination;
  final String? primaryDescriptor;
  final String? secondaryDescriptor;
  final String? status;
  final String? title;
  final String? userId;
  final String? yearEdition;

  BookModel({
    this.author,
    this.editingPlace,
    this.edition,
    this.editorial,
    this.entryDate,
    this.isbn,
    this.lenderId,
    this.location,
    this.notes,
    this.pagination,
    this.primaryDescriptor,
    this.secondaryDescriptor,
    this.status,
    this.title,
    this.userId,
    this.yearEdition,
  });

  factory BookModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return BookModel(
      author: data?['author'],
      editingPlace: data?['editingPlace'],
      edition: data?['edition'],
      editorial: data?['editorial'],
      entryDate: data?['entryDate'],
      isbn: data?['isbn'],
      lenderId: data?['lenderId'],
      location: data?['location'],
      notes: data?['notes'],
      pagination: data?['pagination'],
      primaryDescriptor: data?['primaryDescriptor'],
      secondaryDescriptor: data?['secondaryDescriptor'],
      status: data?['status'],
      title: data?['title'],
      userId: data?['userId'],
      yearEdition: data?['yearEdition'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (author != null) "author": author,
      if (editingPlace != null) "editingPlace": editingPlace,
      if (edition != null) "edition": edition,
      if (editorial != null) "editorial": editorial,
      if (entryDate != null) "entryDate": entryDate,
      if (isbn != null) "isbn": isbn,
      if (lenderId != null) "lenderId": lenderId else "lenderId": "",
      if (location != null) "location": location,
      if (notes != null) "notes": notes,
      if (pagination != null) "pagination": pagination,
      if (primaryDescriptor != null) "primaryDescriptor": primaryDescriptor,
      if (secondaryDescriptor != null)
        "secondaryDescriptor": secondaryDescriptor,
      if (status != null) "status": status else "status": "disponible",
      if (title != null) "title": title,
      if (userId != null) "userId": userId else "userId": "",
      if (yearEdition != null) "yearEdition": yearEdition,
    };
  }
}
