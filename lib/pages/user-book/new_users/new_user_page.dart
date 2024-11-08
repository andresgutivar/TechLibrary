import 'package:biblioteca/models/user_book_model.dart';
import 'package:biblioteca/pages/user-book/new_users/new_user_page_arguments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:select_searchable_list/select_searchable_list.dart';

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
  final List<int> _selectedYear = [1];
  final Map<int, String> _listYears = {
    1: 'Seleccionar anio',
    2: '1',
    3: '2',
    4: '3',
    5: '4',
    6: '5',
    7: '6',
  };
  final List<int> _selectedCareer = [1];

  final Map<int, String> _listCareer = {
    1: 'Seleccionar especialidad',
    2: 'Computacion',
    3: 'Construccion',
    4: 'Electronica',
    5: 'Electricidad',
    6: 'Mecanica',
    7: 'Quimica',
  };

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as NewUserPageArguments;

    void saveToFireBase(UserBookModel user) {
      // Mostrar el indicador de progreso
      showDialog(
        context: context,
        barrierDismissible:
            false, // Evita cerrar el diálogo tocando fuera de él
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      FirebaseFirestore.instance
          .collection(UserBookModel.tableName)
          .doc(user.dni)
          .get()
          .then((documentSnapshot) {
        if (documentSnapshot.exists) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Ya existe un usuario con este DNI.'),
              ),
            );
            Navigator.of(context).pop(); // Cerrar el diálogo
          }
        } else {
          FirebaseFirestore.instance
              .collection(UserBookModel.tableName)
              .doc(user.dni)
              .set(user.toFirestore())
              .then((_) {
            if (context.mounted) {
              Navigator.of(context).pop(); // Cerrar el diálogo
              Navigator.of(context).pop(); // Volver a la página anterior
            }
          }).catchError((err) {
            debugPrint("Error al guardar usuario: $err");
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Error al guardar los datos del usuario.'),
                ),
              );
              Navigator.of(context).pop(); // Cerrar el diálogo
            }
          });
        }
      }).catchError((err) {
        debugPrint("Error al verificar existencia del usuario: $err");
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error al verificar la existencia del usuario.'),
            ),
          );
          Navigator.of(context).pop(); // Cerrar el diálogo
        }
      });
    }

    void saveUser() {
      int yearValue = 0;
      if (_year.text.isNotEmpty) {
        yearValue = int.tryParse(_year.text) ?? 0;
      }

      if (args.userType == UserType.alumno) {
        if (_name.text.isEmpty ||
            _lastName.text.isEmpty ||
            _dni.text.isEmpty ||
            _year.text == _listYears[1] ||
            _div.text.isEmpty ||
            _email.text.isEmpty ||
            (yearValue >= 3 && _career.text == _listCareer[1])) {
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
              content: Text('Por favor, ingrese un valor válido para el año.'),
            ),
          );
          return;
        } else {
          final user = UserBookModel(
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
          final user = UserBookModel(
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
                    _dni, 'DNI', Icons.credit_card, NewUserPage.customColor,
                    isNumeric: true),
                const SizedBox(height: 16),
                _buildTextField(
                    _phone, 'Teléfono', Icons.phone, NewUserPage.customColor),
                const SizedBox(height: 16),
                _buildTextField(
                    _email, 'Email', Icons.email, NewUserPage.customColor),
                const SizedBox(height: 16),
                if (args.userType == UserType.alumno) ...[
                  SizedBox(
                    width: 800,
                    child: DropDownTextField(
                      borderColor: NewUserPage.customColor,
                      textEditingController: _year,
                      isSearchVisible: false,
                      title: 'Año',
                      hint: 'Selecciona el año',
                      options: _listYears,
                      selectedOptions: _selectedYear,
                      multiple: false,
                      decoration: InputDecoration(
                        labelText: 'Año',
                        prefixIcon: Icon(Icons.title_outlined,
                            color: NewUserPage.customColor),
                        suffixIcon: Icon(Icons.arrow_drop_down,
                            color:
                                NewUserPage.customColor), // Ícono a la derecha
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: NewUserPage.customColor,
                            width:
                                2.0, // Color del borde cuando no está enfocado
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: NewUserPage.customColor,
                            width: 2.0, // Color del borde cuando está enfocado
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                      _div, 'divicion', Icons.school, NewUserPage.customColor,
                      isNumeric: true),
                  const SizedBox(height: 16),
                  if (_year.text != _listYears[1] &&
                      _year.text != _listYears[2] &&
                      _year.text != _listYears[3])
                    SizedBox(
                      width: 800,
                      child: DropDownTextField(
                        borderColor: NewUserPage.customColor,
                        textEditingController: _career,
                        isSearchVisible: false,
                        title: 'Especialidad',
                        hint: 'Selecciona la especialidad',
                        options: _listCareer,
                        selectedOptions: _selectedCareer,
                        multiple: false,
                        decoration: InputDecoration(
                          labelText: 'Especialidad',
                          prefixIcon: Icon(Icons.title_outlined,
                              color: NewUserPage.customColor),
                          suffixIcon: Icon(Icons.arrow_drop_down,
                              color: NewUserPage
                                  .customColor), // Ícono a la derecha
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: NewUserPage.customColor,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: NewUserPage.customColor,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                ],
                const SizedBox(height: 32),
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
        inputFormatters:
            isNumeric ? [FilteringTextInputFormatter.digitsOnly] : null,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon, color: color),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: color,
                width: 2.0), // Color del borde cuando no está enfocado
            borderRadius: BorderRadius.circular(10.0),
          ),
          // Borde cuando el TextField está enfocado
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: color,
                width: 2.0), // Color del borde cuando está enfocado
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onTap: () async {
          if (isDateField) {
            DateTime? pickedDate = await showDatePicker(
              context: context!,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              controller.text = pickedDate.toIso8601String().split("T")[0];
            }
          }
        },
      ),
    );
  }
}
