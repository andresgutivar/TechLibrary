import 'package:biblioteca/pages/book/edit-book/edit-book-page-arguments.dart';
import 'package:flutter/material.dart';

class EditBookPageNew extends StatefulWidget {
  const EditBookPageNew({super.key});
  static const routeName = '/editBook';
  @override
  State<EditBookPageNew> createState() => _EditBookPageNewState();
}

class _EditBookPageNewState extends State<EditBookPageNew> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as EditBookPageArguments;
    print(args.isbn);
    return const Placeholder();
  }
}
