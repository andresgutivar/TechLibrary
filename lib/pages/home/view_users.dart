import 'package:biblioteca/models/user.dart';
import 'package:biblioteca/pages/home/view_user_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

class ViewUsers extends StatelessWidget {
  const ViewUsers({super.key});
  static const Color customColor = Color.fromARGB(210, 81, 232, 55);
  static const Color backgroundColorOptions = Color(0xfff8FFF7C);

  Stream<List<Map<String, dynamic>>> streamUsers() {
    return FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  stream: streamUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('No users found');
                    } else {
                      return Column(
                        children: snapshot.data!.map((user) {
                          return _buildTileCard(context, user);
                        }).toList(),
                      );
                    }
                  },
                ),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
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
                      'Volver',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
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
                  color: customColor), // Color del borde al tener foco
            ),
          ),
          onChanged: (value) {
            // Aquí puedes manejar el cambio de texto
          },
        ),
      ),
    );
  }

  Widget _buildTileCard(BuildContext context, Map<String, dynamic> user) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ExpansionTileCard(
        baseColor: backgroundColorOptions,
        expandedColor: backgroundColorOptions,
        title: Text(user['name'] + ' ' + user['lastName']),
        subtitle: Text(user['dni']),
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
                    icon: const Icon(Icons.info),
                    label: const Text('Más información'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: customColor,
                      foregroundColor: Colors.black,
                      elevation: 3,
                    ),
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewUserDetail(),
                            settings: RouteSettings(
                              arguments:
                                  user, // Pass the User object as an argument
                            ),
                          ),
                        )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
