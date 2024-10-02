import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importar para los formatters
import 'package:intl/intl.dart';

class EditBookPage extends StatelessWidget {
  EditBookPage({super.key, required this.book});

  final Map<String, dynamic> book;

  // Controladores de texto
  final TextEditingController _title = TextEditingController();
  final TextEditingController _editorial = TextEditingController();
  final TextEditingController _author = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _entryDate = TextEditingController();
  final TextEditingController _primaryDescriptor = TextEditingController();
  final TextEditingController _pagination = TextEditingController();
  final TextEditingController _isbnCode = TextEditingController();
  final TextEditingController _secondaryDescriptor = TextEditingController();
  final TextEditingController _editingPlace = TextEditingController();
  final TextEditingController _edition = TextEditingController();
  final TextEditingController _yearEdition = TextEditingController();
  final TextEditingController _notes = TextEditingController();

  void _registerBook(BuildContext context) {
    // Verificar que todos los campos excepto notas estén completos
    if (_title.text.isEmpty ||
        _editorial.text.isEmpty ||
        _author.text.isEmpty ||
        _location.text.isEmpty ||
        _entryDate.text.isEmpty ||
        _primaryDescriptor.text.isEmpty ||
        _pagination.text.isEmpty ||
        _isbnCode.text.isEmpty ||
        _secondaryDescriptor.text.isEmpty ||
        _editingPlace.text.isEmpty ||
        _edition.text.isEmpty ||
        _yearEdition.text.isEmpty) {
      // Mostrar un mensaje de error si faltan campos
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, completa todos los campos obligatorios.'),
        ),
      );
      return;
    }

    // Si todos los campos están completos, navegar a la página principal
    Navigator.pushNamed(context, '/home');
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(_entryDate.text) ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      _entryDate.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    _title.text = book["title"] ?? '';
    _author.text = book["author"] ?? '';
    _editingPlace.text = book["editingPlace"] ?? '';
    _edition.text = book["edition"] ?? '';
    _editorial.text = book["editorial"] ?? '';

    // Manejar entryDate
    if (book["entryDate"] != null) {
      if (book["entryDate"] is Timestamp) {
        DateTime entryDate = (book["entryDate"] as Timestamp).toDate();
        _entryDate.text = DateFormat('dd/MM/yyyy').format(entryDate);
      } else if (book["entryDate"] is String) {
        _entryDate.text = book["entryDate"];
      }
    }

    _isbnCode.text = book["isbn"] ?? '';
    _location.text = book["location"] ?? '';
    _notes.text = book["notes"] ?? '';
    _pagination.text = book["pagination"] ?? '';
    _primaryDescriptor.text = book["primaryDescriptor"] ?? '';
    _secondaryDescriptor.text = book["secondaryDescriptor"] ?? '';
    _yearEdition.text = book["yearEdition"] ?? '';

    const Color customColor = Color.fromARGB(210, 81, 232, 55);
    //print(book);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Libro'),
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
                    _title, 'Título', Icons.title_outlined, customColor),
                const SizedBox(height: 16),
                _buildTextField(
                    _editorial, 'Editorial', Icons.book, customColor),
                const SizedBox(height: 16),
                _buildTextField(
                    _author, 'Autor/Autora', Icons.person, customColor),
                const SizedBox(height: 16),
                _buildTextField(_location, 'Ubicación', Icons.map, customColor),
                const SizedBox(height: 16),
                _buildTextField(
                  _entryDate,
                  'Fecha de ingreso',
                  Icons.calendar_today,
                  customColor,
                  isDateField: true,
                  context: context,
                ),
                const SizedBox(height: 16),
                _buildTextField(_primaryDescriptor, 'Descriptor primario',
                    Icons.star, customColor),
                const SizedBox(height: 16),
                _buildTextField(_secondaryDescriptor, 'Descriptor secundario',
                    Icons.star_half, customColor),
                const SizedBox(height: 16),
                _buildTextField(
                  _pagination,
                  'Paginacion',
                  Icons.auto_stories,
                  customColor,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  _isbnCode,
                  'Código ISBN',
                  Icons.vpn_key,
                  customColor,
                ),
                const SizedBox(height: 16),
                _buildTextField(_editingPlace, 'Lugar de edición',
                    Icons.location_on, customColor),
                const SizedBox(height: 16),
                _buildTextField(_edition, 'Edición', Icons.edit, customColor),
                const SizedBox(height: 16),
                _buildTextField(
                  _yearEdition,
                  'Año de edición',
                  Icons.event,
                  customColor,
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
                        borderSide: BorderSide(
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
                    onPressed: () => _registerBook(context),
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
                      'Registrar libro',
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
        onTap: isDateField && context != null
            ? () => _selectDate(context) // Al tocar, abrir el DatePicker
            : null,
      ),
    );
  }
}
