import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importar para los formatters

class RegisterUserPage extends StatelessWidget {
  RegisterUserPage({super.key});

  final TextEditingController _name = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _dni = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _academyYear = TextEditingController();
  final TextEditingController _division = TextEditingController();
  final TextEditingController _specialty = TextEditingController();

  final List<String> _userTypes = ['Alumno', 'Profesor'];
  String _selectedUserType = '';

  void _registerBook(BuildContext context) {
    if (_selectedUserType.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, selecciona el tipo de usuario.'),
        ),
      );
      return;
    } else if (_selectedUserType == 'Alumno') {
      if (_name.text.isEmpty ||
          _lastName.text.isEmpty ||
          _academyYear.text.isEmpty ||
          _dni.text.isEmpty ||
          _phone.text.isEmpty ||
          _division.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Por favor, completa todos los campos obligatorios para alumnos.'),
          ),
        );
        return;
      }
    } else if (_selectedUserType == 'Profesor') {
      if (_name.text.isEmpty ||
          _lastName.text.isEmpty ||
          _dni.text.isEmpty ||
          _phone.text.isEmpty ||
          _address.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Por favor, completa todos los campos obligatorios para profesores.'),
          ),
        );
        return;
      }
    }

    // Si todos los campos están completos, navegar a la página principal
    Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    const Color customColor = Color.fromARGB(210, 81, 232, 55);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar usuario'),
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
                // Reemplazar el campo de texto por un DropdownButtonFormField
                _buildDropdown(_userTypes, customColor),
                const SizedBox(height: 16),
                _buildTextField(
                    _name, 'Nombre', Icons.title_outlined, customColor),
                const SizedBox(height: 16),
                _buildTextField(
                    _lastName, 'Apellido', Icons.title_outlined, customColor),
                const SizedBox(height: 16),
                _buildTextField(
                  _dni,
                  'DNI',
                  Icons.title_outlined,
                  customColor,
                  isNumeric: true, // Validar que sea numérico
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  _phone,
                  'Teléfono',
                  Icons.phone_outlined,
                  customColor,
                  isNumeric: true, // Validar que sea numérico
                ),
                const SizedBox(height: 16),
                _buildTextField(
                    _address, 'Dirección', Icons.home_outlined, customColor),
                const SizedBox(height: 16),
                _buildTextField(
                    _academyYear, 'Curso', Icons.school_outlined, customColor),
                const SizedBox(height: 16),
                _buildTextField(
                    _division, 'División', Icons.class_outlined, customColor),
                const SizedBox(height: 16),
                _buildTextField(_specialty, 'Especialidad', Icons.work_outline,
                    customColor),
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

  // Función para construir el DropdownButtonFormField
  Widget _buildDropdown(List<String> items, Color color) {
    return SizedBox(
      width: 800,
      child: DropdownButtonFormField<String>(
        value: _selectedUserType.isEmpty ? null : _selectedUserType,
        decoration: InputDecoration(
          labelText: 'Tipo de Usuario',
          prefixIcon: Icon(Icons.person_outline, color: color),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: color, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: color.withOpacity(0.5), width: 2),
          ),
        ),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (newValue) {
          _selectedUserType = newValue!;
        },
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      IconData icon, Color color,
      {int maxLines = 1, bool isNumeric = false}) {
    return SizedBox(
      width: 800,
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        inputFormatters: isNumeric
            ? [FilteringTextInputFormatter.digitsOnly] // Solo permitir números
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
