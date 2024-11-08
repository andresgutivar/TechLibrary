// import 'package:biblioteca/models/user_book_model.dart';
// import 'package:biblioteca/pages/user-book/edit_users/edit_user_page_arguments.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class EditUserPage extends StatefulWidget {
//   static const routeName = '/editUser';

//   static const Color customColor = Color.fromARGB(210, 81, 232, 55);
//   static const Color backgroundColorOptions = Color.fromRGBO(143, 255, 124, 1);

//   const EditUserPage({super.key});

//   @override
//   State<EditUserPage> createState() => _EditUserPageState();
// }

// class _EditUserPageState extends State<EditUserPage> {
//   // Controladores de texto
//   final TextEditingController _name = TextEditingController();
//   final TextEditingController _lastName = TextEditingController();
//   final TextEditingController _dni = TextEditingController();
//   final TextEditingController _phone = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final args =
//         ModalRoute.of(context)!.settings.arguments as EditUserPageArguments;

//     FirebaseFirestore.instance
//         .collection(UserBookModel.tableName)
//         .doc(args.user["dni"])
//         .withConverter(
//           fromFirestore: UserBookModel.fromFirestore,
//           toFirestore: (UserBookModel user, options) => user.toFirestore(),
//         )
//         .get()
//         .then((DocumentSnapshot documentSnapshot) {
//       if (documentSnapshot.exists) {
//         UserBookModel user = documentSnapshot.data()! as UserBookModel;
//         _name.text = user.name!;
//         _lastName.text = user.lastName!;
//         _dni.text = user.dni!;
//         _phone.text = user.phone!;
//       }
//     });

//     void saveUser() {
//       UserBookModel user = UserBookModel(
//         name: _name.text,
//         lastName: _lastName.text,
//         dni: _dni.text,
//         phone: _phone.text,
//       );

//       FirebaseFirestore.instance
//           .collection(UserBookModel.tableName)
//           .doc(args.user["dni"])
//           .withConverter(
//             fromFirestore: UserBookModel.fromFirestore,
//             toFirestore: (UserBookModel user, options) => user.toFirestore(),
//           )
//           .set(user)
//           .then((documentSnapshot) {
//         if (context.mounted) {
//           Navigator.of(context).pop();
//         }
//       }).catchError((err) {
//         if (context.mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Error al guardar los datos del usuario.'),
//             ),
//           );
//         }
//       });
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Editar usuario'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 16),
//                 _buildTextField(_name, 'Nombre', Icons.title_outlined,
//                     EditUserPage.customColor),
//                 const SizedBox(height: 16),
//                 _buildTextField(_lastName, 'Apellido', Icons.title_outlined,
//                     EditUserPage.customColor),
//                 const SizedBox(height: 16),
//                 _buildTextField(
//                     _dni, 'DNI', Icons.credit_card, EditUserPage.customColor),
//                 const SizedBox(height: 16),
//                 _buildTextField(
//                     _phone, 'Teléfono', Icons.phone, EditUserPage.customColor),
//                 const SizedBox(height: 16),
//                 SizedBox(
//                   width: 300,
//                   child: ElevatedButton(
//                     onPressed: saveUser,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF8FFF7C),
//                       foregroundColor: Colors.black,
//                       padding: const EdgeInsets.symmetric(vertical: 14.0),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 6,
//                     ),
//                     child: const Text(
//                       'Guardar',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(TextEditingController controller, String labelText,
//       IconData icon, Color color,
//       {int maxLines = 1,
//       bool isDateField = false,
//       BuildContext? context,
//       bool isNumeric = false}) {
//     return SizedBox(
//       width: 800,
//       child: TextField(
//         controller: controller,
//         maxLines: maxLines,
//         readOnly: isDateField,
//         keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
//         inputFormatters: isNumeric
//             ? [
//                 FilteringTextInputFormatter.digitsOnly
//               ] // Solo permitir números si es necesario
//             : null,
//         decoration: InputDecoration(
//           labelText: labelText,
//           prefixIcon: Icon(icon, color: color),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(color: color, width: 2),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(color: color.withOpacity(0.5), width: 2),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _name.dispose();
//     _lastName.dispose();
//     _dni.dispose();
//     _phone.dispose();

//     super.dispose();
//   }
// }

import 'package:biblioteca/models/user_book_model.dart';
import 'package:biblioteca/pages/user-book/edit_users/edit_user_page_arguments.dart';
//import 'package:biblioteca/pages/user-book/new_users/new_user_page_arguments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:select_searchable_list/select_searchable_list.dart';

class EditUserPage extends StatefulWidget {
  static const routeName = '/editUser';

  static const Color customColor = Color.fromARGB(210, 81, 232, 55);
  static const Color backgroundColorOptions = Color.fromRGBO(143, 255, 124, 1);

  const EditUserPage({super.key});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  // Controladores de texto
  final TextEditingController _name = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _dni = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _year = TextEditingController();
  final TextEditingController _div = TextEditingController();
  final TextEditingController _career = TextEditingController();

  final Map<int, String> _listYears = {
    1: 'Seleccionar año',
    2: '1',
    3: '2',
    4: '3',
    5: '4',
    6: '5',
    7: '6',
  };

  final Map<int, String> _listCareer = {
    1: 'Seleccionar especialidad',
    2: 'Computacion',
    3: 'Construccion',
    4: 'Electrónica',
    5: 'Electricidad',
    6: 'Mecánica',
    7: 'Química',
  };

  late List<int> _selectedYear;
  late List<int> _selectedCareer;

  @override
  void initState() {
    super.initState();

    // Usamos addPostFrameCallback para esperar a que se monte el widget y poder acceder a los argumentos
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)!.settings.arguments as EditUserPageArguments;

      // Inicializar controladores y listas con valores de los argumentos
      _name.text = args.user["name"];
      _lastName.text = args.user["lastName"];
      _email.text = args.user["email"];
      _phone.text = args.user["phone"];
      _div.text = args.user["div"];
      _dni.text = args.user["dni"];
      _career.text = args.user["career"];
      _year.text = args.user["year"];

      _selectedYear = _listYears.entries
          .where((entry) => entry.value == args.user["year"])
          .map((entry) => entry.key)
          .toList();
      // _selectedCareer = _listCareer.entries
      //     .where((entry) => entry.value == args.user["career"])
      //     .map((entry) => entry.key)
      //     .toList();
      if (args.user["career"] != _listCareer[1]) {
        _selectedCareer = _listCareer.entries
            .where((entry) => entry.value == args.user["career"])
            .map((entry) => entry.key)
            .toList();
      } else {
        _selectedCareer = [1];
      }

      setState(() {}); // Para actualizar la interfaz si es necesario
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as EditUserPageArguments;

    void saveToFireBase(UserBookModel user) {
      // Mostrar el indicador de progreso
      showDialog(
        context: context,
        barrierDismissible:
            false, // Evita cerrar el diálogo tocando fuera de él
        builder: (BuildContext context) {
          return const Center(
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
          if (user.dni == args.user["dni"]) {
            // Actualizar el documento si el DNI coincide
            FirebaseFirestore.instance
                .collection(UserBookModel.tableName)
                .doc(user.dni)
                .update(user
                    .toFirestore()) // `user.toFirestore()` convierte `user` a Map
                .then((_) {
              if (context.mounted) {
                Navigator.of(context).pop(); // Cerrar el diálogo
                Navigator.of(context).pop(); // Volver a la página anterior
              }
            }).catchError((error) {
              debugPrint("Error al actualizar el documento: $error");
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Error al actualizar el usuario.')),
                );
                Navigator.of(context).pop(); // Cerrar el diálogo
                return;
              }
            });
          } else {
            // Si existe un usuario con el mismo DNI y no coincide con el actual
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'Ya existe un usuario con el mismo DNI. Por favor, cámbialo.'),
                ),
              );
              Navigator.of(context).pop(); // Cerrar el diálogo
              return;
            }
          }
        } else {
          // Si el documento no existe, crear y luego eliminar el anterior
          FirebaseFirestore.instance
              .collection(UserBookModel.tableName)
              .doc(user.dni)
              .set(user.toFirestore())
              .then((_) {
            // Eliminar el documento especificado
            return FirebaseFirestore.instance
                .collection(UserBookModel.tableName)
                .doc(args.user["dni"])
                .delete();
          }).then((_) {
            if (context.mounted) {
              Navigator.of(context).pop(); // Cerrar el diálogo
              Navigator.of(context).pop(); // Volver a la página anterior
            }
          }).catchError((err) {
            debugPrint("Error al procesar usuario: $err");
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text(
                        'Error al guardar o eliminar los datos del usuario.')),
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
                content: Text('Error al verificar la existencia del usuario.')),
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

      if (args.user["rol"] == "estudiante") {
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
        } else {
          String? careerFinal;
          if (yearValue >= 3) {
            careerFinal = _career.text;
          } else {
            careerFinal = _listCareer[1];
          }
          final user = UserBookModel(
            rol: "estudiante",
            name: _name.text,
            lastName: _lastName.text,
            dni: _dni.text,
            phone: _phone.text,
            email: _email.text,
            year: _year.text,
            div: _div.text,
            career: careerFinal,
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
        title: const Text('editar usuario'),
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
                    EditUserPage.customColor),
                const SizedBox(height: 16),
                _buildTextField(_lastName, 'Apellido', Icons.title_outlined,
                    EditUserPage.customColor),
                const SizedBox(height: 16),
                _buildTextField(
                    _dni, 'DNI', Icons.credit_card, EditUserPage.customColor,
                    isNumeric: true),
                const SizedBox(height: 16),
                _buildTextField(
                    _phone, 'Teléfono', Icons.phone, EditUserPage.customColor),
                const SizedBox(height: 16),
                _buildTextField(
                    _email, 'Email', Icons.email, EditUserPage.customColor),
                const SizedBox(height: 16),
                if (args.user["rol"] == "estudiante") ...[
                  SizedBox(
                    width: 800,
                    child: DropDownTextField(
                      borderColor: EditUserPage.customColor,
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
                            color: EditUserPage.customColor),
                        suffixIcon: Icon(Icons.arrow_drop_down,
                            color:
                                EditUserPage.customColor), // Ícono a la derecha
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: EditUserPage.customColor,
                            width:
                                2.0, // Color del borde cuando no está enfocado
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: EditUserPage.customColor,
                            width: 2.0, // Color del borde cuando está enfocado
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                      _div, 'divicion', Icons.school, EditUserPage.customColor,
                      isNumeric: true),
                  const SizedBox(height: 16),
                  if (_year.text != _listYears[1] &&
                      _year.text != _listYears[2] &&
                      _year.text != _listYears[3])
                    SizedBox(
                      width: 800,
                      child: DropDownTextField(
                        borderColor: EditUserPage.customColor,
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
                              color: EditUserPage.customColor),
                          suffixIcon: Icon(Icons.arrow_drop_down,
                              color: EditUserPage
                                  .customColor), // Ícono a la derecha
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: EditUserPage.customColor,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: EditUserPage.customColor,
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
