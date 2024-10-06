import 'package:biblioteca/models/user_book_model.dart';
import 'package:biblioteca/pages/edit_users/edit_user_page_arguments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditUserPage extends StatelessWidget {
  static const routeName = '/editUser';

  static const Color customColor = Color.fromARGB(210, 81, 232, 55);
  static const Color backgroundColorOptions = Color(0xfff8FFF7C);

  // Controladores de texto
  final TextEditingController _name = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _dni = TextEditingController();
  final TextEditingController _phone = TextEditingController();

  EditUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as EditUserPageArguments;

    FirebaseFirestore.instance
        .collection(UserBookModel.tableName)
        .doc(args.dni)
        .withConverter(
          fromFirestore: UserBookModel.fromFirestore,
          toFirestore: (UserBookModel user, options) => user.toFirestore(),
        )
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        UserBookModel user = documentSnapshot.data()! as UserBookModel;
        _name.text = user.name!;
        _lastName.text = user.lastName!;
        _dni.text = user.dni!;
        _phone.text = user.phone!;
      }
    });

    void saveUser() {
      UserBookModel user = UserBookModel(
        name: _name.text,
        lastName: _lastName.text,
        dni: _dni.text,
        phone: _phone.text,
      );

      FirebaseFirestore.instance
          .collection(UserBookModel.tableName)
          .doc(args.dni)
          .withConverter(
            fromFirestore: UserBookModel.fromFirestore,
            toFirestore: (UserBookModel user, options) => user.toFirestore(),
          )
          .set(user)
          .then((documentSnapshot) {
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      }).catchError((err) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error al guardar los datos del usuario.'),
            ),
          );
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                _buildTextField(
                    _name, 'Nombre', Icons.title_outlined, customColor),
                const SizedBox(height: 16),
                _buildTextField(
                    _lastName, 'Apellido', Icons.title_outlined, customColor),
                const SizedBox(height: 16),
                _buildTextField(_dni, 'DNI', Icons.credit_card, customColor),
                const SizedBox(height: 16),
                _buildTextField(_phone, 'Teléfono', Icons.phone, customColor),
                const SizedBox(height: 16),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: saveUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8FFF7C),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 6,
                    ),
                    child: const Text(
                      'Guardar',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      IconData icon, Color color,
      {int maxLines = 1,
      bool isDateField = false,
      BuildContext? context,
      bool isNumeric = false}) {
    return SizedBox(
      width: 800,
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        readOnly: isDateField,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        inputFormatters: isNumeric
            ? [
                FilteringTextInputFormatter.digitsOnly
              ] // Solo permitir números si es necesario
            : null,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon, color: color),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: color, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: color.withOpacity(0.5), width: 2),
          ),
        ),
      ),
    );
  }
}
