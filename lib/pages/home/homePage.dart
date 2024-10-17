import 'package:biblioteca/models/book_model.dart';
import 'package:biblioteca/pages/book/edit-book/edit-book-page-arguments.dart';
import 'package:biblioteca/pages/book/edit-book/editBookPageNew.dart';
import 'package:biblioteca/pages/loan/view-loan/infoLoanPageArguments.dart';
import 'package:biblioteca/pages/loan/view-loan/infoLoanPageNew.dart';
import 'package:biblioteca/pages/user-book/edit_users/edit_user_page.dart';
import 'package:biblioteca/pages/user-book/new_users/new_user_type_selection_page.dart';
import 'package:biblioteca/pages/user-book/view_users/view_users_page.dart';
import 'package:biblioteca/services/authentication.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../book/edit-book/editBookPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const Color customColor = Color.fromARGB(210, 81, 232, 55);
  static const Color backgroundColorOptions = Color(0xfff8FFF7C);

  final _authService = AuthenticationService();

  late Stream<List<Map<String, dynamic>>> booksFromFilter;
  Stream<List<Map<String, dynamic>>> booksFromDB = FirebaseFirestore.instance
      .collection('books')
      .snapshots()
      .map((snapshot) {
    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  });

  void _logOut() {
    //logica para cerrar sesion
    //Navigator.pushNamed(context, '/login');
    _authService.signOut(context);
  }

  void deleteBook(book) {
    FirebaseFirestore.instance
        .collection(BookModel.tableName)
        .doc(book)
        .delete()
        .then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }

  @override
  void initState() {
    super.initState();
    booksFromFilter = booksFromDB;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: myAppBarWidget(
          customColor: customColor,
          backgroundColorOptions: backgroundColorOptions,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Center(child: _buildSearchBar()), // Coloca el SearchBar aquí

          StreamBuilder<List<Map<String, dynamic>>>(
            stream: booksFromFilter,
            builder: (context, booksFromFilterData) {
              if (booksFromFilterData.hasError) {
                return Text('Error: ${booksFromFilterData.error}');
              } else if (!booksFromFilterData.hasData &&
                  booksFromFilterData.connectionState !=
                      ConnectionState.waiting) {
                return Text(
                    'Error al cargar los datos. Es posible que el usuario se halla eliminado. Contactese con los encargados de la aplicacion.');
              } else {
                // Si no hay errores y los datos estan cargados
                if (booksFromFilterData.data != null) {
                  return ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8.0),
                      children: [
                        Column(
                          children: booksFromFilterData.data!.map((user) {
                            return _buildExpansionTileCard(context, user);
                          }).toList(),
                        )
                      ]);
                } else {
                  if (booksFromFilterData.connectionState ==
                      ConnectionState.done) {
                    return Text("No se encontraron datos");
                  } else {
                    return CircularProgressIndicator();
                  }
                }
              }
            },
          ), // Aquí llamamos a nuestro método para crear la tarjeta
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 50.0, // Controlar la altura máxima
          minWidth: 200.0, // Controlar el ancho mínimo
          maxWidth: 1000.0, // Controlar el ancho máximo
        ),
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search), // Icono de búsqueda
            hintText: 'Buscar...', // Texto de sugerencia
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0), // Bordes redondeados
              borderSide:
                  const BorderSide(color: Colors.grey), // Color del borde
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0), // Bordes redondeados
              borderSide: const BorderSide(
                  color: customColor), // Color del borde al tener foco
            ),
          ),
          onChanged: (value) {
            // Filtrar los libros por el valor ingresado
            setState(() {
              booksFromFilter = booksFromDB.map((books) {
                return books.where((book) {
                  return book["title"].contains(value);
                }).toList();
              });
            });
          },
        ),
      ),
    );
  }

  Widget _buildExpansionTileCard(
      BuildContext context, Map<String, dynamic> book) {
    //print(book["pagination"].runtimeType);
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ExpansionTileCard(
        baseColor: backgroundColorOptions,
        expandedColor: backgroundColorOptions,
        title: Text(book['title']),
        subtitle: Text('Descriptor primario: ' + book["primaryDescriptor"]),
        leading: book["status"] == 'disponible'
            ? const Icon(Icons.done)
            : const Icon(Icons.close),
        children: <Widget>[
          const Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Autor: " + book["author"]),
                Text("Código ISBN: " + book["isbn"]),
                Text("Estado: " + book["status"]),
              ],
            ),
          ),
          OverflowBar(
            alignment: MainAxisAlignment.center,
            spacing: 60.0,
            overflowAlignment: OverflowBarAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: const Text('Editar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customColor,
                    foregroundColor: Colors.black,
                    elevation: 3,
                  ),
                  onPressed: () => Navigator.pushNamed(
                    context,
                    EditBookPageNew.routeName,
                    arguments: EditBookPageArguments(book["isbn"]!),
                  ),
                ),
              ),

              // Condicional para mostrar diferentes botones según el estado del libro
              if (book["status"] != "disponible")
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.info),
                    label: const Text('Préstamo'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: customColor,
                      foregroundColor: Colors.black,
                      elevation: 3,
                    ),
                    onPressed: () => Navigator.pushNamed(
                      context,
                      infoLoanPageNew.routeName,
                      arguments: infoLoanPageArguments(
                          book["lenderId"]!,
                          book["userId"]!,
                          book["isbn"]!,
                          book["loanDate"]!,
                          book["returnDate"]!),
                    ),
                  ),
                )
              else ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.delete),
                    label: const Text('Eliminar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: customColor,
                      foregroundColor: Colors.black,
                      elevation: 3,
                    ),
                    onPressed: () {
                      deleteBook(book["isbn"]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.bookmark),
                    label: const Text("prestamo"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: customColor,
                      foregroundColor: Colors.black,
                      elevation: 3,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/registerLoan',
                        arguments: book["isbn"],
                      );
                    },
                  ),
                ),
              ],
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.info_outline),
                  label: const Text('Detalles'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customColor,
                    foregroundColor: Colors.black,
                    elevation: 3,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/informationBook',
                      arguments: book,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class myAppBarWidget extends StatelessWidget {
  final Color customColor;
  final Color backgroundColorOptions;
  final _authService = AuthenticationService();
  myAppBarWidget(
      {super.key,
      required this.customColor,
      required this.backgroundColorOptions});
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: LayoutBuilder(
              builder: (context, constraints) {
                // Calcular el ancho disponible para los botones
                double buttonWidth = (constraints.maxWidth - 2 * 16) / 3;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: buttonWidth,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: backgroundColorOptions,
                          foregroundColor: Colors.black,
                          side: BorderSide(
                            color: customColor, // Color del borde
                            width: 3, // Ancho del borde
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, NewUserTypeSelectionPage.routeName);
                        },
                        child: const Text('Agregar usuario'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: buttonWidth,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: backgroundColorOptions,
                          foregroundColor: Colors.black,
                          side: BorderSide(
                            color: customColor, // Color del borde
                            width: 3, // Ancho del borde
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, ViewUsersPage.routeName);
                        },
                        child: const Text('Usuarios'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: buttonWidth,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: backgroundColorOptions,
                          foregroundColor: Colors.black,
                          side: BorderSide(
                            color: customColor, // Color del borde
                            width: 3, // Ancho del borde
                          ),
                        ),
                        onPressed: () {
                          // Acción al agregar libro
                          Navigator.pushNamed(context, '/registerBook');
                        },
                        child: const Text('Agregar libro'),
                      ),
                    ),
                  ],
                );
              },
            ),
            centerTitle: true,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: IconButton(
                  icon: const Icon(Icons.logout_outlined),
                  color: Colors.black,
                  onPressed: () {
                    _authService.signOut(context);
                  }, // Acción al cerrar sesión

                  iconSize: 30,
                ),
              ),
            ],
          ),
          Container(
            height: 2,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
