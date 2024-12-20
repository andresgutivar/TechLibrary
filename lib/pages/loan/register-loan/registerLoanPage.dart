import 'package:biblioteca/models/book_model.dart';
import 'package:biblioteca/models/user_book_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import necesario para los inputFormatters
import 'package:biblioteca/globals/globals.dart';

class RegisterLoanPage extends StatefulWidget {
  RegisterLoanPage({super.key, required this.codigoISBN});

  final String codigoISBN;

  @override
  State<RegisterLoanPage> createState() => _RegisterLoanPageState();
}

class _RegisterLoanPageState extends State<RegisterLoanPage> {
  // Controladores de texto
  final TextEditingController _userDni = TextEditingController();

  final TextEditingController _isbnCode = TextEditingController();

  final TextEditingController _today = TextEditingController();

  final TextEditingController _dateToReturn = TextEditingController();

  final TextEditingController _notes = TextEditingController();

  void _registerLoan(BuildContext context) {
    // Verificar que todos los campos excepto notas estén completos
    if (_userDni.text.isEmpty ||
        _isbnCode.text.isEmpty ||
        _today.text.isEmpty ||
        _dateToReturn.text.isEmpty) {
      // Mostrar un mensaje de error si faltan campos
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, completa todos los campos obligatorios.'),
        ),
      );
      return;
    } else {
      // Convertir las fechas del formato de texto a DateTime
      try {
        // Formato esperado: dd/mm/yyyy
        List<String> todayParts = _today.text.split('/');
        DateTime loanDate = DateTime(
          int.parse(todayParts[2]),
          int.parse(todayParts[1]),
          int.parse(todayParts[0]),
        );

        List<String> returnParts = _dateToReturn.text.split('/');
        DateTime returnDate = DateTime(
          int.parse(returnParts[2]),
          int.parse(returnParts[1]),
          int.parse(returnParts[0]),
        );

        // Convertir DateTime a Timestamp
        Timestamp loanTimestamp = Timestamp.fromDate(loanDate);
        Timestamp returnTimestamp = Timestamp.fromDate(returnDate);

        FirebaseFirestore.instance
            .collection(UserBookModel.tableName)
            .doc(_userDni.text)
            .get()
            .then((documentSnapshot) {
          if (documentSnapshot.exists) {
            FirebaseFirestore.instance
                .collection(BookModel.tableName)
                .doc(_isbnCode.text)
                .update({
              "lenderId": CurrentUserData
                  .currentDniUser, //tengo que hacer que esto se pase directamente por alguna variable global
              "status": "prestado",
              "userId": _userDni.text,
              "returnDate":
                  returnTimestamp, // Actualizar con el valor de returnDate
              "loanDate": loanTimestamp, // Actualizar con el valor de loanDate
            }).then((value) => Navigator.pushNamed(
                      context,
                      "/home",
                    ));
          } else {
            // Si el usuario no existe, mostramos un mensaje de error.
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'No existe un usuario con este DNI, porfavor ingrese un valor valido o cree al nuevo usuario'),
                ),
              );
            }
          }
        });
      } catch (e) {
        // Manejar cualquier error en la conversión de fechas
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Por favor, ingresa fechas válidas en el formato dd/mm/yyyy.'),
          ),
        );
      }
    }
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      // Actualiza el campo de texto con la fecha seleccionada
      controller.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color customColor = Color.fromARGB(210, 81, 232, 55);
    _isbnCode.text = widget.codigoISBN; // Asigna el código ISBN

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Préstamo'),
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
                _buildInputField(
                  _isbnCode,
                  'Código ISBN',
                  Icons.title_outlined,
                  customColor,
                  true,
                ),
                const SizedBox(height: 16),
                _buildInputField(
                  _userDni,
                  'DNI de usuario',
                  Icons.perm_identity,
                  customColor,
                  false,
                  isNumeric: true, // Configurado para aceptar solo números
                ),
                const SizedBox(height: 16),
                _buildInputField(
                  _today,
                  'Fecha de entrega',
                  Icons.calendar_today,
                  customColor,
                  false,
                  isDateField: true,
                  context: context,
                ),
                const SizedBox(height: 16),
                _buildInputField(
                  _dateToReturn,
                  'Fecha a devolver',
                  Icons.calendar_today,
                  customColor,
                  false,
                  isDateField: true,
                  context: context,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 800,
                  child: TextField(
                    controller: _notes,
                    maxLines: 5,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'Notas',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: customColor,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: customColor.withOpacity(0.5),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () => _registerLoan(context),
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
                      'Registrar Préstamo',
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

  Widget _buildInputField(TextEditingController controller, String labelText,
      IconData icon, Color color, bool read,
      {int maxLines = 1,
      bool isDateField = false,
      bool isNumeric = false,
      BuildContext? context}) {
    return SizedBox(
      width: 800,
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        readOnly: read || isDateField,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        inputFormatters: isNumeric
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly, // Solo números
              ]
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
        onTap: isDateField && context != null
            ? () =>
                _selectDate(context, controller) // Abrir DatePicker al tocar
            : null,
      ),
    );
  }
}
