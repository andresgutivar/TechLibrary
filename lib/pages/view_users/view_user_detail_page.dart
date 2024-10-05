import 'package:biblioteca/pages/view_users/view_user_detail_page_arguments.dart';
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
    Stream<Map<String, dynamic>?> streamUsers() {
      return FirebaseFirestore.instance
          .collection('usersBook')
          .doc(args.dni)
          .snapshots()
          .map((snapshot) {
        return snapshot.data();
      });
    }

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
                StreamBuilder<Map<String, dynamic>?>(
                  stream: streamUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('No users found');
                    } else {
                      return Column(children: [
                        _sizedBoxUserData('Nombre: ' + snapshot.data!['name']),
                        _sizedBoxUserData(
                            'Apellido: ' + snapshot.data!['lastName']),
                        _sizedBoxUserData('DNI: ' + snapshot.data!['dni']),
                        _sizedBoxUserData(
                            'Teléfono: ' + snapshot.data!['phone'])
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

  Widget _sizedBoxUserData(text) {
    return SizedBox(
      width: 300,
      child: Container(
        decoration: BoxDecoration(
          color: customColor, // Green background
          borderRadius: BorderRadius.circular(20), // Rounded borders
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
