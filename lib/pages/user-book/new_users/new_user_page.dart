import 'package:biblioteca/models/user_book_model.dart';
import 'package:biblioteca/pages/user-book/new_users/new_user_page_arguments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewUserPage extends StatefulWidget {
  static const routeName = '/newUser';

  static const Color customColor = Color.fromARGB(210, 81, 232, 55);
  static const Color backgroundColorOptions = Color.fromRGBO(143, 255, 124, 1);

  const NewUserPage({super.key});

  @override
  State<NewUserPage> createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  // Controladores de texto
  final TextEditingController _name = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _dni = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _year = TextEditingController();
  final TextEditingController _div = TextEditingController();
  final TextEditingController _career = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as NewUserPageArguments;

    void saveToFireBase(user) {
      FirebaseFirestore.instance
          .collection(UserBookModel.tableName)
          .doc(user.dni)
          .get()
          .then((documentSnapshot) {
        if (documentSnapshot.exists) {
          // Si el documento ya existe, mostramos un mensaje de error.
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Ya existe un usuario con este DNI.'),
              ),
            );
          }
        } else {
          FirebaseFirestore.instance
              .collection(UserBookModel.tableName)
              .doc(_dni.text)
              .withConverter(
                fromFirestore: UserBookModel.fromFirestore,
                toFirestore: (UserBookModel user, options) =>
                    user.toFirestore(),
              )
              .set(user)
              .then((_) {
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          }).catchError((err) {
            print(err);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Error al guardar los datos del usuario.'),
                ),
              );
            }
          });
        }
      }).catchError((err) {
        print(err);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error al verificar la existencia del usuario.'),
            ),
          );
        }
      });
    }

    void saveUser() {
      // UserBookModel user = UserBookModel(
      //   name: _name.text,
      //   lastName: _lastName.text,
      //   dni: _dni.text,
      //   phone: _phone.text,
      // );

      if (args.userType == UserType.alumno) {
        int yearValue = 0;
        if (_year.text.isNotEmpty) {
          yearValue = int.parse(_year.text);
        }

        if (_name.text.isEmpty ||
            _lastName.text.isEmpty ||
            _dni.text.isEmpty ||
            _year.text.isEmpty ||
            _div.text.isEmpty ||
            _email.text.isEmpty ||
            (yearValue >= 3 && _career.text.isEmpty)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('Por favor, completa todos los campos obligatorios.'),
            ),
          );
          return;
        } else if (yearValue > 6) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Por favor, ingrese un valor valido para el anio.'),
            ),
          );
          return;
        } else {
          UserBookModel user = UserBookModel(
            rol: "estudiante",
            name: _name.text,
            lastName: _lastName.text,
            dni: _dni.text,
            phone: _phone.text,
            email: _email.text,
            year: _year.text,
            div: _div.text,
            career: _career.text,
          );
          saveToFireBase(user);
        }
      } else {
        //logica para el profesor

        if (_name.text.isEmpty ||
            _lastName.text.isEmpty ||
            _dni.text.isEmpty ||
            _email.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('Por favor, completa todos los campos obligatorios.'),
            ),
          );
          return;
        } else {
          UserBookModel user = UserBookModel(
            rol: "docente",
            name: _name.text,
            lastName: _lastName.text,
            dni: _dni.text,
            phone: _phone.text,
            email: _email.text,
          );
          saveToFireBase(user);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo usuario'),
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
                _buildTextField(_name, 'Nombre', Icons.title_outlined,
                    NewUserPage.customColor),
                const SizedBox(height: 16),
                _buildTextField(_lastName, 'Apellido', Icons.title_outlined,
                    NewUserPage.customColor),
                const SizedBox(height: 16),
                _buildTextField(
                    _dni, 'DNI', Icons.credit_card, NewUserPage.customColor),
                const SizedBox(height: 16),
                _buildTextField(
                    _phone, 'Teléfono', Icons.phone, NewUserPage.customColor),
                const SizedBox(height: 16),
                _buildTextField(
                    _email, 'Email', Icons.email, NewUserPage.customColor),
                const SizedBox(height: 16),
                if (args.userType == UserType.alumno) ...[
                  _buildTextField(
                      _year, 'anio', Icons.person, NewUserPage.customColor,
                      isNumeric: true),
                  const SizedBox(height: 16),
                  _buildTextField(
                      _div, 'divicion', Icons.school, NewUserPage.customColor,
                      isNumeric: true),
                  const SizedBox(height: 16),
                  _buildTextField(_career, 'especialidad', Icons.star,
                      NewUserPage.customColor),
                  const SizedBox(height: 16),
                ],
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

  @override
  void dispose() {
    _name.dispose();
    _lastName.dispose();
    _dni.dispose();
    _phone.dispose();
    _div.dispose();
    _email.dispose();
    _year.dispose();
    super.dispose();
  }
}
