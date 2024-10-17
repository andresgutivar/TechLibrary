import 'package:cloud_firestore/cloud_firestore.dart';

class infoLoanPageArguments {
  final String lenderId;
  final String userId;
  final String isbn;
  final Timestamp loanDate;
  final Timestamp returnDate;

  infoLoanPageArguments(
      this.lenderId, this.userId, this.isbn, this.loanDate, this.returnDate);
}
