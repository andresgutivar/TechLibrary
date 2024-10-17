import 'package:biblioteca/models/book_model.dart';
import 'package:biblioteca/models/user_model.dart';
import 'package:biblioteca/pages/loan/view-loan/infoLoanPageArguments.dart';
import 'package:biblioteca/pages/user-book/view_users/view_user_detail_page.dart';
import 'package:biblioteca/pages/user-book/view_users/view_user_detail_page_arguments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modal_dialog/flutter_modal_dialog.dart';

class infoLoanPageNew extends StatefulWidget {
  const infoLoanPageNew({super.key});
  static const routeName = '/loanInfo';

  @override
  State<infoLoanPageNew> createState() => _infoLoanPageNewState();
}

class _infoLoanPageNewState extends State<infoLoanPageNew> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _dni = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    const Color customColor = Color(0xfff8FFF7C);
    final args =
        ModalRoute.of(context)!.settings.arguments as infoLoanPageArguments;
    print(args.lenderId);
    print(args.userId);

    FirebaseFirestore.instance
        .collection(UserModel.tableName)
        .doc(args.lenderId)
        .withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel user, options) => user.toFirestore(),
        )
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        UserModel user = documentSnapshot.data()! as UserModel;
        _name.text = user.name!;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Informacion sobre el prestamo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Informacion sobre la prestadora',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 800,
                  child: Container(
                    height: 2,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                MyText(
                    text: 'Nombre',
                    value: _name.text,
                    customColor: customColor),
                SizedBox(height: 16),
                MyText(
                    text: 'Apellido',
                    value: "user.lastName!",
                    customColor: customColor),
                SizedBox(height: 16),
                MyText(
                    text: 'DNI', value: "user.dni!", customColor: customColor),
                SizedBox(height: 16),
                MyText(
                    text: 'Teléfono',
                    value: "user.phone!",
                    customColor: customColor),
                // Otra sección
                Text(
                  'Informacion sobre lector del libro',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 800,
                  child: Container(
                    height: 2,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 400,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: BorderSide(
                        color: customColor, // Color del borde
                        width: 3, // Ancho del borde
                      ),
                    ),
                    onPressed: () => Navigator.pushNamed(
                      context,
                      ViewUserDetailPage.routeName,
                      arguments: ViewUserDetailPageArguments(args.userId!),
                    ),
                    child: const Text(
                      'Informacion sobre usuario',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 64),
                Text(
                  'Marcar libro como devuelto',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 800,
                  child: Container(
                    height: 2,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 400,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: BorderSide(
                        color: customColor, // Color del borde
                        width: 3, // Ancho del borde
                      ),
                    ),
                    onPressed: () {
                      ModalDialog.confirmation(
                        context: context,
                        title: const ModalTitle(text: "Please confirm"),
                        message: "It's a simple Yes/No question",
                        confirmButton: const ModalButton(text: "true"),
                      );
                    },
                    child: const Text(
                      'Devolver',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyText extends StatelessWidget {
  final String text;
  final String value;
  final Color customColor;
  const MyText(
      {super.key,
      required this.text,
      required this.value,
      required this.customColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          width: 800,
          decoration: BoxDecoration(
            color: customColor,
            border: Border.all(color: Colors.green, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '$text : $value',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ));
  }
}
