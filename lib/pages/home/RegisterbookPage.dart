import 'package:flutter/material.dart';

class RegisterbookPage extends StatelessWidget {
  RegisterbookPage({super.key});

  // Controladores de texto
  final TextEditingController _tittle = TextEditingController();
  final TextEditingController _editorial = TextEditingController();
  final TextEditingController _author = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _entryDate = TextEditingController();
  final TextEditingController _primaryDescriptor = TextEditingController();
  final TextEditingController _numberPages = TextEditingController();
  final TextEditingController _isbnCode = TextEditingController();
  final TextEditingController _secondaryDescriptor = TextEditingController();
  final TextEditingController _editingPlace = TextEditingController();
  final TextEditingController _edition = TextEditingController();
  final TextEditingController _yearEdition = TextEditingController();
  final TextEditingController _notes = TextEditingController();

  void _registerBook(BuildContext context) {
    // Verificar que todos los campos excepto notas estén completos
    if (_tittle.text.isEmpty ||
        _editorial.text.isEmpty ||
        _author.text.isEmpty ||
        _location.text.isEmpty ||
        _entryDate.text.isEmpty ||
        _primaryDescriptor.text.isEmpty ||
        _numberPages.text.isEmpty ||
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

  @override
  Widget build(BuildContext context) {
    const Color customColor = Color.fromARGB(210, 81, 232, 55);
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
                    _tittle, 'Titulo', Icons.title_outlined, customColor),
                const SizedBox(height: 16),
                _buildTextField(
                    _editorial, 'Editorial', Icons.numbers, customColor),
                const SizedBox(height: 16),
                _buildTextField(
                    _author, 'Autor/Autora', Icons.person, customColor),
                const SizedBox(height: 16),
                _buildTextField(_location, 'Ubicación', Icons.map, customColor),
                const SizedBox(height: 16),
                _buildTextField(_entryDate, 'Fecha de ingreso',
                    Icons.calendar_month, customColor),
                const SizedBox(height: 16),
                _buildTextField(_primaryDescriptor, 'Descriptor primario',
                    Icons.star, customColor),
                const SizedBox(height: 16),
                _buildTextField(_secondaryDescriptor, 'Descriptor secundario',
                    Icons.star_half, customColor),
                const SizedBox(height: 16),
                _buildTextField(_numberPages, 'Cantidad de paginas',
                    Icons.auto_stories, customColor),
                const SizedBox(height: 16),
                _buildTextField(
                    _isbnCode, 'Codigo ISBN', Icons.vpn_key, customColor),
                const SizedBox(height: 16),
                _buildTextField(_editingPlace, 'Lugar de edicion',
                    Icons.location_on, customColor),
                const SizedBox(height: 16),
                _buildTextField(_edition, 'Edicion', Icons.tag, customColor),
                const SizedBox(height: 16),
                _buildTextField(
                    _yearEdition, 'Año de edicion', Icons.event, customColor),
                const SizedBox(height: 16),
                SizedBox(
                  width: 800,
                  child: TextField(
                    controller: _notes, // Controlador del correo
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
      {int maxLines = 1}) {
    return SizedBox(
      width: 800,
      child: TextField(
        controller: controller,
        maxLines: maxLines,
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
