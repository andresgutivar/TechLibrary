import 'package:biblioteca/models/book_model.dart';
import 'package:biblioteca/pages/book/edit-book/edit-book-page-arguments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditBookPageNew extends StatefulWidget {
  const EditBookPageNew({super.key});
  static const Color customColor = Color.fromARGB(210, 81, 232, 55);
  static const routeName = '/editBook';
  @override
  State<EditBookPageNew> createState() => _EditBookPageNewState();
}

class _EditBookPageNewState extends State<EditBookPageNew> {
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
  late DateTime finalEntryDate;

  @override
  void initState() {
    super.initState();

    // Usamos addPostFrameCallback para esperar a que se monte el widget y poder acceder a los argumentos
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)!.settings.arguments as EditBookPageArguments;
      FirebaseFirestore.instance
          .collection(BookModel.tableName)
          .doc(args.isbn)
          .withConverter(
            fromFirestore: BookModel.fromFirestore,
            toFirestore: (BookModel book, options) => book.toFirestore(),
          )
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          BookModel book = documentSnapshot.data()! as BookModel;
          _tittle.text = book.title!;
          _editorial.text = book.editorial!;
          _author.text = book.author!;
          _location.text = book.location!;
          finalEntryDate = book.entryDate!.toDate();
          _entryDate.text =
              "${finalEntryDate.day}/${finalEntryDate.month}/${finalEntryDate.year}";
          _primaryDescriptor.text = book.primaryDescriptor!;
          _numberPages.text = book.pagination!;
          _isbnCode.text = book.isbn!;
          _secondaryDescriptor.text = book.secondaryDescriptor!;
          _editingPlace.text = book.editingPlace!;
          _edition.text = book.edition!;
          _yearEdition.text = book.yearEdition!;
          _notes.text = book.notes!;
        }
        //Navigator.of(context).pop(); // Cerrar el diálogo
      });

      setState(() {}); // Para actualizar la interfaz si es necesario
    });
  }

  @override
  Widget build(BuildContext context) {
    // showDialog(
    //   context: context,
    //   barrierDismissible: false, // Evita cerrar el diálogo tocando fuera de él
    //   builder: (BuildContext context) {
    //     return Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   },
    // );
    final args =
        ModalRoute.of(context)!.settings.arguments as EditBookPageArguments;

    Future<void> updateBook() async {
      //print("entraste");
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor, completa todos los campos obligatorios.'),
          ),
        );
        Navigator.of(context).pop(); // Cerrar el diálogo
        return;
      } else {
        BookModel book = BookModel(
          author: _author.text,
          editingPlace: _editingPlace.text,
          edition: _edition.text,
          editorial: _editorial.text,
          entryDate: Timestamp.fromDate(finalEntryDate),
          isbn: _isbnCode.text,
          location: _location.text,
          notes: _notes.text,
          pagination: _numberPages.text,
          primaryDescriptor: _primaryDescriptor.text,
          secondaryDescriptor: _secondaryDescriptor.text,
          title: _tittle.text,
          yearEdition: _yearEdition.text,
        );

        final ref = FirebaseFirestore.instance
            .collection(BookModel.tableName)
            .doc(_isbnCode.text)
            .withConverter(
              fromFirestore: BookModel.fromFirestore,
              toFirestore: (BookModel auxBook, options) =>
                  auxBook.toFirestore(),
            );
        final docSnap = await ref.get();

        if (docSnap.data() != null && docSnap["isbn"] != args.isbn) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Ya existe un libro con este ISBN.'),
            ),
          );
          Navigator.of(context).pop(); // Cerrar el diálogo
          return;
        } else {
          FirebaseFirestore.instance
              .collection(BookModel.tableName)
              .doc(_isbnCode.text)
              .withConverter(
                fromFirestore: BookModel.fromFirestore,
                toFirestore: (BookModel user, options) => user.toFirestore(),
              )
              .set(book)
              .then((documentSnapshot) {
            /*eliminamos el documento existente con el isbn anterior, ya que lo que sucede es que
                al darle un nuevo isbn lo detecta como inexistente y lo que hace es crear 
                uno nuevo duplicando todos los datos*/
            if (args.isbn != _isbnCode.text) {
              FirebaseFirestore.instance
                  .collection(BookModel.tableName)
                  .doc(args.isbn)
                  .delete()
                  .then(
                    (doc) => print("Document deleted"),
                    onError: (e) => print("Error updating document $e"),
                  );
            }

            if (context.mounted) {
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Cerrar el diálogo
            }
          }).catchError((err) {
            print(err);
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
      }
    }

    // print(args.isbn);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Libro'),
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
                _buildTextField(_tittle, 'Título', Icons.title_outlined,
                    EditBookPageNew.customColor),
                const SizedBox(height: 16),
                _buildTextField(_editorial, 'Editorial', Icons.numbers,
                    EditBookPageNew.customColor),
                const SizedBox(height: 16),
                _buildTextField(_author, 'Autor/Autora', Icons.person,
                    EditBookPageNew.customColor),
                const SizedBox(height: 16),
                _buildTextField(_location, 'Ubicación', Icons.map,
                    EditBookPageNew.customColor),
                const SizedBox(height: 16),
                _buildTextField(
                  _entryDate,
                  'Fecha de ingreso',
                  Icons.calendar_month,
                  EditBookPageNew.customColor,
                  isDateField: true,
                  context: context,
                ),
                const SizedBox(height: 16),
                _buildTextField(_primaryDescriptor, 'Descriptor primario',
                    Icons.star, EditBookPageNew.customColor),
                const SizedBox(height: 16),
                _buildTextField(_secondaryDescriptor, 'Descriptor secundario',
                    Icons.star_half, EditBookPageNew.customColor),
                const SizedBox(height: 16),
                _buildTextField(
                  _numberPages,
                  'Cantidad de páginas',
                  Icons.auto_stories,
                  EditBookPageNew.customColor,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  _isbnCode,
                  'Código ISBN',
                  Icons.vpn_key,
                  EditBookPageNew.customColor,
                ),
                const SizedBox(height: 16),
                _buildTextField(_editingPlace, 'Lugar de edición',
                    Icons.location_on, EditBookPageNew.customColor),
                const SizedBox(height: 16),
                _buildTextField(_edition, 'Edición', Icons.tag,
                    EditBookPageNew.customColor),
                const SizedBox(height: 16),
                _buildTextField(
                  _yearEdition,
                  'Año de edición',
                  Icons.event,
                  EditBookPageNew.customColor,
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
                          color: EditBookPageNew.customColor,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: EditBookPageNew.customColor.withOpacity(0.5),
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
                    onPressed: () => updateBook(),
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
                      'Editar libro',
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

  Widget _buildTextField(
    TextEditingController controller,
    String labelText,
    IconData icon,
    Color color, {
    int maxLines = 1,
    bool isDateField = false,
    BuildContext? context,
  }) {
    return SizedBox(
      width: 800,
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        readOnly: isDateField,
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
            ? () => _selectDate(context, controller)
            : null,
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: finalEntryDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      //print(pickedDate);
      finalEntryDate = pickedDate;
      //print(finalEntryDate);
      controller.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }

  @override
  void dispose() {
    _tittle.dispose();
    _editorial.dispose();
    _author.dispose();
    _location.dispose();
    _entryDate.dispose();
    _primaryDescriptor.dispose();
    _secondaryDescriptor.dispose();
    _numberPages.dispose();
    _isbnCode.dispose();
    _editingPlace.dispose();
    _edition.dispose();
    _yearEdition.dispose();
    _notes.dispose();
    super.dispose();
  }
}
