import 'package:biblioteca/models/book_model.dart';
import 'package:biblioteca/models/user_model.dart';
import 'package:biblioteca/pages/loan/view-loan/infoLoanPageArguments.dart';
import 'package:biblioteca/pages/user-book/view_users/view_user_detail_page.dart';
import 'package:biblioteca/pages/user-book/view_users/view_user_detail_page_arguments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class infoLoanPageNew extends StatelessWidget {
  const infoLoanPageNew({super.key});
  static const routeName = '/loanInfo';

  @override
  Widget build(BuildContext context) {
    const Color customColor = Color(0xfff8FFF7C);
    final args =
        ModalRoute.of(context)!.settings.arguments as infoLoanPageArguments;
    print(args.lenderId);
    print(args.userId);

    final Stream<DocumentSnapshot> userStream = FirebaseFirestore.instance
        .collection(UserModel.tableName)
        .withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel user, options) => user.toFirestore(),
        )
        .doc(args.lenderId)
        .snapshots();

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
                StreamBuilder<DocumentSnapshot>(
                  stream: userStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData) {
                      return Text(
                          'Error al cargar los datos. Es posible que el usuario se halla eliminado. Contactese con los encargados de la aplicacion.');
                    } else {
                      UserModel user = snapshot.data!.data() as UserModel;

                      return Column(children: [
                        Text(
                          'Informacion sobre la prestadora',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
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
                            value: user.name!,
                            customColor: customColor),
                        SizedBox(height: 16),
                        MyText(
                            text: 'Apellido',
                            value: user.lastName!,
                            customColor: customColor),
                        SizedBox(height: 16),
                        MyText(
                            text: 'DNI',
                            value: user.dni!,
                            customColor: customColor),
                        SizedBox(height: 16),
                        MyText(
                            text: 'Teléfono',
                            value: user.phone!,
                            customColor: customColor),
                        // Otra sección
                        Text(
                          'Informacion sobre lector del libro',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
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
                              arguments:
                                  ViewUserDetailPageArguments(args.userId!),
                            ),
                            child: const Text(
                              'Informacion sobre usuario',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(height: 64),
                        Text(
                          'Marcar libro como devuelto',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
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
                              //cambia el estado del libro a devuelto
                            },
                            child: const Text(
                              'Devolver',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ]);
                    }
                  },
                ),
                SizedBox(height: 16),
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
