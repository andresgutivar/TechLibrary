import 'package:biblioteca/models/user_book_model.dart';
import 'package:biblioteca/pages/user-book/edit_users/edit_user_page.dart';
import 'package:biblioteca/pages/user-book/edit_users/edit_user_page_arguments.dart';
import 'package:biblioteca/pages/user-book/view_users/view_user_detail_page_arguments.dart';
import 'package:biblioteca/pages/user-book/view_users/view_user_detail_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

class ViewUsersPage extends StatefulWidget {
  static const routeName = '/viewUsers';

  static const Color customColor = Color.fromARGB(210, 81, 232, 55);
  static const Color backgroundColorOptions = Color.fromRGBO(143, 255, 124, 1);

  const ViewUsersPage({super.key});

  @override
  State<ViewUsersPage> createState() => _ViewUsersPageState();
}

class _ViewUsersPageState extends State<ViewUsersPage> {
  late Stream<List<Map<String, dynamic>>> usersFromFilter;

  Stream<List<Map<String, dynamic>>> usersFromDB = FirebaseFirestore.instance
      .collection('usersBook')
      .snapshots()
      .map((snapshot) {
    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  });
  void deleteUser(dni) {
    FirebaseFirestore.instance
        .collection(UserBookModel.tableName)
        .doc(dni)
        .delete()
        .then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }

  @override
  void initState() {
    super.initState();
    usersFromFilter = usersFromDB;
  }

  @override
  Widget build(BuildContext context) {
    // final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance
    //     .collection(UserBookModel.tableName)
    //     .withConverter(
    //       fromFirestore: UserBookModel.fromFirestore,
    //       toFirestore: (UserBookModel user, options) => user.toFirestore(),
    //     )
    //     .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios registrados'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16),
                _buildSearchBar(), // Coloca el SearchBar aquí

                StreamBuilder<List<Map<String, dynamic>>>(
                  stream: usersFromFilter,
                  builder: (context, usersFromFilterData) {
                    if (usersFromFilterData.hasError) {
                      return Text('Error: ${usersFromFilterData.error}');
                    } else if (!usersFromFilterData.hasData &&
                        usersFromFilterData.connectionState !=
                            ConnectionState.waiting) {
                      return Text(
                          'Error al cargar los datos. Existe un problema con la aplicacion. Contactese con los encargados de la aplicacion.');
                    } else {
                      // Si no hay errores y los datos estan cargados
                      if (usersFromFilterData.data != null) {
                        return ListView(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8.0),
                            children: [
                              Column(
                                children: usersFromFilterData.data!.map((user) {
                                  return _buildTileCard(context, user);
                                }).toList(),
                              )
                            ]);
                      } else {
                        if (usersFromFilterData.connectionState ==
                            ConnectionState.done) {
                          return Text("No se encontraron datos");
                        } else {
                          return CircularProgressIndicator();
                        }
                      }
                    }
                  },
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
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
                  color: ViewUsersPage
                      .customColor), // Color del borde al tener foco
            ),
          ),
          onChanged: (value) {
            setState(() {
              usersFromFilter = usersFromDB.map((books) {
                return books.where((book) {
                  return book["name"]
                          .toLowerCase()
                          .contains(value.toLowerCase()) ||
                      book["lastName"]
                          .toLowerCase()
                          .contains(value.toLowerCase()) ||
                      book["dni"].contains(value);
                }).toList();
              });
            });
          },
        ),
      ),
    );
  }

  Widget _buildTileCard(BuildContext context, Map<String, dynamic> user) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ExpansionTileCard(
        baseColor: ViewUsersPage.backgroundColorOptions,
        expandedColor: ViewUsersPage.backgroundColorOptions,
        title: Text(user["name"]! + ' ' + user["lastName"]!),
        subtitle: Text(user["dni"]!),
        children: <Widget>[
          const Divider(
            thickness: 1.0,
            height: 1.0,
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
                  label: const Text('Editar usuario'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ViewUsersPage.customColor,
                    foregroundColor: Colors.black,
                    elevation: 3,
                  ),
                  onPressed: () => Navigator.pushNamed(
                    context,
                    EditUserPage.routeName,
                    arguments: EditUserPageArguments(user),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text('Eliminar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ViewUsersPage.customColor,
                    foregroundColor: Colors.black,
                    elevation: 3,
                  ),
                  onPressed: () => showDialog<String>(
                    context: context,
                    barrierDismissible: false,
                    useRootNavigator: false,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Estas segura?'),
                      content: const Text(
                          'Estas segura que deseas eliminar este usuario junto con todos sus datos? ten en cuenta que la informacion no podra recuperarse..'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () => [
                            deleteUser(user["dni"]),
                            Navigator.pop(context, 'Cancel')
                          ],
                          child: const Text('Aceptar'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.info),
                  label: const Text('Más información'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ViewUsersPage.customColor,
                    foregroundColor: Colors.black,
                    elevation: 3,
                  ),
                  onPressed: () => Navigator.pushNamed(
                    context,
                    ViewUserDetailPage.routeName,
                    arguments: ViewUserDetailPageArguments(user["dni"]!),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
