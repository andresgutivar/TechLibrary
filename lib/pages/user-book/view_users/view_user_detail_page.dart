import 'package:biblioteca/models/user_book_model.dart';

import 'package:biblioteca/pages/user-book/view_users/view_user_detail_page_arguments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewUserDetailPage extends StatelessWidget {
  const ViewUserDetailPage({super.key});
  static const routeName = '/viewUserDetail';

  static const Color customColor = Color.fromARGB(210, 81, 232, 55);
  static const Color backgroundColorOptions = Color(0xfff8FFF7C);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as ViewUserDetailPageArguments;

    final Stream<DocumentSnapshot> userStream = FirebaseFirestore.instance
        .collection(UserBookModel.tableName)
        .withConverter(
          fromFirestore: UserBookModel.fromFirestore,
          toFirestore: (UserBookModel user, options) => user.toFirestore(),
        )
        .doc(args.dni)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de usuario'),
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
                      return Text('No hay datos de usuario para mostrar');
                    } else {
                      UserBookModel user =
                          snapshot.data!.data() as UserBookModel;

                      return Column(children: [
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
                        SizedBox(height: 16),
                        MyText(
                            text: 'Mail',
                            value: user.email!,
                            customColor: customColor),
                        SizedBox(height: 16),
                        MyText(
                            text: 'Rol',
                            value: user.rol!,
                            customColor: customColor),
                        SizedBox(height: 16),
                        if (user.rol == "estudiante") ...[
                          MyText(
                              text: 'Curso',
                              value: user.year!,
                              customColor: customColor),
                          SizedBox(height: 16),
                          MyText(
                              text: 'División',
                              value: user.div!,
                              customColor: customColor),
                          SizedBox(height: 16),
                          if (int.parse(user.year!) >= 3)
                            MyText(
                                text: 'Especialidad',
                                value: user.career!,
                                customColor: customColor),
                        ]
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
          //height: 80,
          decoration: BoxDecoration(
            color: customColor,
            border: Border.all(color: Colors.green, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Text(
            text + ' : ' + value,
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
