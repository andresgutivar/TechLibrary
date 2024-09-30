import 'package:biblioteca/models/user.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

class ViewUserDetail extends StatelessWidget {
  const ViewUserDetail({super.key});
  static const Color customColor = Color.fromARGB(210, 81, 232, 55);
  static const Color backgroundColorOptions = Color(0xfff8FFF7C);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> user =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    print(user);

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
                SizedBox(height: 16),
                _sizedBoxUserData('Nombre: ' + user['name']),
                SizedBox(height: 8),
                _sizedBoxUserData('Apellido: ' + user['lastName']),
                SizedBox(height: 8),
                _sizedBoxUserData('DNI: ' + user['dni']),
                SizedBox(height: 8),
                _sizedBoxUserData('Teléfono: ' + user['phone']),
                // _sizedBoxUserData('Dirección: ' + user['address']),
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
