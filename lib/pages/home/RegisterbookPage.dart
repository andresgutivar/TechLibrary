import 'package:flutter/material.dart';

class RegisterbookPage extends StatefulWidget {
  const RegisterbookPage({super.key});

  @override
  State<RegisterbookPage> createState() => _RegisterbookState();
}

class _RegisterbookState extends State<RegisterbookPage> {
  final _tittle = TextEditingController();
  final _editorial = TextEditingController();
  final _author = TextEditingController();
  final _location = TextEditingController();
  final _entryDate = TextEditingController();
  final _primaryDescriptor = TextEditingController();
  final _numberPages = TextEditingController();
  final _isbnCode = TextEditingController();
  final _secondaryDescriptor = TextEditingController();
  final _editingPlace = TextEditingController();
  final _edition = TextEditingController();
  final _yearEdition = TextEditingController();
  final _notes = TextEditingController();

  void _registerBook() {
    // Función que se llamará al registrar
    String tittle = _tittle.text;
    String editorial = _editorial.text;
    String author = _author.text;
    String location = _location.text;
    String entryDate = _entryDate.text;
    String primaryDescriptor = _primaryDescriptor.text;
    String numberPages = _numberPages.text;
    String isbnCode = _isbnCode.text;
    String secondaryDescriptor = _secondaryDescriptor.text;
    String editingPlace = _editingPlace.text;
    String edition = _edition.text;
    String yearEdition = _yearEdition.text;
    String notes = _notes.text;

    Navigator.pushNamed(context, '/home');
    //  print("Email: $email, Password: $password");
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
            // Scroll para evitar overflow
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                SizedBox(
                  width: 800,
                  child: TextField(
                    controller: _tittle, // Controlador del correo
                    decoration: InputDecoration(
                      labelText: 'Titulo',
                      prefixIcon:
                          const Icon(Icons.title_outlined, color: customColor),
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
                  width: 800,
                  child: TextField(
                    controller: _editorial, // Controlador del correo
                    decoration: InputDecoration(
                      labelText: 'Editorial',
                      prefixIcon: const Icon(Icons.numbers, color: customColor),
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
                  width: 800,
                  child: TextField(
                    controller: _author, // Controlador del correo
                    decoration: InputDecoration(
                      labelText: 'Autor/Autora',
                      prefixIcon: const Icon(Icons.person, color: customColor),
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
                  width: 800,
                  child: TextField(
                    controller: _location, // Controlador del correo
                    decoration: InputDecoration(
                      labelText: 'Ubicación',
                      prefixIcon: const Icon(Icons.map, color: customColor),
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
                  width: 800,
                  child: TextField(
                    controller: _entryDate, // Controlador del correo
                    decoration: InputDecoration(
                      labelText: 'Fecha de ingreso',
                      prefixIcon:
                          const Icon(Icons.calendar_month, color: customColor),
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
                  width: 800,
                  child: TextField(
                    controller: _primaryDescriptor, // Controlador del correo
                    decoration: InputDecoration(
                      labelText: 'Descriptor primario',
                      prefixIcon: const Icon(Icons.star, color: customColor),
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
                  width: 800,
                  child: TextField(
                    controller: _secondaryDescriptor, // Controlador del correo
                    decoration: InputDecoration(
                      labelText: 'Descriptor secundario',
                      prefixIcon:
                          const Icon(Icons.star_half, color: customColor),
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
                  width: 800,
                  child: TextField(
                    controller: _numberPages, // Controlador del correo
                    decoration: InputDecoration(
                      labelText: 'Cantidad de paginas',
                      prefixIcon:
                          const Icon(Icons.auto_stories, color: customColor),
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
                  width: 800,
                  child: TextField(
                    controller: _isbnCode, // Controlador del correo
                    decoration: InputDecoration(
                      labelText: 'Codigo ISBN',
                      prefixIcon: const Icon(Icons.vpn_key, color: customColor),
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
                  width: 800,
                  child: TextField(
                    controller: _editingPlace, // Controlador del correo
                    decoration: InputDecoration(
                      labelText: 'Lugar de edicion',
                      prefixIcon:
                          const Icon(Icons.location_on, color: customColor),
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
                  width: 800,
                  child: TextField(
                    controller: _edition, // Controlador del correo
                    decoration: InputDecoration(
                      labelText: 'Edicion',
                      prefixIcon: const Icon(Icons.tag, color: customColor),
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
                  width: 800,
                  child: TextField(
                    controller: _yearEdition, // Controlador del correo
                    decoration: InputDecoration(
                      labelText: 'Año de edicion',
                      prefixIcon: const Icon(Icons.event, color: customColor),
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
                    onPressed: _registerBook,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF8FFF7C), // Color de fondo 8FFF7C
                      foregroundColor: Colors.black, // Color del texto
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      // Espaciado interno
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12), // Bordes redondeados
                      ),
                      elevation: 6, // Sombra del botón
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
}
